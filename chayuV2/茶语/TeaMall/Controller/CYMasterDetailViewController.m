//
//  CYMasterDetailViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/12.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMasterDetailViewController.h"
//#import "CYProductDetViewController.h"
//#import "CYTeaListViewController.h"
#import "CYBaseViewController+HttpRequest.h"
#import "CYMatserDetailModel.h"
#import "CYGoodsListModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CYMasterDetailCell.h"
#import "CYTeaListViewController.h"
#import "CYProductDetViewController.h"
#import "CYShopTrolleyModel.h"
#import "CYOrderDetailModel.h"
#import "CYConfirmOrderViewController.h"
#import "BaseLable.h"
#import "BBWebView.h"
#import "AppDelegate.h"
#import "UICommon.h"

@interface CYMasterDetailViewController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,BBWebViewSizeAdjust>
{
    NSString *sellerGoodsCount;
    NSString *goodsId;
    UIButton *attendBtn;
    CYMatserDetailModel *data;
    CGFloat infoview_height;
    UIView *headerView;
    BBWebView *infoWeb;
    OSMessage * _shareMsg;
}
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CYMasterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sellerGoodsCount = @"";
     _shareMsg = [[OSMessage alloc] init];
    infoview_height = 0.0;
    goodsId = @"";
    __weak __typeof(self) weakSelf = self;
    [CYWebClient basePost:@"TeaMall_SellerDetail" parametes:@{@"sellerUid":_uid} success:^(id responObj) {
        
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        NSDictionary * dic = [responObj objectForJSONKey:@"share"];
        if ([dic isKindOfClass:[NSDictionary class]] && dic.count >0) {
            _shareMsg.title = [dic objectForJSONKey:@"title"];
            _shareMsg.desc = [dic objectForJSONKey:@"description"];
            _shareMsg.link = [dic objectForJSONKey:@"url"];
            _shareMsg.imgUrl = [dic objectForJSONKey:@"thumb"];
        }

        if (state == 400) {
            NSDictionary *dataInfo = [responObj objectForKey:@"data"];
            data = [CYMatserDetailModel objectWithKeyValues:dataInfo];
            [weakSelf resetHeader];
            [weakSelf.tableView reloadData];
        }
      

   
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
    if (!_isMaster) {
        self.title = @"名家详情";
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"CYMasterDetailCell" bundle:nil] forCellReuseIdentifier:@"MasterDetailCell"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIWebViewDelegate method
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    CGFloat height = webView.scrollView.contentSize.height;
//    CGRect frame = webView.frame;
//    frame.size.height = height;
//    webView.frame = frame;
//    
//    frame = headerView.frame;
//    frame.size.height += height;
//    headerView.frame = frame;
//    
//    self.tableView.tableHeaderView = nil;
//    self.tableView.tableHeaderView = headerView;
}

/*
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request = %@",request);
    NSString *url = [request.URL absoluteString];
    NSLog(@"url = %@",url);
    if([url containsString:@"#dsjj"]){//介绍
        return YES;
    }else
    if ([url containsString:@"appDetail"]){//好茶详情
//        if ([sellerGoodsCount integerValue] == 1) {
//               CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"Classification");
//            vc.goodId = goodsId;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            CYTeaListViewController *vc = viewControllerInStoryBoard(@"CYTeaListViewController", @"Home");
//            vc.uid = _uid;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
     
        return NO;
        
    }else if ([url containsString:@"appAttend"]){//关注
        [self doAttend:_uid];
        return NO;
        
    }
    return YES;
}
*/

#pragma mark -
#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 359*(SCREEN_WIDTH/320);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MasterDetailCell";
    
    NSInteger row = indexPath.row;
    
    CYGoodsListModel *model = data.list[row];
    
    CYMasterDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYMasterDetailCell" owner:nil options:nil] firstObject];
    }
    [cell.iv_pic sd_setImageWithURL:[NSURL URLWithString:model.path] placeholderImage:WIDEIMG];
    cell.lb_name.text = model.name;
    cell.desc.text = model.des;
    
    if (![model.mainid isEqualToString:@"13"]) {
        [cell.detailsBtn setTitle:@"商品详情" forState:UIControlStateNormal];
    }else{
        [cell.detailsBtn setTitle:@"好茶详情" forState:UIControlStateNormal];
    }
    
    cell.gotoGoodsDetails = ^(){
        CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
        vc.goodId = model.goods_id;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.bunowBlock = ^(){
     [self lijigoumai:model];
    };
    
    
    return cell;
}


-(void)lijigoumai:(CYGoodsListModel *)info
{
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    
    CYShopTrolleyModel *model = [[CYShopTrolleyModel alloc] init];
    CGFloat price = [info.price floatValue];
    
    NSString *sellerid = [info.is_self boolValue]?@"1":_uid;
    
    NSString *sellerName = data.sellerName;
    NSString *avatar = data.avatar;
    NSMutableArray *goodsArr = [NSMutableArray array];
    NSMutableArray *detailArr  =[NSMutableArray array];
    model.thumb = info.path;
    model.name = info.goodsname;
    model.goodsNumber = @"1";
    model.goodsId = info.goods_id;
    model.specId = info.spec_id;
    model.specdataId = info.spec_id;
    model.commodityPrice = [NSString stringWithFormat:@"%.2f",price];
    [goodsArr addObject:model];
    NSDictionary *dataInfo = @{@"goodsList":goodsArr,
                           @"commodityCount":@"1",
                           @"seller":@{@"sellerName":sellerName,@"sellerAvatar":avatar,@"sellerUid":sellerid},
                           @"orderPrice":[NSNumber numberWithFloat:price]};
    
    
    CYOrderDetailModel *goodsModel = [CYOrderDetailModel objectWithKeyValues:dataInfo];
    [detailArr addObject:goodsModel];
    CYConfirmOrderViewController *vc = viewControllerInStoryBoard(@"CYConfirmOrderViewController", @"TeaMall");
    vc.dataArr = detailArr;
    vc.confirmtype = CYConfirmOrderTypeBuyNow;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    CYGoodsListModel *model = data.list[row];
    CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    vc.goodId = model.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)seeTouFullClicked
{
    NSMutableArray *imgArr = [NSMutableArray array];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:data.wap_thumb forKey:@"PictureUrl"];
    
    [imgArr addObject:dic];
    
    [UICommon seeFullScreenImage:self.navigationController imageUrlArr:imgArr currentPage:0];
}

- (void)resetHeader
{
    headerView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    
    
    UIView *infoView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
    [bg sd_setImageWithURL:[NSURL URLWithString:data.wap_thumb]];
    
    UIButton * seeTouFullBtn = [[UIButton alloc] initWithFrame:bg.frame];
    seeTouFullBtn.backgroundColor = [UIColor clearColor];
    [seeTouFullBtn addTarget:self action:@selector(seeTouFullClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [infoView addSubview:bg];
    [infoView addSubview:seeTouFullBtn];
    
    CGFloat botton = 40;
    CGFloat btnWidth = (CGRectGetWidth(infoView.frame) - 80.f - 20.f)/3.f;
    CGFloat btnHeight = btnWidth * 0.4f;
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetHeight(infoView.frame) - botton - btnHeight, btnWidth, btnHeight)];
        if ([data.gid isEqualToString:@"9"]) {
            [btn setTitle:@"大师介绍" forState:UIControlStateNormal];
        }else{
             [btn setTitle:@"名家介绍" forState:UIControlStateNormal];
        }
       
        btn.backgroundColor = COLOR(96, 92, 83, 1);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        btn.tag = 101;
        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [infoView addSubview:btn];
    }
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40 + btnWidth + 10, CGRectGetHeight(infoView.frame) - botton - btnHeight, btnWidth, btnHeight)];
        if (![data.mainid isEqualToString:@"13"]) {
            [btn setTitle:@"商品详情" forState:UIControlStateNormal];
        }else{
            [btn setTitle:@"好茶详情" forState:UIControlStateNormal];
        }
   
        btn.backgroundColor = COLOR(96, 92, 83, 1);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.f;
        btn.tag = 102;
        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [infoView addSubview:btn];
        
    
        if ([data.count integerValue]>0) {
            BaseLable *numLble = [BaseLable initWithFrame:CGRectMake(btn.x +btn.width -10,btn.y-10, 20, 20) TxtColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter Font:FONT(10.0) title:data.count];
            numLble.cornerRadius = 10.0;
            numLble.backgroundColor = MAIN_COLOR;
            [infoView addSubview:numLble];
        }
        
    }
    {
        attendBtn = [[UIButton alloc] initWithFrame:CGRectMake(40 + (btnWidth + 10)*2, CGRectGetHeight(infoView.frame) - botton - btnHeight, btnWidth, btnHeight)];
        if ([data.isAttend boolValue]) {
          [attendBtn setTitle:@"已关注" forState:UIControlStateNormal];
        }else{
               [attendBtn setTitle:@"关注" forState:UIControlStateNormal];
        }
        
        attendBtn.backgroundColor = COLOR(96, 92, 83, 1);
        attendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        attendBtn.layer.masksToBounds = YES;
        attendBtn.layer.cornerRadius = 3.f;
        attendBtn.tag = 103;
        [attendBtn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [infoView addSubview:attendBtn];
    }
    
    if ([data.is_video boolValue]) {
        botton += btnHeight;
        btnHeight = 150;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetHeight(infoView.frame) - botton - btnHeight - 20, CGRectGetWidth(infoView.frame) - 80, btnHeight)];
        [btn setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
        //    [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:data.video_thumb] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *videoThumb = [[UIImageView alloc] initWithFrame:btn.frame];
        [videoThumb sd_setImageWithURL:[NSURL URLWithString:data.video_thumb]];
        
        [infoView addSubview:videoThumb];
        [infoView addSubview:btn];
    }
    
    infoview_height =CGRectGetHeight(infoView.frame);
    NSLog(@"%@",NSStringFromCGSize(infoView.frame.size));
    infoWeb = [[BBWebView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(infoView.frame), CGRectGetWidth(infoView.frame), 1)];
    infoWeb.sizeDelegate = self;
    [infoWeb loadHTMLString:data.wap_content baseURL:nil];
    infoWeb.scrollView.scrollEnabled = NO;
//    infoWeb.scalesPageToFit = YES;
    infoWeb.userInteractionEnabled = NO;
    [headerView addSubview:infoView];
    [headerView addSubview:infoWeb];
    
    self.tableView.tableHeaderView = headerView;
    
    
}

- (void)btnTouchUpInside:(UIButton*)sender
{
    switch (sender.tag) {
        case 101:
        {
            //介绍
            [_tableView scrollRectToVisible:CGRectMake(0, CGRectGetHeight(self.tableView.frame), CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.tableView.frame)) animated:YES];
               break;
        }
         
        case 102:
        {
            //好茶
            if ([data.count integerValue] == 1) {
                CYGoodsListModel *model = data.list[0];
                CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                vc.goodId = model.goods_id;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                CYTeaListViewController *vc = viewControllerInStoryBoard(@"CYTeaListViewController", @"TeaMall");
                vc.uid = _uid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
        case 103:
        {
            if (!MANAGER.isLoged) {
                [APP_DELEGATE showLogView];
                return;
            }
            [SVProgressHUD setBackgroundColor:CLEARCOLOR];
            [SVProgressHUD setForegroundColor:[UIColor blackColor]];
            [SVProgressHUD show];
            [CYWebClient Post:@"DoAttend" parametes:@{@"sellerUid":_uid} success:^(id responObj) {
                NSInteger status = [[responObj objectForKey:@"status"] integerValue];
                if (status == 1) {
                    [attendBtn setTitle:@"关注" forState:UIControlStateNormal];
                }else{
                    [attendBtn setTitle:@"已关注" forState:UIControlStateNormal];
                }
                } failure:^(id err) {
                    NSLog(@"%@",err);
            }];
            break;
            
        }
            
        default:
            break;
    }
}

- (void)playVideo:(id)sender
{
    NSLog(@"%@",data.videoPath);
    MPMoviePlayerViewController *movie = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:data.videoPath]];
    
    
    [self presentMoviePlayerViewControllerAnimated:movie];    
    
    [movie.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    
    [movie.view setBackgroundColor:[UIColor clearColor]];
    
    [movie.view setFrame:self.view.bounds];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:movie.moviePlayer];
    
    
    
}

-(void)movieFinishedCallback:(NSNotification*)notify{
    
    // 视频播放完或者在presentMoviePlayerViewControllerAnimated下的Done按钮被点击响应的通知。
    
    MPMoviePlayerController* theMovie = [notify object];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    [self dismissMoviePlayerViewControllerAnimated];
    
}


#pragma mark -
#pragma mark BBWebViewSizeAdjust delegate method
- (void)bbweb:(BBWebView *)web didAdjustSizeTo:(CGSize)endSize from:(CGSize)startSize
{
    if (startSize.height<endSize.height) {
        CGFloat height = endSize.height;
        CGRect frame = web.frame;
        frame.size.height = height;
        infoWeb.frame = frame;
        
        frame = headerView.frame;
        frame.size.height = height+SCREEN_HEIGHT;
        headerView.frame = frame;
        self.tableView.tableHeaderView = nil;
        self.tableView.tableHeaderView = headerView;
    }
    
}

- (IBAction)zhijiefenxiang_click:(UIButton *)sender {
    
    switch (sender.tag) {
        case 320:
        {
            [self sharePengYouQuan:_shareMsg];
            break;
        }
        case 321:
        {
            [self shareWeiXin:_shareMsg];
            break;
        }
        case 322:
        {
            [self shareQQ:_shareMsg];
            break;
        }
        case 2:
        {
            [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
            break;
        }
        default:
            break;
    }
    
}

@end
