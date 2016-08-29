//
//  CYBuyerMainViewController.m
//  茶语
//
//  Created by Leen on 16/5/18.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerMainViewController.h"
#import "CYBuyerMainCell.h"
#import "CYBuyerCategoryView.h"
#import "CYBuyerPDCategoryVC.h"
#import "CYBuyerDetailVC.h"
#import "CYProductDetViewController.h"
#import "CYBuyerEditVC.h"
#import "CYBuyerPDEditVC.h"
#import "CYBuyerAllListVC.h"
#import "CYBuyerMyVC.h"
#import "CYBuyerAddBankCardVC.h"
#import "CYProductDetViewController.h"
#import "CYBuyerMainCellModel.h"
#import "CYBuyAllCell.h"
#import "UIColor+Additions.h"
#import "CYBuyerPDCellModel.h"
#import "CYBuyerAlbumVC.h"
#import "CYArticleInfo.h"
#import "CYArticleDetailViewController.h"
#import "CYPublicHuoDongViewController.h"
#import "UICommon.h"
#import "CYShareModel.h"
#import "CYBuyerMainHeaderView.h"
#import "CYWenZhangDetailsController.h"
#import "CYTeaMallCollectionViewController.h"
#import "CYBuyerProfileVC.h"

@interface CYBuyerMainViewController ()<CYBuyerMainCellDelegate,CYBuyerCategoryViewDelegate, UITableViewDataSource, UITableViewDelegate, CYBuyerMainHeaderViewDelegate>
{
    NSInteger page;
    
    CYShareModel * _shareModel;
    
//    NSMutableArray * _dataArr;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *recomArr;
@property (nonatomic,strong) NSMutableArray *latestArr;

@property (strong, nonatomic) CYBuyerMainHeaderView *headerView;

@end

@implementation CYBuyerMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hiddenSepretor(_tableView);
    
    _recomArr = [[NSMutableArray alloc] init];
    _latestArr = [[NSMutableArray alloc] init];

    _tableView.tableHeaderView = self.headerView;
 
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
        
    }];
    
    [self loadData];
//    [_tableView.header beginRefreshing];
    
    _tableView.footer = nil;
    

    
}

- (void)loadRecomList
{
    __weak __typeof(self) weakSelf = self;
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
        
    }];
    
    [self loadData];
    
    _tableView.footer = nil;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  加载页面数据
 */

-(void)loadData
{
//    [_dataArr removeAllObjects];
//    [_tableView reloadData];
    
    [_tableView.header endRefreshing];

    __weak __typeof(self) weakSelf = self;
    
    [CYWebClient backgroundPost:@"sixiang_home" parametes:nil success:^(id responObject) {
        
        if(_headerView.recomBtn.selected)
        {
            NSInteger state = [[responObject objectForKey:@"state"] integerValue];
            if (state == 400) {
                NSDictionary *data = [responObject objectForKey:@"data"];
                weakSelf.tableView.tableHeaderView = self.headerView;
                NSArray *listArr;
                
                if ([data isKindOfClass:[NSDictionary class]]) {
                    listArr = [data objectForKey:@"list"];
                    
                    _headerView.touUrl = [data objectForJSONKey:@"touT"];
                    
                }
                
                [_recomArr removeAllObjects];
                _shareModel = [CYShareModel objectWithKeyValues:data];
                [_recomArr addObjectsFromArray:[CYBuyerMainCellModel objectArrayWithKeyValuesArray:listArr]];
                [_tableView.header endRefreshing];
                [weakSelf.tableView reloadData];
                [SVProgressHUD dismiss];
                
            }
        }
  
    } failure:^(id error) {
        [_tableView.header endRefreshing];
        weakSelf.tableView.hidden = NO;
    }];
}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loadLatestOrPopular:(NSString *)order
{
    __weak __typeof(self) weakSelf = self;

    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO order:order];
    }];
    [self loadTableViewData:NO order:order];

    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES order:order];
    }];
}

-(void)loadTableViewData:(BOOL)loadMore order:(NSString *)order
{
//    [_dataArr removeAllObjects];
//    [_tableView reloadData];
    if (loadMore) {
        page ++;
    }else{
        page =1;
    
    }
    
    [_tableView.header endRefreshing];
    __weak __typeof(self) weakSelf = self;
    
    [CYWebClient backgroundPost:@"sixiang_list" parametes:@{@"order": order,@"p":@(page),@"pageSize":@(PAGESIZE)} success:^(id responObj) {
        if(!_headerView.recomBtn.selected)
        {
//            _tableView.hidden = NO;
            NSInteger state = [[responObj objectForKey:@"state"] integerValue];
            if (state == 400) {
                NSArray *data = [responObj objectForKey:@"data"];
                if (loadMore) {
                    [weakSelf.tableView.footer endRefreshing];
                }else{
                    [weakSelf.tableView.header endRefreshing];
                    [_latestArr removeAllObjects];
                    
                    
                }
                if (![data isKindOfClass:[NSNull class]] && [data count] < PAGESIZE) {
                    [weakSelf.tableView.footer endRefreshingWithNoMoreData];;
                }
                else
                {
                    [weakSelf.tableView.footer resetNoMoreData];
                }
                
                
                [_latestArr addObjectsFromArray:[CYBuyerPDCellModel objectArrayWithKeyValuesArray:data]];
                
            }
            
            [weakSelf.tableView reloadData];
            [SVProgressHUD dismiss];
        }
        
//        _view_empty.hidden = (_dataArr.count != 0);
        
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
    }];
}


/**
 *  顶部四个按钮点击事件
 */
- (void)topMenuSelect:(NSInteger)tag
{
    if(tag == 100)
    {
        [self loadRecomList];
    }
    else if (tag == 101)
    {
        _tableView.footer = nil;
        [self loadLatestOrPopular:@""];
    }
    else if (tag == 102)
    {
        _tableView.footer = nil;
        [self loadLatestOrPopular:@"hot"];
    }
    else if (tag == 103)
    {
        CYBuyerAllListVC *tdc = viewControllerInStoryBoard(@"CYBuyerAllListVC", @"Buyer");
        [self.navigationController pushViewController:tdc animated:YES];
//        
//        CYBuyerPDEditVC *tdc = viewControllerInStoryBoard(@"CYBuyerPDEditVC", @"Buyer");
//        [self.navigationController pushViewController:tdc animated:YES];
//
        
//        CYBuyerAlbumVC * vc = viewControllerInStoryBoard(@"CYBuyerAlbumVC", @"Buyer");
//        vc.albumId =@"84";
//        //                    vc.title = model.title;
//        vc.type = CYBuyerAlbumTypeCharacter;
//        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)setImgTransform:(BOOL)trans arrow:(UIImageView *)arrowImg
{
    if (trans) {

        [UIView animateWithDuration:0.25 animations:^{
            arrowImg.transform = CGAffineTransformMakeRotation(-M_PI);
            
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            arrowImg.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_headerView.recomBtn.selected)
    {
        return _recomArr.count;
    }
    else
    {
        return _latestArr.count;
    }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat he = ((UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath]).height;
    
    return he;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_headerView.recomBtn.selected)
    {
        CYBuyerMainCellModel * model = _recomArr[indexPath.section];
        
        if(model.type == 1)//商品详情
        {
            CYBuyerMainCell * cell = [CYBuyerMainCell cellForTableView:tableView];
            cell.model = model;
            [cell.buyerBtn addTarget:self action:@selector(buyerClicked:) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
        else if(model.type == 2)//茗星详情
        {
            CYBuyAllCell * cell = [CYBuyAllCell cellForTableView:tableView];
            cell.model = model;
            
            return cell;
        }
        else if (model.type == 3)//合集
        {
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hejiCell"];
            
            for(UIView * view in [cell.contentView subviews])
            {
                [view removeFromSuperview];
            }
            
            cell.height = SCREEN_WIDTH * 250 / 375;
            
            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cell.height)];
//            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [imgView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"750×500"]];
            
            [cell.contentView addSubview:imgView];
            
            return cell;
            
        }
    }
    else
    {
        CYBuyerPDCellModel * model = _latestArr[indexPath.section];

        CYBuyerMainCell * cell = [CYBuyerMainCell cellForTableView:tableView];
        
        CYBuyerMainCellModel * mainModel = [[CYBuyerMainCellModel alloc] init];
        mainModel.thumb = model.thumb;
        if(![model.avatar isKindOfClass:[NSNull class]] && model.avatar.length)
        {
            mainModel.selleravatar = model.avatar;
        }
        mainModel.sellername = model.realname;
        mainModel.title = model.name;
        mainModel.enjoy_count = model.enjoy;
        mainModel.comment_count = model.comment_count;
        mainModel.price_sell = model.price_sell;
        
        cell.model = mainModel;
        
        [cell.buyerBtn addTarget:self action:@selector(buyerClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)buyerClicked:(id)sender
{
    CYBuyerMainCell * cell = (CYBuyerMainCell *)[[sender superview] superview];
    NSIndexPath * indexP = [_tableView indexPathForCell:cell];
    
    CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");

    if(_headerView.recomBtn.selected)
    {
        CYBuyerMainCellModel * model = _recomArr[indexP.section];
        vc.seller_uid = model.selleruid;//茗星ID

    }
    else
    {
        CYBuyerPDCellModel * model = _latestArr[indexP.section];
        vc.seller_uid = model.uid;//茗星ID
    }
    
    [self.navigationController pushViewController:vc animated:YES];

    
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_headerView.recomBtn.selected)
    {
        CYBuyerMainCellModel * model = _recomArr[indexPath.section];
        if(model.type == 1)//商品详情
        {
            CYProductDetViewController * vc = viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
            vc.goodId = model.data;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if(model.type == 2)//茗星详情
        {
            CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
            vc.seller_uid = model.data;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (model.type == 3)//合集
        {
            NSInteger type = [model.thumbType integerValue];
            
            switch (type) {
                case 1:
                {
                    CYArticleInfo *info = [[CYArticleInfo alloc] init];
                    info.itemid = model.data;
                    info.title = model.title;
                    CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
                    vc.wenzhangId = model.data;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 2:
                {
                    CYProductDetViewController * vc = viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                    vc.goodId = model.data;
                    [self.navigationController pushViewController:vc animated:YES];

                    break;
                }
                case 3:
                {
                    CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
                    vc.seller_uid = model.data;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 4:
                case 101:
                {
                    CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
                    if (type == 4) {//聚合 人物
                        vc.type = CYCollectionTypeCharacter;
                        
                    }else{//聚合 商品
                        vc.type = CYCollectionTypeCommodity;
                    }
                    vc.juhe_id = model.data;
//                    vc.title = model.title;
        
                    [self.navigationController pushViewController:vc animated:YES];

                    break;
                }
                case 100://纯url
                {
                    CYPublicHuoDongViewController *vc = viewControllerInStoryBoard(@"CYPublicHuoDongViewController", @"Huodong");
                    vc.titleStr = model.title;
                    vc.requstUrl = model.data;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                default:
                    
                    break;
            }
        }
    }
    else
    {
        CYBuyerPDCellModel * model = _latestArr[indexPath.section];

        CYProductDetViewController * vc = viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
        vc.goodId = model.goods_id;
        
        [self.navigationController pushViewController:vc animated:YES];

    }
}

- (IBAction)navbar_clicked:(id)sender
{
    NSInteger tag = ((UIButton *)sender).tag;
    
    [UICommon navBarClicked:self.navigationController tag:tag shareModel:_shareModel];
}

- (CYBuyerMainHeaderView *)headerView
{
    if (!_headerView) {

        CGFloat header_height = 65 + 200 *(SCREEN_WIDTH/375.);
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerMainHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,header_height);
        _headerView.delegate = self;
    }
    
    return _headerView;
}

@end
