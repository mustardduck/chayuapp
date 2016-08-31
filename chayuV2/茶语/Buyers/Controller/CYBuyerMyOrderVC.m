//
//  CYBuyerMyOrderVC.m
//  茶语
//
//  Created by Leen on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerMyOrderVC.h"
#import "CYBuyerMyOrderCell.h"
#import "CYBuyerMyOrderDetailVC.h"
#import "UIColor+Additions.h"

#define TOPMENUTAG 6000

@interface CYBuyerMyOrderVC ()<UITableViewDataSource,UITableViewDelegate,CYBuyerMyOrderCellDelegate>
{
    NSMutableArray *_dataArr;
    NSInteger page;
//    CYOrderInfoModel *selectOrder;//选中订单
    NSIndexPath *selectIndex;//选中的cell
}

@property (weak, nonatomic) IBOutlet UIView *lineLbl;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goback:(id)sender;

@end

@implementation CYBuyerMyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.barStyle = NavBarStyleNoneMore;
    page = 1;
    _dataArr = [[NSMutableArray alloc] init];
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO];
    }];
    [_tableView.header beginRefreshing];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];
    
    AppDelegate *applegate = APP_DELEGATE;
    applegate.searchType = CYSearchTypeGoods;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIButton *button = (UIButton *)[_topView viewWithTag:TOPMENUTAG+_ordertype];
        _lineLbl.x = button.center.x -_lineLbl.width/2;
    });
    
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

-(void)loadTableViewData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        page =1;
        
    }
    
    UIView *view = [self.view viewWithTag:1000002];
    if (view) {
        [view removeFromSuperview];
    }
    __weak __typeof(self) weakSelf = self;
    NSString *urlPath = @"RefundList";
    NSDictionary *param =@{@"p":@(page),@"pageSize":@"10"};
    if (_ordertype != BuyerOrderTypeRefund) {
        urlPath = @"2.0_mingxing_list";
        param =@{@"p":@(page),@"pageSize":@"1",@"type":@(_ordertype)};
    }
    
    [CYWebClient Post:urlPath parametes:param success:^(id responObj) {
        if (loadMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
            [_dataArr removeAllObjects];
        }
        if ([responObj count] < PAGESIZE) {
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
        if (_ordertype == BuyerOrderTypeRefund) {
//            [_dataArr addObjectsFromArray:[CYRefundModel objectArrayWithKeyValuesArray:responObj]];
        }else{
            [_dataArr addObjectsFromArray:[CYBuyerOrderInfoModel objectArrayWithKeyValuesArray:responObj]];
        }
        if (_dataArr.count == 0) {
            for (UIView *emptyView in weakSelf.view.subviews) {
                if (emptyView.tag == 1000002) {
                    [emptyView removeFromSuperview];
                }
            }
            
            [weakSelf.view addSubview:[self emptyView]];
            UIView *view = [weakSelf.view viewWithTag:1000002];
            [weakSelf.view sendSubviewToBack:view];
        }else{
            UIView *view = [weakSelf.view viewWithTag:1000002];
            if (view) {
                [view removeFromSuperview];
            }
            
        }
        
        if ([_dataArr count]<PAGESIZE) {
            weakSelf.tableView.footer = nil;
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
    }];
}


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_ordertype ==  BuyerOrderTypeRefund) {
//        CYRefundModel  *model = _dataArr[indexPath.section];
//        NSInteger status = [model.status integerValue];
//        NSInteger type = [model.refundType integerValue];
//        NSInteger shippingStatus = [model.shippingStatus integerValue];
//        if (type == 1) {
//            if (status ==1) {
//                return 225;
//            }
//        }else{
//            if (shippingStatus == 6) {
//                return 225;
//            }
//        }
//        
//        return 185.;
    }else{
        CYBuyerOrderInfoModel *model = _dataArr[indexPath.section];
        CGFloat offect_height = 0;
        if (model.goodsList.count>1) {
            offect_height = 89*(model.goodsList.count-1);
        }
        
//        if ([model.type isEqualToString:@"2"]){
//            offect_height -=53;
//        }
        
        return offect_height + BASECELLHEIGHT;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerMyOrderCell *cell = [CYBuyerMyOrderCell cellWidthTableView:tableView];
    cell.delegate = self;
    cell.orderModel = _dataArr[indexPath.section];
    return cell;
}


 
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor grayBackgroundColor];
    footerView.height = 10;
    footerView.width = SCREEN_WIDTH;
    return footerView;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0)
    {
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [UIColor grayBackgroundColor];
        headerView.height = 10;
        headerView.width = SCREEN_WIDTH;
        return headerView;
    }
    
    return nil;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 10;
    }
    return 0;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_ordertype == BuyerOrderTypeRefund) {
        
//        CYRefundDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYRefundDetailViewController"];
//        vc.model = _dataArr[indexPath.section];
//        vc.refundcancelBlock = ^(){
//            [self loadTableViewData:NO];
//        };
//        [self.navigationController pushViewController:vc animated:YES];
    }else{
        CYBuyerOrderInfoModel *orderModel = _dataArr[indexPath.section];
        CYBuyerMyOrderDetailVC *vc = viewControllerInStoryBoard(@"CYBuyerMyOrderDetailVC", @"My");
        vc.model = orderModel;
        vc.changeOrderBlock = ^(){
            [self loadTableViewData:NO];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (IBAction)topMenu_click:(UIButton*)sender {
    for (int i = TOPMENUTAG ; i<TOPMENUTAG +6; i++) {
        UIButton *button = (UIButton*)[_topView viewWithTag:i];
        if (button.tag  == sender.tag) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
    _ordertype = sender.tag - TOPMENUTAG;
    _lineLbl.x = sender.center.x -_lineLbl.width/2;
    [_dataArr removeAllObjects];
    [_tableView reloadData];
    [self loadTableViewData:NO];
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark CYRefundTableViewCellDeletage method
//-(void)selectCell:(CYRefundTableViewCell *)cell andModel:(CYRefundModel *)model
//{
//    CYMoneyDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYMoneyDetailViewController"];
//    vc.model = model;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//}

@end
