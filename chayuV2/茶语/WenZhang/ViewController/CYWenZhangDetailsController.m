//
//  CYWenZhangDetailsController.m
//  茶语
//
//  Created by Chayu on 16/7/15.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWenZhangDetailsController.h"
#import "BBWebView.h"
#import "CYPublicPostCardController.h"
#import "CYWenZhangCommentCell.h"
#import "CYWenZhangAllCommentsVC.h"
#import "CYWenZhangCommentView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CYQuanZiDetailController.h"
#import "CYTopicDetailController.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYTeaSampleDetailViewController.h"
#import "CYMasterDetailViewController.h"
#import "CYBuyerDetailVC.h"
#import "CYProductDetViewController.h"
#import "CYTeaMallCollectionViewController.h"
#import "CYBuyerAlbumVC.h"
#import "CYWenZhangHeJiViewController.h"
@interface CYWenZhangDetailsController ()<UIWebViewDelegate,CYWenZhangCommentViewDelegate,UIWebViewDelegate>
{
    NSMutableDictionary *info;
    
    CGFloat commentHeight;
    OSMessage *message;
    BOOL isLoadingFinished;
    NSString *htmlStr;
    
}
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic, strong) CYWenZhangCommentView * commentView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,weak) JSContext * context;


- (IBAction)pinglun_click:(id)sender;

- (IBAction)goback:(id)sender;
- (IBAction)shoucang_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
- (IBAction)zan_click:(id)sender;

@end

@implementation CYWenZhangDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    message = [[OSMessage alloc] init];
    _tableView.hidden = YES;
    //    _webView.delegate = self;
    //    self.webView.sizeDelegate = self;
    isLoadingFinished = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _tableView.tableHeaderView = self.webView;
        _tableView.tableFooterView.hidden = YES;
    });
    hiddenSepretor(_tableView);
    [self loadViewsData];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick beginLogPageView:@"文章详情"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"文章详情"];
}


-(void)loadViewsData
{
    if (_wenzhangId.length) {
        
        [CYWebClient Post:@"2.0_article.detail" parametes:@{@"id":_wenzhangId} success:^(id responObject) {
            //            NSInteger state = [[responObject objectForKey:@"state"] integerValue];
            //            NSDictionary *data = [responObject objectForKey:@"data"];
            //            if (state == 400) {
            NSDictionary * shareInfo = [responObject objectForJSONKey:@"share"];
            if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0)
            {
                message.title = [shareInfo objectForKey:@"title"];
                message.link = [shareInfo objectForKey:@"url"];
                message.desc = [shareInfo objectForKey:@"description"];
                message.imgUrl  = [shareInfo objectForKey:@"thumb"];
            }
            
            info = [NSMutableDictionary dictionaryWithDictionary:responObject];
            BOOL isFavorate = [[info objectForKey:@"isFavorate"] integerValue] ==1?YES:NO;
            _shoucangBtn.selected = isFavorate;
            BOOL isSuported = [[info objectForKey:@"isSuported"] integerValue] ==1?YES:NO;
            _zanBtn.selected = isSuported;
            htmlStr = [info objectForKey:@"html"];
            
            [SVProgressHUD setBackgroundColor:CLEARCOLOR];
            [SVProgressHUD setForegroundColor:[UIColor blackColor]];
            [SVProgressHUD show];
            [self.webView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@"http://app.chayu.com"]];
            
            
            //            }
            
            
        } failure:^(id error) {
            
        }];
    }
}


- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}

- (CYWenZhangCommentView *) commentView
{
    if(!_commentView)
    {
        _commentView = [[[NSBundle mainBundle] loadNibNamed:@"CYWenZhangCommentView" owner:nil options:nil] firstObject];
        _commentView.delegate = self;
        _commentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        _commentView.pageSize = 10;
        _commentView.itemid = _wenzhangId;
    }
    
    return _commentView;
}

#pragma mark -
#pragma mark CYBuyerEvaluationViewDelegate method
- (void)evaluationViewendHeight:(CGFloat)endheight
{
    self.tableView.tableFooterView.hidden = NO;
    self.tableView.tableFooterView = self.commentView;
    //    
    //    if(count)
    //    {
    //        _titleLbl.text = [NSString stringWithFormat:@"评论(%ld)", count];
    //    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _context[@"supperUrl"] = ^(){
        NSArray * args = [JSContext currentArguments];
        //        1.文章  2.圈子 3.话题 4.专题 5.茶评 6.茶样 7.大师详情 8.名家详情 9.茗星详情 10.市集商品 11.茗星商品 12.分销商品 13.商品聚合 14.人物聚合 15.明星商品聚合 16.明星任务聚合
        NSLog(@"args%@",args);
        if ([args count]<2) {
            return ;
        }
        NSString *typeStr  = [args[0] description];
        NSInteger type = [typeStr integerValue];
        NSString *publicId = [args[1] description];
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (type) {
                    
                case 1:
                {
                    CYWenZhangDetailsController *vc =viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
                    vc.wenzhangId = publicId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 2:
                {
                    CYQuanZiDetailController *vc = viewControllerInStoryBoard(@"CYQuanZiDetailController", @"BBS");
                    vc.gid =publicId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3:
                {
                    CYTopicDetailController *vc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
                    ;
                    vc.tid = publicId;
                    vc.gid = @"";
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 4:
                {
                    CYWenZhangDetailsController *vc =viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
                    vc.wenzhangId = publicId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 5:
                {
                    CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
                    vc.mTeaId = publicId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 6:
                {
                    CYTeaSampleDetailViewController *vc =viewControllerInStoryBoard(@"CYTeaSampleDetailViewController", @"Eva");
                    vc.mSampleid = publicId;
                    vc.teaId = @"";
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 7:
                case 8:
                {
                    CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
                    //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYMasterDetailViewController"];
                    vc.uid = publicId;
                    if (type == 7) {
                        vc.isMaster = YES;
                    }else{
                        vc.isMaster = NO;
                    }
                    
                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                case 9:
                {
                    CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
                    vc.seller_uid = publicId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 10:
                case 11:
                case 12:
                {
                    CYProductDetViewController *vc = viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                    vc.goodId = publicId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 13:
                case 14:
                {
                    CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
                    
                    if (type== 13) {//聚合 商品
                        vc.type = CYCollectionTypeCommodity;
                    }else{//聚合 人物
                        vc.type = CYCollectionTypeCharacter;
                    }
                    vc.juhe_id = publicId;
                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 15:
                case 16:
                {
                    CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
                    if (type == 16) {//聚合 人物
                        vc.type = CYCollectionTypeCharacter;
                        
                    }else{//聚合 商品
                        vc.type = CYCollectionTypeCommodity;
                    }
                    vc.juhe_id = publicId;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    break;
                }
                case 17:
                {
                    CYWenZhangHeJiViewController *vc= viewControllerInStoryBoard(@"CYWenZhangHeJiViewController", @"WenZhang");
                    vc.hejiId = publicId;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    break;
                }
                default:
                    break;
            }
            return ;
        });
        
        
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _webView.height = webView.scrollView.contentSize.height;
        NSLog(@"webview.height = %.2f",_webView.height);
        _tableView.tableHeaderView = _webView;
        _tableView.tableFooterView = self.commentView;
        _tableView.hidden = NO;
        [SVProgressHUD dismiss];
    });
    
}


#pragma mark -
#pragma mark BBWebViewSizeAdjust method
//- (void)bbweb:(BBWebView *)web didAdjustSizeTo:(CGSize)endSize from:(CGSize)startSize
//{
//    if (endSize.height >startSize.height) {
//        self.webView.height = endSize.height;
//        _tableView.tableHeaderView = self.webView;
//        _tableView.tableFooterView = self.commentView;
//          _tableView.hidden = NO;
//    }
//}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
//    [webView stringByEvaluatingJavaScriptFromString:meta];
//
//}


- (IBAction)pinglun_click:(id)sender {
    CYPublicPostCardController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYPublicPostCardController"];
    vc.mItemid = _wenzhangId;
    vc.postcardbackBlock = ^(){
        
        [_commentView loadTableViewData:NO];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shoucang_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient Post:@"favorite" parametes:@{@"itemid":_wenzhangId,@"type":@"1"} success:^(id responObject) {
        
        if ([[responObject objectForKey:@"do"] integerValue] ==0) {
            _shoucangBtn.selected = NO;
        }else{
            
            _shoucangBtn.selected = YES;
        }
    } failure:^(id error) {
        
    }];
    
}
- (IBAction)zan_click:(id)sender {
    
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    NSString *class = _zanBtn.selected?@"0":@"1";
    [CYWebClient Post:@"do_suport" parametes:@{@"itemid":_wenzhangId,@"type":@"1",@"class":class} success:^(id responObject) {
        if ([[responObject objectForKey:@"do"] integerValue] ==0) {
            _zanBtn.selected = NO;
        }else{
            _zanBtn.selected = YES;
        }
    } failure:^(id error) {
        
    }];
}

- (void)huifu_click
{
    [self pinglun_click:nil];
}

- (void)commentBtnClicked:(CYWenZhangCommentModel *)model
{
    //    __weak __typeof(self) weakSelf = self;
    
    CYPublicPostCardController * vc = viewControllerInStoryBoard(@"CYPublicPostCardController", @"WenZhang");
    
    vc.mItemid = model.itemid;//文章ID
    vc.pid = model.commentId;//回复ID
    vc.touid = model.uid;//回复人ID
    //文章评价
    vc.huifutype = HuiFuTypeWenZhang;
    
    vc.postcardbackBlock = ^(){
        [_commentView loadTableViewData:NO];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)share_click:(id)sender {
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:message.imgUrl] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.at = kAuthorizeTypeOpenShare;
        if (image) {
            message.image = UIImageJPEGRepresentation(image, 0.1);
        }else
        {
            message.image = UIImagePNGRepresentation([UIImage imageNamed:@"AppIcon60x60@2x.png"]);
        }
        CYActionSheet *sheet = [[CYActionSheet alloc] initWithTitles:nil iconNames:nil];
        sheet.shareMessage = message;
        [sheet showActionSheetWithClickBlock:^(int btnIndex) {
            
        } cancelBlock:^{
            
        }];
    }];
}


- (IBAction)zhijiefenxiang_click:(UIButton *)sender {
    
    switch (sender.tag) {
        case 320:
        {
            [self sharePengYouQuan:message];
            break;
        }
        case 321:
        {
            [self shareWeiXin:message];
            break;
        }
        case 322:
        {
            [self shareQQ:message];
            break;
        }
        case 2:
        {
            [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:message];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)showAllEvaluation
{
    CYWenZhangAllCommentsVC * vc = viewControllerInStoryBoard(@"CYWenZhangAllCommentsVC", @"WenZhang");
    vc.itemid = _wenzhangId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return commentHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYWenZhangCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWenZhangCommentCell"];
    //    cell.delegate = self;
    cell.wenzhangId = _wenzhangId;
    cell.reloadBlock = ^(CGFloat height)
    {
        commentHeight = height;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
}

@end
