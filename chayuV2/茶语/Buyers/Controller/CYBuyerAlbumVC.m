//
//  CYBuyerAlbumVC.m
//  茶语
//
//  Created by Leen on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerAlbumVC.h"
#import "CYBuyerMainCell.h"
#import "UIColor+Additions.h"
#import "UILabel+Utilities.h"
#import "CYActiveHeader.h"
#import "CYProductDetViewController.h"
#import "CYBuyerDetailVC.h"
#import "CYMasterListModel.h"
#import "CYBuyerMainCellModel.h"
#import "UICommon.h"
#import "CYShareModel.h"
#import "CYBuyerCell.h"
#import "CYHomeCell.h"
#import "CYTeaListViewController.h"

@interface CYBuyerAlbumVC ()<UITableViewDelegate, UITableViewDataSource,CYHomeCellDelegate>
{
    NSMutableArray *_dataArr;
    NSInteger page;
    
    CYShareModel * _shareModel;

}

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (nonatomic,strong)CYActiveHeader *headerView;


@end

@implementation CYBuyerAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    page = 1;
    _dataArr = [NSMutableArray array];
    if (_type == CYBuyerAlbumTypeCharacter) {
        self.title = @"茗星合集·人物";
    }else{
        self.title = @"茗星合集·商品";
    }
    
    hiddenSepretor(_mainTable);
    __weak __typeof(self) weakSelf = self;
    _mainTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadtableViewData:NO];
        
    }];
    _mainTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadtableViewData:YES];
    }];
    [_mainTable.header beginRefreshing];
    
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

- (void)headerChanged:(NSNotification *)sender
{
    _mainTable.tableHeaderView = self.headerView;
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
    if (_type == CYBuyerAlbumTypeCharacter) {
        juheType = @"2";
    }else{
        juheType = @"1";
    }
    
    [CYWebClient Post:@"TeaMall_Juhe" parametes:@{@"p":@(page),@"pageSize":@(PAGESIZE),@"juhe_id":_albumId,@"juheType":juheType} success:^(id responObj) {
        if (!loadMore) {
            [weakSelf.mainTable.header endRefreshing];
            [_dataArr removeAllObjects];
            [_mainTable reloadData];
        }else{
            [weakSelf.mainTable.footer endRefreshing];
            
        }
        if ([responObj count] < PAGESIZE) {
            [weakSelf.mainTable.footer endRefreshingWithNoMoreData];;
        }else{
            [weakSelf.mainTable.footer resetNoMoreData];
        }
             NSDictionary *info = [responObj objectForJSONKey:@"info"];
//        NSDictionary *info = [responObj objectForKey:@"info"];
        _shareModel = [CYShareModel objectWithKeyValues:info];

        
   
        weakSelf.title = [info  objectForKey:@"name"];//
        NSString *showUrl = [info objectForKey:@"thumb"];
        [weakSelf.headerView.showImg sd_setImageWithURL:[NSURL URLWithString:showUrl] placeholderImage:[UIImage imageNamed:@"750×500"]];
        weakSelf.headerView.desc = [info objectForKey:@"desc"];
        if(_type == CYBuyerAlbumTypeCharacter)
        {
            weakSelf.headerView.titleName = @"推荐茗星";
        }
        
        weakSelf.mainTable.tableHeaderView = self.headerView;
        
        
        _headerView.seeFullBlock = ^()
        {
            NSMutableArray * imgArr = [NSMutableArray array];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            [dic setObject:showUrl forKey:@"PictureUrl"];
            [imgArr addObject:dic];
            
            [UICommon seeFullScreenImage:weakSelf.navigationController imageUrlArr:imgArr currentPage:0];
        };
        
        [_dataArr addObjectsFromArray:[CYMasterListModel objectArrayWithKeyValuesArray:[responObj objectForKey:@"goodsList"]]];
        if ([_dataArr count] < PAGESIZE) {
            weakSelf.mainTable.footer = nil;
        }
        
        [weakSelf.mainTable reloadData];
    } failure:^(id err) {
        if (!loadMore) {
            [weakSelf.mainTable.header endRefreshing];
        }else{
            [weakSelf.mainTable.footer endRefreshing];
        }
    }];
    
    
}

- (CYActiveHeader *)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CYActiveHeader" owner:nil options:nil] firstObject];
        CGFloat imgHe = 250 * (SCREEN_WIDTH / 375);
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imgHe + 45);
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArr count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellH + 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMasterListModel *listModel = _dataArr[indexPath.section];

    if(_type == CYBuyerAlbumTypeCharacter)//茗星
    {
//        CYBuyerMainCellModel * model = [[CYBuyerMainCellModel alloc] init];
//        CYBuyerCell * cell = [CYBuyerCell cellForTableView:tableView];
//        model.thumb = listModel.thumb;
//        model.content = listModel.content;
//        cell.model = model;
//        
//        return cell;
        CYHomeCell *cell = [CYHomeCell cellWidthTableView:tableView];
        cell.delegate = self;
        CYMasterListModel *model = _dataArr[indexPath.row];
        
        model.type = @"6";
        cell.isMaster = YES;
        cell.onlyCharacter = YES;
        cell.model = model;
        return cell;
    }
    else//商品
    {
//        CYBuyerMainCellModel * model = [[CYBuyerMainCellModel alloc] init];
//        CYBuyerMainCell * cell = [CYBuyerMainCell cellForTableView:tableView];
//        
//        model.thumb = listModel.thumb;
//        model.selleravatar = listModel.sellerAvatar;
//        model.sellername = listModel.sellerTypeName;
//        model.title = listModel.title;
//        model.enjoy_count = [NSString stringWithFormat:@"%ld", listModel.enjoy_count];
//        model.comment_count = listModel.comment_count;
//        model.price_sell =listModel.price_sell;
//        
//        cell.model = model;
        
        
        CYHomeCell *cell = [CYHomeCell cellWidthTableView:tableView];
        cell.delegate = self;
        listModel.type = @"5";
        cell.model = listModel;

        return cell;
    }

}

/**
 *  茗星介绍
 */
- (void)cell:(CYHomeCell *)cell masterModel:(CYMasterListModel *)model
{
    CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
    vc.seller_uid = model.sellerUid;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cell:(CYHomeCell *)cell MasterGoodTeaModel:(CYMasterListModel *)model
{
    if ([model.goods_num integerValue] ==1) {
        CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
        vc.goodId = model.goods_id;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    CYTeaListViewController *vc = viewControllerInStoryBoard(@"CYTeaListViewController", @"TeaMall");
    vc.uid = model.data;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = [UIColor grayBackgroundColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMasterListModel *listModel = _dataArr[indexPath.section];

    if(_type == CYBuyerAlbumTypeCharacter)
    {
        CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
        vc.seller_uid = listModel.sellerUid;
        
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        CYProductDetViewController * vc = viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
        vc.goodId = listModel.goods_id;
        
        [self.navigationController pushViewController:vc animated:YES];

    }

}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)navbar_clicked:(id)sender
{
    NSInteger tag = ((UIButton *)sender).tag;
    
    [UICommon navBarClicked:self.navigationController tag:tag shareModel:_shareModel];
}

@end
