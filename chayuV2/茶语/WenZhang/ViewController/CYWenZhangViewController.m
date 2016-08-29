//
//  CYWenZhangViewController.m
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWenZhangViewController.h"
#import "CYWenZhangDefCell.h"
#import "CYWenZhangImgCell.h"
#import "CYWengZhangTypeCell.h"
#import "CYWengZhangTopCell.h"
#import "CYBaseBannerView.h"
#import "CYWenZhangListController.h"
#import "CYHomeInfo.h"
#import "CYWenZhangDetailsController.h"
#import "CYSouSuoHomeViewController.h"
#import "CYDaoHangViewController.h"
#import "CYMyViewController.h"
#import "UICommon.h"
#import "CYShareModel.h"
#import "CYProductDetViewController.h"
#import "CYQuanZiDetailController.h"
#import "CYTopicDetailController.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYTeaSampleDetailViewController.h"
#import "CYMasterDetailViewController.h"
#import "CYBuyerDetailVC.h"
#import "CYTeaMallCollectionViewController.h"
#import "CYWenZhangHeJiViewController.h"
#import "CYBannerView.h"
@interface CYWenZhangViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *bannerArr;
    NSMutableArray *listArr;
    NSMutableArray *dataArr;
    NSInteger page;
    OSMessage *message;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)CYBannerView *bannerView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_cons;


@end

@implementation CYWenZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    message = [[OSMessage alloc] init];
    page = 2;
    __weak __typeof(self) weakSelf = self;
    bannerArr = [NSMutableArray array];
    listArr = [NSMutableArray array];
    dataArr = [NSMutableArray array];
    [self loadData];
    
    _tableView.hidden = YES;
    [self creatkongNavBar];
    _bottom_cons.constant = 65*(SCREEN_WIDTH/375.);
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadListData:NO];
        
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadListData:YES];
    }];
    
}


- (IBAction)gotousercenter_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)gotodaohang_click:(id)sender {
    CYDaoHangViewController *vc = viewControllerInStoryBoard(@"CYDaoHangViewController", @"Home");
    
    //
    //
    //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYDaoHangViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sousuo_click:(id)sender {
    CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick beginLogPageView:@"文章首页"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"文章首页"];
    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        [self loadData];
    });
}

-(void)loadData
{
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"ArticleList" parametes:nil success:^(id responObject) {
        NSDictionary *shareInfo = [responObject objectForKey:@"share"];
        if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
            message.imgUrl = [shareInfo objectForKey:@"thumb"];
            message.link = [shareInfo objectForKey:@"url"];
            message.title = [shareInfo objectForKey:@"title"];
            message.desc = [shareInfo objectForKey:@"description"];
        }
        NSArray *banner = [CYHomeSlideInfo objectArrayWithKeyValuesArray:[responObject objectForKey:@"banner"]];
        [bannerArr removeAllObjects];
        [bannerArr addObjectsFromArray:banner];
        [listArr removeAllObjects];
        [listArr addObjectsFromArray:[responObject objectForKey:@"list"]];
        //初始化banner
        weakSelf.bannerView = [[CYBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170*SCREENBILI) pageType:CYPageTypeHaveTitle bannerArr:bannerArr];
        //点击事件
        [self.bannerView  touchImageIndexBlock:^(NSInteger index) {
            
            [self selectBanner:index];
            
        }];
        weakSelf.tableView.tableHeaderView = weakSelf.bannerView;
        
        //        NSLog(@"weakSelf.bannerView.height = %f",weakSelf.bannerView.height);
        
        [weakSelf loadListData:NO];
    } failure:^(id error) {
        
    }];
}

#pragma mark - Banner select
- (void)selectBanner:(NSInteger )index{
    
    __weak __typeof(self) weakSelf = self;
    CYHomeSlideInfo *info = bannerArr[index];
    NSInteger resource_type = [info.resource_type integerValue];
    switch (resource_type) {
        case 1:
        {
            CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
            vc.wenzhangId = info.resource_id;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
            vc.goodId = info.resource_id;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            CYQuanZiDetailController *vc = viewControllerInStoryBoard(@"CYQuanZiDetailController", @"BBS");
            vc.gid = info.resource_id;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        {
            CYTopicDetailController *vc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
            vc.tid = info.resource_id;
            vc.gid = [[info.source objectForKey:@"gid"] description];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:
        {
            CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
            vc.wenzhangId = info.resource_id;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:
        {
            CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
            vc.mTeaId = info.resource_id;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7:
        {
            CYTeaSampleDetailViewController *vc =viewControllerInStoryBoard(@"CYTeaSampleDetailViewController", @"Eva");
            vc.mSampleid = info.resource_id;
            //                        vc.teaId = _mTeaId;
            [weakSelf.navigationController pushViewController:vc animated:YES];
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
            [weakSelf.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 10:
        {
            CYWenZhangHeJiViewController *vc= viewControllerInStoryBoard(@"CYWenZhangHeJiViewController", @"WenZhang");
            vc.hejiId = info.resource_id;;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    
}

-(void)loadListData:(BOOL)loadMore
{
    
    if (loadMore) {
        page ++;
    }else{
        page =2;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"2.0_article.index.lists" parametes:@{@"pageNo":@(page),@"pageSize":@"10"} success:^(id responObject) {
        NSArray *arr = responObject;
        weakSelf.tableView.hidden = NO;
        if (!loadMore) {
            [dataArr removeAllObjects];
            [_tableView reloadData];
        }
        if (loadMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
        
        if ([arr count]<10) {
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
        
        
        if (arr.count) {
            [dataArr addObjectsFromArray:responObject];
            [_tableView reloadData];
        }
        
        if (dataArr.count<10) {
            weakSelf.tableView.footer = nil;
        }
        
    } failure:^(id error) {
        
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:NO animated:animated];
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


#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return [listArr count];
    }else{
        return [dataArr count];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 61;
    }else if(indexPath.section == 1){
        NSDictionary *info = listArr[indexPath.row];
        //        if ([info isKindOfClass:[NSDictionary class]] && [info count]>0) {
        NSInteger type = [[info objectForKey:@"show_type"] integerValue];
        switch (type) {
            case 1:
                return 99.0;
                break;
            case 2:
                return 194.0;
                break;
            case 3:
                return 156.0*SCREENBILI;
                break;
            default:
                return 0.0;
                break;
        }
        //        }
        //        return 0.0;
        
        
    }else{
        return 99.0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CYWengZhangTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWengZhangTopCell"];
        cell.menuclickBlock = ^(NSInteger selectIndex){
            CYWenZhangListController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYWenZhangListController"];
            if (selectIndex == 0) {
                vc.wenzhangtype = WenZhangListTypeNew;
            }else if (selectIndex == 1){
                vc.wenzhangtype = WenZhangListTypeHot;
            }else{
                vc.wenzhangtype = WenZhangListTypeZhuanTi;
            }
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else if(indexPath.section == 1){
        NSDictionary *info = listArr[indexPath.row];
        //    if ([info isKindOfClass:[NSDictionary class]] && [info count]>0) {
        NSInteger type = [[info objectForKey:@"show_type"] integerValue];
        switch (type) {
            case 1:
            {
                CYWenZhangDefCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWenZhangDefCell"];
                cell.info = info;
                return cell;
                break;
            }
            case 2:
            {
                CYWenZhangImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWenZhangImgCell"];
                cell.info = info;
                return cell;
                break;
            }
            case 3:
            {
                CYWengZhangTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWengZhangTypeCell"];
                cell.info = info;
                cell.imgBlock = ^(NSString *resource_id,NSInteger resource_type){
                    if (resource_type == 1) {
                        CYWenZhangDetailsController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYWenZhangDetailsController"];
                        vc.wenzhangId = resource_id;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                    if (resource_type == 10) {
                        CYWenZhangHeJiViewController *vc= viewControllerInStoryBoard(@"CYWenZhangHeJiViewController", @"WenZhang");
                        vc.hejiId = resource_id;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                };
                return cell;
                break;
            }
            default:
                return nil;
                break;
        }
        //    }
        //        return nil;
        
        
    }else{
        CYWenZhangDefCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWenZhangDefCell"];
        cell.info = dataArr[indexPath.row];
        return cell;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        NSDictionary *info = dataArr[indexPath.row];
        CYWenZhangDetailsController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYWenZhangDetailsController"];
        vc.wenzhangId = [info objectForJSONKey:@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1)
    {
        NSDictionary *info = listArr[indexPath.row];
        //        NSInteger type = [[info objectForKey:@"show_type"] integerValue];
        NSDictionary *source = [info objectForKey:@"source"];
        //        if (type <3) {
        CYWenZhangDetailsController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYWenZhangDetailsController"];
        
        if (!source) {
            vc.wenzhangId = [info objectForJSONKey:@"id"];
        }else{
            vc.wenzhangId = [info objectForJSONKey:@"resource_id"];
        }
        
        [self.navigationController pushViewController:vc animated:YES];
        
        //        }
    }
    
    //    if (indexPath.sec) {
    //        <#statements#>
    //    }
}




- (IBAction)navbar_clicked:(id)sender
{
    if (message.title.length) {
        [self showActionSheet:message];
    }
    
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:message];
}



@end
