//
//  CYHomeViewController.m
//  茶语
//
//  Created by Chayu on 16/6/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeViewController.h"
#import "CYHomeBannerCell.h"
#import "CYHomeChaPingCell.h"
#import "CYHomeShiJiCell.h"
#import "CYHomeQuanZiCell.h"
#import "CYHomeWenZhangCell.h"
#import "CYDaoHangViewController.h"
#import "CYSouSuoHomeViewController.h"
#import "CYMyViewController.h"
#import "CYHomeInfo.h"
#import "CYTeaCategoryInfo.h"
#import "CYEvaListViewController.h"
#import "CYProductDetViewController.h"
#import "CYTopicDetailController.h"
#import "CYWenZhangDetailsController.h"
#import "CYTeaMallCollectionViewController.h"
#import "CYMasterDetailViewController.h"
#import "CYBuyerDetailVC.h"
#import "CYQuanZiDetailController.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYTeaSampleDetailViewController.h"
#import "CYYinDaoView.h"
#import "CYWenZhangHeJiViewController.h"
#import "CYBannerView.h"
@interface CYHomeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CYHomeInfo *mHomeInfo;

@property (nonatomic,strong)CYYinDaoView *yindaoView;


- (IBAction)gotodaohang_click:(id)sender;


- (IBAction)sousuo_click:(id)sender;


- (IBAction)usercenter_click:(id)sender;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_cons;



@end

@implementation CYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bottom_cons.constant = 65*(SCREEN_WIDTH/375.);
    [self creatkongNavBar];
    [self loadHomeData];
    __weak __typeof(self) weakSelf = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showyindao) name:@"SHOWYINDAOVIEW" object:nil];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHomeData];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:NO animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self loadHomeData];
}


-(void)showyindao
{
    ChaYuer *manager = [ChaYuManager getCurrentUser];
    if (!manager.isShowYinDao) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WINDOW addSubview:self.yindaoView];
        });
    }
    manager.isShowYinDao = YES;
    [ChaYuManager archiveCurrentUser:manager];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick beginLogPageView:@"茶语首页"];
    [APP_DELEGATE setTabbarHidden:NO animated:animated];
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"茶语首页"];
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        [self loadHomeData];
    });
}
- (CYYinDaoView *)yindaoView
{
    if (!_yindaoView) {
        _yindaoView = [[[NSBundle mainBundle] loadNibNamed:@"CYYinDaoView" owner:nil options:nil] firstObject];
        _yindaoView.frame = self.view.bounds;
        _yindaoView.y = 20;
        _yindaoView.height = SCREEN_HEIGHT-20;
    }
    return _yindaoView;
}



#pragma mark - self defined methods
- (void)loadHomeData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"3" forKey:@"version"];
    [CYWebClient Post:@"home_info" parametes:params success:^(id responObject) {
        [_tableView.header endRefreshing];
        self.mHomeInfo = [CYHomeInfo objectWithKeyValues:responObject];
        //初始化banner
        CYBannerView *bannerView = [[CYBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170*SCREENBILI) pageType:CYPageTypeHaveTitle bannerArr:self.mHomeInfo.slide];
        [bannerView  touchImageIndexBlock:^(NSInteger index) {
            NSLog(@"%ld",(long)index);
            [self selectBanner:index];
        }];
        self.tableView.tableHeaderView = bannerView;
        [self.tableView reloadData];
    } failure:^(id error) {
        [_tableView.header endRefreshing];
    }];
    
}

#pragma mark - Banner select
- (void)selectBanner:(NSInteger )index{
    
    CYHomeSlideInfo *info = self.mHomeInfo.slide[index];
    
    __weak __typeof(self) weakSelf = self;
    NSInteger resource_type = [info.resource_type integerValue];
    switch (resource_type) {
        case 1:
        {
            CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
            vc.wenzhangId = info.resource_id;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
            vc.goodId = info.resource_id;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            CYQuanZiDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYQuanZiDetailController"];
            vc.gid = info.resource_id;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        {
            CYTopicDetailController *vc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
            vc.tid = info.resource_id;
            vc.gid = [[info.source objectForKey:@"gid"] description];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:
        {
            
            break;
        }
        case 6:
        {
            CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
            vc.mTeaId = info.resource_id;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7:
        {
            CYTeaSampleDetailViewController *vc =viewControllerInStoryBoard(@"CYTeaSampleDetailViewController", @"Eva");
            vc.mSampleid = info.resource_id;
            //                        vc.teaId = _mTeaId;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 8:
        {
            NSInteger type = [[info.source objectForKey:@"type"]integerValue];
            if (type<11) {
                CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
                vc.uid = info.resource_id;
                if (type == 9) {
                    vc.isMaster = YES;
                }else if(type == 10){
                    vc.isMaster = NO;
                }
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{//茗星
                CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
                vc.seller_uid = info.resource_id;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
        case 9:
        case 11:
        {
            NSInteger type = [[info.source objectForKey:@"type"]integerValue];
            CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
            if (type == 1) {//聚合 商品
                vc.type = CYCollectionTypeCommodity;
            }else{//聚合 人物
                vc.type = CYCollectionTypeCharacter;
            }
            vc.juhe_id = info.resource_id;;
            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 10:
        {
            CYWenZhangHeJiViewController *vc= viewControllerInStoryBoard(@"CYWenZhangHeJiViewController", @"WenZhang");
            vc.hejiId = info.resource_id;;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
    
    
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 126.;
            break;
        case 1:
            return 40 +285*SCREENBILI;
            break;
        case 2:
            return 40 +234*SCREENBILI;
            break;
        case 3:
            return 123;
            break;
        default:
            return 0.;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            __weak __typeof(self) weakSelf = self;
            CYHomeChaPingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHomeChaPingCell"];
            [cell parseData:self.mHomeInfo.chapingList];
            cell.gotosomeViewBlock = ^(CYTeaCategoryInfo *info){
                CYEvaListViewController *vc = viewControllerInStoryBoard(@"CYEvaListViewController", @"Eva");
                vc.teaCateStr = info.name;
                vc.bid = info.bid;
                vc.isPingPai = NO;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            
            return cell;
            break;
        }
        case 1:
        {
            __weak __typeof(self) weakSelf = self;
            CYHomeShiJiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHomeShiJiCell"];
            [cell parseData:self.mHomeInfo.shiji];
            cell.gengduoBlock =^(){
                //                [self.navigationController popToRootViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
            };
            cell.gotosomeViewBlock = ^(CYHomeMarkertInfo *info){
                NSInteger resource_type = [info.resource_type integerValue];
                if (resource_type == 8) {// 人物
                    NSInteger type = [[info.source objectForKey:@"gid"]integerValue];
                    if (type<11) {
                        CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
                        vc.uid = info.resource_id;
                        if (type == 9) {
                            vc.isMaster = YES;
                        }else if(type == 10){
                            vc.isMaster = NO;
                        }
                        
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{//茗星
                        CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
                        vc.seller_uid = info.resource_id;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                }
                
                if (resource_type == 2) {//商品
                    CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                    vc.goodId = info.resource_id;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
                
                if (resource_type == 9 || resource_type == 11) {//合集
                    NSInteger type = [[info.source objectForKey:@"type"]integerValue];
                    CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
                    if (type == 1) {//聚合 商品
                        vc.type = CYCollectionTypeCommodity;
                    }else{//聚合 人物
                        vc.type = CYCollectionTypeCharacter;
                    }
                    vc.juhe_id = info.resource_id;;
                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
            };
            return cell;
            break;
        }
        case 2:
        {
            
            //            1文章 2商品 3圈子 4话题 5专题 6茶评 7茶样 8人物 9合集
            CYHomeQuanZiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHomeQuanZiCell"];
            [cell parseData:self.mHomeInfo.group];
            cell.gengduoBlock =^(){
                [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"3"}];
            };
            cell.gotosomeViewBlock = ^(CYHomeQuanInfo *info){
                NSInteger resource_type = [info.resource_type integerValue];
                if (resource_type == 4) {
                    CYTopicDetailController *vc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
                    vc.tid = info.resource_id;
                    vc.gid = [[info.source objectForKey:@"gid"] description];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                if (resource_type == 3) {
                    CYQuanZiDetailController *vc =viewControllerInStoryBoard(@"CYQuanZiDetailController", @"BBS");
                    vc.gid = info.resource_id;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                
                
                
            };
            return cell;
            break;
        }
        case 3:
        {
            CYHomeWenZhangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHomeWenZhangCell"];
            [cell parseData:self.mHomeInfo.article];
            cell.gengduoBlock =^(){
                [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"4"}];
            };
            cell.gotosomeViewBlock = ^(CYHomeToDayNewsInfo *info){
                CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
                vc.wenzhangId = info.resource_id;
                [self.navigationController pushViewController:vc animated:YES];
            };
            return cell;
            break;
        }
            
        default:
            return nil;
            break;
    }
    
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (IBAction)gotodaohang_click:(id)sender {
    CYDaoHangViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYDaoHangViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sousuo_click:(id)sender {
    CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)usercenter_click:(id)sender {
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}
@end
