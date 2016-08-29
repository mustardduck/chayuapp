//
//  CYTeaMallCollectionViewController.m
//  茶语
//
//  Created by Chayu on 16/2/26.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaMallCollectionViewController.h"
#import "CYHomeCell.h"
#import "CYProductDetViewController.h"
#import "CYMasterListViewController.h"
#import "CYMasterDetailViewController.h"
#import "CYTeaListViewController.h"
#import "CYActiveHeader.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
#import "UICommon.h"
#import "CYBuyerDetailVC.h"
@interface CYTeaMallCollectionViewController ()<UITableViewDelegate,UITableViewDataSource,CYHomeCellDelegate>
{
    NSMutableArray *_dataArr;
    NSInteger page;
    
    OSMessage * _shareMsg;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)CYActiveHeader *headerView;
- (IBAction)goback:(id)sender;
- (IBAction)share_click:(id)sender;

@end

@implementation CYTeaMallCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    _dataArr = [NSMutableArray array];
    
    _shareMsg = [[OSMessage alloc] init];
    
    if (_type == CYCollectionTypeCharacter) {
        self.title = @"茶语市集·人物";
    }else{
        self.title = @"茶语市集·商品";
    }
    
    hiddenSepretor(_tableView);
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadtableViewData:NO];
        
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadtableViewData:YES];
    }];
    [_tableView.header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headerChanged:) name:@"COLLECTIONHEADERHEIGHT" object:nil];
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

- (void)headerChanged:(NSNotification *)sender
{
    
    _tableView.tableHeaderView = self.headerView;
}


-(void)loadtableViewData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        page =1;
        
    }
    __weak __typeof(self) weakSelf = self;
    NSString *juheType = nil;
    if (_type == CYCollectionTypeCharacter) {
        juheType = @"2";
    }else{
        juheType = @"1";
    }
    
    [CYWebClient Post:@"TeaMall_Juhe" parametes:@{@"p":@(page),@"pageSize":@"10",@"juhe_id":_juhe_id,@"juheType":juheType} success:^(id responObj) {
        if (!loadMore) {
            NSDictionary * shareInfo = [responObj objectForJSONKey:@"info"];
            if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
                _shareMsg.title = [shareInfo objectForJSONKey:@"name"];
                _shareMsg.desc = [shareInfo objectForJSONKey:@"desc"];
                _shareMsg.link = [shareInfo objectForJSONKey:@"shareUrl"];
                _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
            }
            
            [weakSelf.tableView.header endRefreshing];
            [_dataArr removeAllObjects];
            [_tableView reloadData];
        }else{
            [weakSelf.tableView.footer endRefreshing];
            
        }
        
        
        NSArray *goodsList = [responObj objectForKey:@"goodsList"];
        if ([goodsList count]<10) {
            weakSelf.tableView.footer = nil;
        }else{
            weakSelf.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadtableViewData:YES];
            }];
        }
        NSDictionary *info = [responObj objectForJSONKey:@"info"];
        weakSelf.title = [info  objectForKey:@"name"];
        NSString *showUrl = [info objectForKey:@"thumb"];
        [weakSelf.headerView.showImg sd_setImageWithURL:[NSURL URLWithString:showUrl] placeholderImage:WIDEIMG];
        weakSelf.headerView.desc = [info objectForKey:@"desc"];
        weakSelf.tableView.tableHeaderView = self.headerView;
        _headerView.seeFullBlock = ^()
        {
            NSMutableArray * imgArr = [NSMutableArray array];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            [dic setObject:showUrl forKey:@"PictureUrl"];
            [imgArr addObject:dic];
            
            [UICommon seeFullScreenImage:weakSelf.navigationController imageUrlArr:imgArr currentPage:0];
        };
        
        
        [_dataArr addObjectsFromArray:[CYMasterListModel objectArrayWithKeyValuesArray:[responObj objectForKey:@"goodsList"]]];
        if ([_dataArr count]<10) {
            weakSelf.tableView.footer = nil;
        }else{
            weakSelf.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadtableViewData:YES];
            }];
        }
        
        [weakSelf.tableView reloadData];
    } failure:^(id err) {
        if (!loadMore) {
            [weakSelf.tableView.header endRefreshing];
        }else{
            [weakSelf.tableView.footer endRefreshing];
        }
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CYActiveHeader *)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CYActiveHeader" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,300);
        if (_type == CYCollectionTypeCharacter) {
            _headerView.titleLbl.text = @"推荐人物";
        }else{
            _headerView.titleLbl.text = @"推荐商品";
        }
    }
    return _headerView;
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
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CellH + 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYHomeCell *cell = [CYHomeCell cellWidthTableView:tableView];
    cell.delegate = self;
    CYMasterListModel *model = _dataArr[indexPath.row];
    
    if (_type == CYCollectionTypeCharacter) {
        model.type = @"3";
        if ([model.gid isEqualToString:@"10"]) {
            cell.isMaster = NO;
        }else{
            cell.isMaster = YES;
        }
        cell.onlyCharacter = YES;
    }else{
        model.type = @"5";
    }
    cell.model = model;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMasterListModel *model = _dataArr[indexPath.row];
    if (_type == CYCollectionTypeCharacter) {
        NSInteger rewuType = [model.gid integerValue];
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
    }else{
        CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
        vc.goodId = model.goods_id;
        //vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark -
#pragma mark CYHomeCellDelegate method

/**
 *  大师好茶详情
 */
- (void)cell:(CYHomeCell *)cell MasterGoodTeaModel:(CYMasterListModel *)model
{
    if ([model.sellerUid isEqualToString:@"0"]) {
        return;
    }
    CYTeaListViewController *vc = viewControllerInStoryBoard(@"CYTeaListViewController", @"TeaMall");
    vc.uid = model.sellerUid;
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  大师介绍
 */
- (void)cell:(CYHomeCell *)cell masterModel:(CYMasterListModel *)model
{
    if ([model.sellerUid isEqualToString:@"0"]) {
        return;
    }
    NSInteger rewuType = [model.gid integerValue];
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

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)share_click:(id)sender {
    
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
}



- (IBAction)gotousercenter_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)sousuo_click:(id)sender {
    CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
    [self.navigationController pushViewController:vc animated:YES];
}




@end
