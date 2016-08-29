//
//  CYTopicDetailController.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTopicDetailController.h"
#import "CYCmmtTopicController.h"
#import "CYActionSheet.h"
#import "AppDelegate.h"
#import "CYTopicCommentsController.h"
#import "CYHuaTiDetTopCell.h"
#import "CYHuaTiDetLikeCell.h"
#import "CYHuaTiDetContentCell.h"
#import "CYPostCardViewController.h"
#import "CYCmmtTopicController.h"
#import "CYHuaTiDetCommentCell.h"
#import "CYQuanZiAllCommentVC.h"
#import "CYPublicPostCardController.h"
#import "CYCmmtTopicController.h"
#import "CYQuanZiCommentView.h"
#import "PreviewViewController.h"

@interface CYTopicDetailController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate, CYQuanZiCommentViewDelegate>{
    NSDictionary *detailsInfo;
    CGFloat secHeight;
    CGFloat commentHeight;
    OSMessage *message;

}

- (IBAction)shoucang_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *soucangBtn;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic, strong) CYQuanZiCommentView * commentView;


- (IBAction)zan_click:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)goback:(id)sender;



- (IBAction)fatie_click:(id)sender;

- (IBAction)huitie_click:(id)sender;

@end

@implementation CYTopicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"话题详情";
    message = [[OSMessage alloc] init];
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    _tableView.hidden = YES;
    _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH,1);
    _tableView.tableHeaderView = _webView;
    _tableView.tableFooterView = self.commentView;
    secHeight = 1.;
    commentHeight = 0.;
    [self loadhuatixiangqingData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}


-(void)loadhuatixiangqingData
{
    if (_tid.length) {
        
        [SVProgressHUD showWithStatus:@"加载中..."];
        
        [CYWebClient basePost:@"bbs_topic_detail" parametes:@{@"tid":_tid} success:^(id responObject) {
            NSInteger state = [[responObject objectForKey:@"state"] integerValue];
            NSDictionary *data = [responObject objectForKey:@"data"];
            if (state == 400) {
                [SVProgressHUD dismiss];
                if ([data isKindOfClass:[NSDictionary class]]) {
                    _gid = [[data objectForKey:@"gid"] description];
                    detailsInfo = [NSDictionary dictionaryWithDictionary:data];
                    BOOL isFavorate = [[detailsInfo objectForKey:@"isFavorate"] integerValue] ==1?YES:NO;
                    _soucangBtn.selected = isFavorate;
                    BOOL isSuported = [[detailsInfo objectForKey:@"isSuported"] integerValue] ==1?YES:NO;
                    _zanBtn.selected = isSuported;
                    NSString *content = [detailsInfo objectForKey:@"content"];
                    
                    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
                    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
                    [SVProgressHUD show];
                    
                    [_webView loadHTMLString:content baseURL:[NSURL URLWithString:@"http://app.chayu.com"]];
                    [_tableView reloadData];
                    
                    NSDictionary * shareInfo = [data objectForJSONKey:@"share"];
                    if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0)
                    {
                        message.title = [shareInfo objectForJSONKey:@"title"];
                        message.desc = [shareInfo objectForJSONKey:@"description"];
                        message.link = [shareInfo objectForJSONKey:@"url"];
                        message.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
                    }
                }
                _tableView.hidden = NO;
            }
       
        } failure:^(id error) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"话题详情"];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"话题详情"];
}


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSArray *youlike = [detailsInfo objectForJSONKey:@"youlike"];
        if (youlike.count>0) {
            return (youlike.count *35 +51);
        }
        return 51.;
        }
    else
    {
        return commentHeight;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        CYHuaTiDetTopCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CYHuaTiDetTopCell"];
////        NSString *
////        cell.showImg
//        return cell;
//    }else if (indexPath.section == 1){
//        CYHuaTiDetContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHuaTiDetContentCell"];
////        if (!cell.webView.sizeDelegate) {
//            cell.webView.sizeDelegate = self;
//            NSString *content = [detailsInfo objectForKey:@"content"];
//            cell.contentStr = content;
////        }
//        
//        return cell;
//    }else if(indexPath.section == 2){
        CYHuaTiDetLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHuaTiDetLikeCell"];
        cell.likeArr = [detailsInfo objectForJSONKey:@"youlike"];
        cell.selecthuatiBlock = ^(NSString *tid){
//            _tid = tid;
            
            CYTopicDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYTopicDetailController"];
            vc.tid = tid;
            vc.gid = @"";
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    else
    {
        CYHuaTiDetCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHuaTiDetCommentCell"];
//        cell.delegate = self;
        cell.topicId = _tid;
        cell.reloadBlock = ^(CGFloat height)
        {
            commentHeight = height;
//            [tableView reloadSections:[NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    }
}

#pragma mark -
#pragma mark CYBuyerEvaluationViewDelegate method
- (void)evaluationViewendHeight:(CGFloat)endheight
{
    self.tableView.tableFooterView = self.commentView;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)fatie_click:(id)sender {
    CYPostCardViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYPostCardViewController"];
    vc.gid = _gid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)huitie_click:(id)sender {
    CYCmmtTopicController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYCmmtTopicController"];
    vc.tid = _tid;
    vc.callback = ^(NSInteger count){
        [self.commentView loadTableViewData:NO];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)shoucang_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient Post:@"favorite" parametes:@{@"itemid":_tid,@"type":@"4"} success:^(id responObject) {
        
        if ([[responObject objectForKey:@"do"] integerValue] ==0) {
            _soucangBtn.selected = NO;
        }else{
            
            _soucangBtn.selected = YES;
        }
    } failure:^(id error) {
        
    }];
}
- (IBAction)zan_click:(id)sender {
    
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    NSString *class = _zanBtn.selected?@"0":@"1";
    [CYWebClient Post:@"do_suport" parametes:@{@"itemid":_tid,@"type":@"4",@"class":class} success:^(id responObject) {
        if ([[responObject objectForKey:@"do"] integerValue] ==0) {
            _zanBtn.selected = NO;
        }else{
            _zanBtn.selected = YES;
        }
    } failure:^(id error) {
        
    }];
}

- (void)seeFullScreenClicked:(CYQuanZiCommentModel *)model currentPage:(NSInteger)index
{
    UIViewController* vc = viewControllerInStoryBoard(@"PreviewViewController", @"Main");
    if(model.attach.count)
    {
        NSMutableArray * imgArr = [NSMutableArray array];
        
        for(int i = 0; i < model.attach.count; i ++)
        {
            NSString * url = model.attach[i];
            
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            
            [dic setObject:url forKey:@"PictureUrl"];
            
            [imgArr addObject:dic];
        }
        
        ((PreviewViewController*)vc).dataArray = imgArr;

    }
    ((PreviewViewController*)vc).currentPage = index;
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)commentBtnClicked:(CYQuanZiCommentModel *)model
{
//    __weak __typeof(self) weakSelf = self;
    
    CYCmmtTopicController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYCmmtTopicController"];
    vc.tid = model.tid;//话题ID
    vc.rpid = model.pid;//回复ID
    vc.callback = ^(NSInteger count){
        [self.commentView loadTableViewData:NO];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//-(void)bbweb:(BBWebView *)web didAdjustSizeTo:(CGSize)endSize from:(CGSize)startSize
//{
//    if (endSize.height>startSize.height)
//    {
//        NSLog(@"endSize.height = %.2f",endSize.height);
//        _webView.height = endSize.height;
//        _tableView.tableHeaderView = _webView;
//    }
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _webView.height = webView.scrollView.contentSize.height;
        NSLog(@"webview.height = %.2f",_webView.height);
        _tableView.tableHeaderView = _webView;
    });

}

- (void)showAllEvaluation
{
    CYQuanZiAllCommentVC * vc = viewControllerInStoryBoard(@"CYQuanZiAllCommentVC", @"BBS");
    vc.topicId = _tid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)huitie_click
{
    [self huitie_click:nil];
}



- (IBAction)share_click:(id)sender {
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:message];
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
            
        default:
            break;
    }
    
}


- (CYQuanZiCommentView *) commentView
{
    if(!_commentView)
    {
        _commentView = [[[NSBundle mainBundle] loadNibNamed:@"CYQuanZiCommentView" owner:nil options:nil] firstObject];
        _commentView.delegate = self;
        _commentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        _commentView.pageSize = 10;
        _commentView.topicId = _tid;
    }
    
    return _commentView;
}

@end
