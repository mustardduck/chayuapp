//
//  CYTeaMallViewController.m
//  茶语
//
//  Created by Chayu on 16/2/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaMallViewController.h"
#import "CYTeaMallHeaderView.h"
#import "CYHomeCell.h"
#import "CYHomeFooterView.h"
#import "CYMasterDetailViewController.h"
#import "CYMasterListViewController.h"
#import "CYSearchViewController.h"
#import "HongBaoView.h"
#import "CYClassViewController.h"
#import "CYTeaMallActiveViewController.h"
#import "CYMasterListViewController.h"
#import "CYTeaListViewController.h"
#import "CYTeaMallCollectionViewController.h"
#import "CYProductDetViewController.h"
#import "CYSCartViewController.h"
#import "BaseLable.h"
#import "AppDelegate.h"
#import "CYPublicAvtiveViewController.h"
#import "CYAllGoodsViewController.h"
#import "CYArticleDetailViewController.h"
#import "CYBuyerMainViewController.h"
#import "CYPublicHuoDongViewController.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
#import "CYDaoHangViewController.h"
#import "CYWenZhangDetailsController.h"
#import "CYBuyerDetailVC.h"
@interface CYTeaMallViewController ()<CYHomeFooterViewDelegate,CYHomeCellDelegate,CYTeaMallHeaderViewDelegate>
{
    CYHomeCellModel *homeModel;
    UIButton *search;
    OSMessage *message;
}
@property (nonatomic,strong)CYTeaMallHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)CYHomeFooterView *footerView;
- (IBAction)hongbao_click:(id)sender;

- (IBAction)class_click:(id)sender;

@property (weak, nonatomic) IBOutlet BaseLable *cartnum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_cons;

@end

@implementation CYTeaMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hiddenSepretor(_tableView);
    message =[[OSMessage alloc] init];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMasterList:) name:PAYSUCCESS_GOTOMASTERLIST object:nil];
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
        
    }];
    [self creatkongNavBar];
    _bottom_cons.constant  = 65 *(SCREEN_WIDTH/375.);
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
    //    [self loadData];
    //    [APP_DELEGATE setTabbarHidden:YES animated:animated];
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


-(void)gotoMasterList:(NSNotification *)sender
{
    NSDictionary *info = sender.object;
    NSInteger type = [[info objectForJSONKey:@"type"] integerValue];
    CYMasterListViewController *vc = viewControllerInStoryBoard(@"CYMasterListViewController", @"TeaMall");
    if (type == 1) {
        vc.type = CYSellerTypeMaster;
    }else{
        vc.type = CYSellerTypeHandmade;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData
{
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"Home" parametes:@{@"version":@"1"} success:^(id responObject) {
        NSDictionary *shareInfo = [responObject objectForKey:@"share"];
        if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
            message.imgUrl = [shareInfo objectForKey:@"thumb"];
            message.link = [shareInfo objectForKey:@"url"];
            message.title = [shareInfo objectForKey:@"title"];
            message.desc = [shareInfo objectForKey:@"description"];
        }
        homeModel = [CYHomeCellModel initWithData:responObject];
        weakSelf.headerView.touPhotosArr = [responObject objectForKey:@"touPhotosArr"];
        weakSelf.tableView.hidden = NO;
        if (!weakSelf.headerView.bannserArr.count) {
            weakSelf.headerView.bannserArr = homeModel.slideArr;
        }
        //        
        //        if (weakSelf.headerView.bannserArr.count && homeModel.slideArr.count!=weakSelf.headerView.bannserArr.count) {
        //            weakSelf.headerView.bannserArr = nil;
        //            weakSelf.headerView.bannserArr = homeModel.slideArr;
        //        }
        
        NSString *SearchHotWords = [NSString stringWithFormat:@" %@",[responObject objectForKey:@"SearchHotWords"]];
        [search setTitle:SearchHotWords forState:UIControlStateNormal];
        
        weakSelf.footerView.teasArr = homeModel.famousProArr;
        if (homeModel.famousProArr.count != 0) {
            weakSelf.footerView.height = ceilf(homeModel.famousProArr.count/4.)*BGVIEW_HEIGHT;
        }
        
        weakSelf.tableView.tableHeaderView = weakSelf.headerView;
        //        weakSelf.headerView.bantitleInfo = [responObject objectForKey:@"bannerArr"];
        [_tableView.header endRefreshing];
        [weakSelf.tableView reloadData];
    } failure:^(id error) {
        [_tableView.header endRefreshing];
        weakSelf.tableView.hidden = NO;
    }];
}


-(void)search_click:(UIButton *)sender
{
    CYSearchViewController *vc = viewControllerInStoryBoard(@"CYSearchViewController", @"TeaMall");
    vc.searchtype = CYSearchTypeGoods;
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self loadData];
    });
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
    //    if ([MANAGER isLoged]) {
    //        [self loadCartNum];
    //    }
}
/**
 *  footerView数据加载
 */
-(void)loadFooterViewData
{
    //    [self.footerArr removeAllObjects];
    //    [self.footerArr addObjectsFromArray:homeModel.masterGoodsList];
    //    self.footerView.teasArr = self.footerArr;
    //    self.footerView.height = ceilf(self.footerArr.count/4.)*BGVIEW_HEIGHT;
}

- (CYHomeFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[CYHomeFooterView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,1)];
        _footerView.delegate = self;
        
    }
    return _footerView;
}



- (CYTeaMallHeaderView *)headerView
{
    if (!_headerView) {
        CGFloat header_height = 70 +345*(SCREEN_WIDTH/375.);
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaMallHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,header_height);
        _headerView.delegate = self;
    }
    
    return _headerView;
}
- (void)creatBackItem
{
    
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [homeModel.masterArr count];
    }else{
        return [homeModel.famousArr count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMasterListModel *model = nil;
    if (indexPath.section == 0) {
        model = homeModel.masterArr[indexPath.row];
    }else{
        model = homeModel.famousArr[indexPath.row];
    }
    NSInteger type = [model.type integerValue];
    switch (type) {
        case 1:
        case 2:
        case 4:
        case 6:
        {
            return CellH;
            break;
        }
        case 3:
        {
            return CellH +50;
            break;
        }
        case 5:
        {
            return CellH +50;
            break;
        }
        case 100:
        {
            return CellH;
            break;
        }
            
        default:
            return CellH;
            break;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYHomeCell *cell = [CYHomeCell cellWidthTableView:tableView];
    cell.delegate = self;
    if (indexPath.section == 0) {
        cell.isMaster = YES;
        cell.model =homeModel.masterArr[indexPath.row];
    }else{
        cell.isMaster = NO;
        cell.model = homeModel.famousArr[indexPath.row];
    }
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    return view;
    //    return [self creatTableViewSectionHeader:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 5.0;
    //    if (section == 0) {
    //        return 50;
    //    }else{
    //        return 58;
    //    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerheight = 0.00001;
    if (section == 0) {
        footerheight = self.footerView.height;
    }else{
        footerheight = 0.000000001;
    }
    
    return footerheight;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    if (section == 0) {
        footerView = self.footerView;
    }else{
        footerView = nil;
    }
    
    return footerView;
}


#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMasterListModel *model = nil;
    if (indexPath.section == 0) {
        model = homeModel.masterArr[indexPath.row];
    }else{
        model = homeModel.famousArr[indexPath.row];
    }
    NSInteger type = [model.type integerValue];
    switch (type) {
        case 1:
        {
            
            break;
        }
        case 2:
        case 5:
        case 6:
        {
            CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
            vc.goodId = model.data;
            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            NSInteger gid = [model.gid integerValue];
            if (gid<11) {
                CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
                //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYMasterDetailViewController"];
                vc.uid = model.sellerUid;
                if (gid == 9) {
                    vc.isMaster = YES;
                }else{
                    vc.isMaster = NO;
                }
                
                //vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                CYBuyerDetailVC *vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
                vc.seller_uid = model.sellerUid;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            break;
        }
        case 4:
        {
            NSInteger juhetype = [model.juheType integerValue];
            CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
            if (juhetype == 1) {//聚合 商品
                vc.type = CYCollectionTypeCommodity;
            }else{//聚合 人物
                vc.type = CYCollectionTypeCharacter;
            }
            vc.juhe_id = model.data;
            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            break;
        }
        case 100:
        {
            
            break;
        }
            
        default:
            
            break;
    }
    
}


#pragma mark -
#pragma mark 创建SectionHeader method
- (UIView *)creatTableViewSectionHeader:(NSInteger)section
{
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 58)];
    tableHeader.backgroundColor = MAIN_BGCOLOR;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, screen_width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 2,20)];
    linView.backgroundColor = MAIN_COLOR;
    [headerView addSubview:linView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 150, 20)];
    if (section == 0) {
        titleLable.text = @"大师手制";
        headerView.y = 0;
        tableHeader.height = 50;
    }else{
        headerView.y = 8;
        titleLable.text = @"名家监制";
        tableHeader.height = 58;
    }
    titleLable.textColor = CONTENTCOLOR;
    titleLable.font = [UIFont systemFontOfSize:18.0];
    [headerView addSubview:titleLable];
    [titleLable sizeToFit];
    
    UIButton *morebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    morebtn.x = SCREEN_WIDTH-80;
    morebtn.y = 0;
    morebtn.width = 80;
    morebtn.height = 50;
    [morebtn setTitle:@"更多" forState:UIControlStateNormal];
    morebtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [morebtn setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    [morebtn addTarget:self action:@selector(selectMoremaster:) forControlEvents:UIControlEventTouchUpInside];
    morebtn.tag = section + 2000;
    [headerView addSubview:morebtn];
    UIImageView *riggtrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-25,14,12, 12)];
    riggtrowImg.image = [UIImage imageNamed:@"icon-more"];
    [riggtrowImg sizeToFit];
    
    [headerView addSubview:riggtrowImg];
    riggtrowImg.y = headerView.height/2 - riggtrowImg.height/2.;
    [tableHeader addSubview:headerView];
    
    return tableHeader;
}





/**
 *  点击更多 进入大师/名家列表页面
 */
-(void)selectMoremaster:(UIButton *)sender
{
    CYMasterListViewController *vc= viewControllerInStoryBoard(@"CYMasterListViewController", @"TeaMall");
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark CYTeaMallHeaderViewDelegate method

-(void)topMenuSelect:(NSInteger)tag
{
    switch (tag) {
        case 0:
        case 1:{
            //大师名家
            CYMasterListViewController *vc = viewControllerInStoryBoard(@"CYMasterListViewController", @"TeaMall");
            if (tag == 1) {
                vc.type = CYSellerTypeHandmade;
            }else{
                vc.type = CYSellerTypeMaster;
            }
            
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
        case 2:{
            //明星私享
            CYBuyerMainViewController *vc = viewControllerInStoryBoard(@"CYBuyerMainViewController", @"Buyer");
            
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
        case 3:{
            //所有商品
            CYAllGoodsViewController *vc =viewControllerInStoryBoard(@"CYAllGoodsViewController", @"TeaMall");
            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:{
            //所有分类
            CYClassViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYClassViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}
-(void)bannerSelected:(NSInteger)index andModel:(CYSlideListModel *)model
{
    NSInteger type = [model.type integerValue];
    switch (type) {
        case 1:
        {
            CYArticleInfo *info = [[CYArticleInfo alloc] init];
            info.itemid = model.data;
            info.title = model.title;
            CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
            vc.wenzhangId = model.data;;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
            vc.goodId = model.data;
            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
            //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYMasterDetailViewController"];
            vc.uid = model.data;
            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        case 101:
        {
            //            NSInteger juhetype = [model.juheType integerValue];
            CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
            if (type == 101) {//聚合 商品
                vc.type = CYCollectionTypeCommodity;
            }else{//聚合 人物
                vc.type = CYCollectionTypeCharacter;
            }
            vc.juhe_id = model.data;
            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            break;
        }
        case 100:
        {
            
            if (!MANAGER.isLoged) {
                [APP_DELEGATE showLogView];
                return;
            }
            CYPublicAvtiveViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYPublicAvtiveViewController"];
            vc.requestUrl = model.data;
            vc.titleStr = model.title;
            vc.isRedPack = model.isRedPack;
            //            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 102:
        {
            
            CYPublicHuoDongViewController *vc = viewControllerInStoryBoard(@"CYPublicHuoDongViewController", @"Huodong");
            vc.titleStr = model.title;
            vc.requstUrl = model.data;
            //            //vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
            
        default:
            
            break;
    }
    
}

#pragma mark -
#pragma mark CYHomeFooterViewDelegate method
-(void)selectTheTea:(NSInteger)index andModel:(CYGoodsListModel *)model
{
    CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    vc.goodId = model.goods_id;
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -
#pragma mark CYHomeCellDelegate method

/**
 *  大师好茶详情
 */
- (void)cell:(CYHomeCell *)cell MasterGoodTeaModel:(CYMasterListModel *)model
{
    if ([model.goods_num integerValue] ==1) {
        CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
        vc.goodId = model.goods_id;
        //vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    CYTeaListViewController *vc = viewControllerInStoryBoard(@"CYTeaListViewController", @"TeaMall");
    vc.uid = model.data;
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  大师介绍
 */
- (void)cell:(CYHomeCell *)cell masterModel:(CYMasterListModel *)model
{
    //    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSInteger rewuType = [model.gid integerValue];
    //    gid 9大师 10 名家，11 茗星
    if (rewuType <11) {
        CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
        //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYMasterDetailViewController"];
        vc.uid = model.sellerUid;
        if ([model.gid isEqualToString:@"9"]) {
            vc.isMaster = YES;
        }else{
            vc.isMaster = NO;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        CYBuyerDetailVC *vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
        vc.seller_uid = model.sellerUid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/**
 *  有活动时
 */
- (void)cell:(CYHomeCell *)cell ActivityModel:(CYMasterListModel *)model
{
    NSLog(@"活动");
}

- (void)selectGoods:(NSString *)goodsId
{
    CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    vc.goodId = goodsId;
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark 按钮点击事件 method
/**
 *  购物车
 */
- (IBAction)hongbao_click:(id)sender {
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYSCartViewController *vc = viewControllerInStoryBoard(@"CYSCartViewController", @"My");
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)class_click:(id)sender {
    CYClassViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYClassViewController"];
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)share_click:(id)sender {
    [self showActionSheet:message];
}

@end
