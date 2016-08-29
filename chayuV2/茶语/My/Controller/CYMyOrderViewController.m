//
//  CYMyOrderViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/6.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMyOrderViewController.h"
#import "CYApplyRerundViewController.h"
#import "CYOrderDetailViewController.h"
#import "CYEvaluationViewController.h"
#import "CYPayTableViewController.h"
#import "CYApplyRerundViewController.h"
#import "CYLogisticsViewController.h"
#import "CYRefundTableViewCell.h"
#import "CYMoneyDetailViewController.h"
#import "CYRefundDetailViewController.h"
#define TOPMENUTAG 6000
@interface CYMyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,CYMyOrderTableViewCellDelegate,UIAlertViewDelegate,CYRefundTableViewCellDeletage>
{
    NSMutableArray *_dataArr;
    NSInteger page;
    CYOrderInfoModel *selectOrder;//选中订单
    NSIndexPath *selectIndex;//选中的cell
}
@property (weak, nonatomic) IBOutlet UIView *lineLbl;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
- (IBAction)shijiguangguang_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *emptyView;

@end

@implementation CYMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //self.barStyle = NavBarStyleNoneMore;
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
    
    _emptyView.hidden = YES;
    __weak __typeof(self) weakSelf = self;
    NSString *urlPath = @"RefundList";
    NSDictionary *param =@{@"p":@(page),@"pageSize":@"10"};
    if (_ordertype != OrderTypeRefund) {
        urlPath = @"MyOrderList";
        param =@{@"p":@(page),@"pageSize":@"10",@"orderStatus":@(_ordertype)};
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
        if (_ordertype == OrderTypeRefund) {
            [_dataArr addObjectsFromArray:[CYRefundModel objectArrayWithKeyValuesArray:responObj]];
        }else{
             [_dataArr addObjectsFromArray:[CYOrderInfoModel objectArrayWithKeyValuesArray:responObj]];
        }
        if (_dataArr.count == 0) {
            _emptyView.hidden = NO;
            switch (_ordertype) {
                case OrderTypeAll:
                {
                    _statusLbl.text = @"您暂无订单";
                    break;
                }
                case OrderTypePendingPayment:
                {
                     _statusLbl.text = @"您暂无待付款订单";
                    break;
                }
                case OrderTypePendingShipped:
                {
                    _statusLbl.text = @"您暂无待发货订单";
                    break;
                }
                case OrderTypeInbound:
                {
                    _statusLbl.text = @"您暂无待收货订单";
                    break;
                }
                case OrderTypeEvaluated:
                {
                    _statusLbl.text = @"您暂无待评价订单";
                    break;
                }
                    
                default:
                    break;
            }
        }else{
            _emptyView.hidden = YES;
        }
        
        if ([_dataArr count]<PAGESIZE) {
            weakSelf.tableView.footer = nil;
        }else{
            weakSelf.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadTableViewData:YES];
            }];
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
    return 1;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_ordertype ==  OrderTypeRefund) {
         CYRefundModel  *model = _dataArr[indexPath.section];
        NSInteger status = [model.status integerValue];
        NSInteger type = [model.refundType integerValue];
        NSInteger shippingStatus = [model.shippingStatus integerValue];
        if (type == 1) {
            if (status ==1) {
                return 225;
            }
        }else{
            if (shippingStatus == 6) {
                return 225;
            }
        }
        
        return 185.;
    }else{
        CYOrderInfoModel *model = _dataArr[indexPath.section];
        CGFloat offect_height = 0;
        if (model.goodsList.count>1) {
            offect_height = 89*(model.goodsList.count-1);
        }
        
        if ([model.status isEqualToString:@"2"]){
            offect_height -=53;
        }
        
        return offect_height + BASECELLHEIGHT;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_ordertype == OrderTypeRefund) {
        CYRefundTableViewCell *cell = [CYRefundTableViewCell cellWidthTableView:tableView];
        CYRefundModel *model = _dataArr[indexPath.section];
        cell.delegate = self;
        cell.orderModel = model;
        cell.delegate = self;
        return cell;
    }else{
        CYMyOrderTableViewCell *cell = [CYMyOrderTableViewCell cellWidthTableView:tableView];
        cell.delegate = self;
        cell.orderModel = _dataArr[indexPath.section];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_ordertype == OrderTypeRefund) {
        return 0.000001;
    }else{
      return 10;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (_ordertype == OrderTypeRefund) {
        return nil;
    }else{
        UIView *footerView = [UIView new];
        footerView.backgroundColor = MAIN_BGCOLOR;
        footerView.height = 10;
        footerView.width = SCREEN_WIDTH;
        return footerView;
    }
   
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_ordertype == OrderTypeRefund) {
        
        CYRefundDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYRefundDetailViewController"];
        vc.model = _dataArr[indexPath.section];
        vc.refundcancelBlock = ^(){
            [self loadTableViewData:NO];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        CYOrderInfoModel *orderModel = _dataArr[indexPath.section];
        CYOrderDetailViewController *vc = viewControllerInStoryBoard(@"CYOrderDetailViewController", @"My");
        vc.model = orderModel;
        vc.changeOrderBlock = ^(){
            [self loadTableViewData:NO];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark -
#pragma mark CYMyOrderTableViewCellDelegate  method
- (void)publicCell:(CYMyOrderTableViewCell *)cell AndModel:(CYOrderInfoModel *)model
{
    selectOrder = model;
    //订单状态(string) [1待付款，2待发货，3待收货，5交易成功，6交易关闭]
    NSInteger status = [model.status integerValue];
    switch (status) {
        case 1:
        {
            CYPayTableViewController *vc = viewControllerInStoryBoard(@"CYPayTableViewController", @"TeaMall");
            vc.orderId = model.orderSn;
            vc.price = model.orderPrice;
            vc.payType = model.orderType;
            vc.ipaddress = model.ip;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请确认收到的商品完整无误后再确认收货,否则您可能钱货两空" delegate:self
                                                cancelButtonTitle:@"取消" otherButtonTitles:@"收货并评价", nil];
            alt.tag = 100023;
            [alt show];
      
            break;
        }
        case 5:
        {
            
            if ([model.comment_status integerValue]<2) {
                CYEvaluationViewController *vc = viewControllerInStoryBoard(@"CYEvaluationViewController", @"My");
                //            [self.storyboard instantiateViewControllerWithIdentifier:@"CYEvaluationViewController"];
                vc.blockBack= ^{
                    [self loadTableViewData:NO];
                };
                if ([model.comment_status integerValue] == 1) {
                    vc.isAppend = YES;
                }else{
                    vc.isAppend = NO;
                }
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要删除订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alt.tag = 80000;
                [alt show];
            }
           
            break;
        }
        case 6:
        {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要删除订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alt.tag = 80000;
            [alt show];
            break;
        }
        default:
            break;
    }
}

-(void)chakanwuliu:(CYOrderInfoModel *)model
{
    CYLogisticsViewController *vc = viewControllerInStoryBoard(@"CYLogisticsViewController", @"My");
    //            [self.storyboard instantiateViewControllerWithIdentifier:@"CYLogisticsViewController"];
    vc.orderSign = model.orderSn;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)deleteCell:(CYMyOrderTableViewCell *)cell WithModel:(CYOrderInfoModel *)model
{
    selectOrder = model;
    //[1待付款，2待发货，3待收货，4待评价，5交易成功，6交易关闭，7追加评价]
    NSIndexPath *index = [_tableView indexPathForCell:cell];
    selectIndex = index;
    NSInteger status = [model.status integerValue];
    switch (status) {
        case 1:
        {
            
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要取消订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alt.tag = 80001;
            [alt show];
            break;
        }
        case 2:
        {
            break;
        }
        case 3://查看物流
        {
            CYLogisticsViewController *vc = viewControllerInStoryBoard(@"CYLogisticsViewController", @"My");
            //            [self.storyboard instantiateViewControllerWithIdentifier:@"CYLogisticsViewController"];
            vc.orderSign = model.orderSn;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        case 5:
        case 6:
        case 7:{
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要删除订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alt.tag = 80000;
            [alt show];
            
            break;
        }
            
        default:
            break;
    }}

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

/**
 *  删除订单
 */
-(void)deleteOrder:(NSString *)orderId andIndex:(NSIndexPath *)index
{
    [CYWebClient Post:@"DelOrder" parametes:@{@"orderSn":orderId} success:^(id responObj) {
        
        [_dataArr removeObjectAtIndex:index.section];
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:index.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}
/**
 *  关闭/取消订单
 */
-(void)closeOrder:(NSString *)orderId andIndex:(NSIndexPath *)index
{
    [CYWebClient Post:@"CloseOrder" parametes:@{@"orderSn":orderId} success:^(id responObj) {
        
        [_dataArr removeObjectAtIndex:index.section];
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:index.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

#pragma mark -
#pragma mark CYRefundTableViewCellDeletage method
-(void)selectCell:(CYRefundTableViewCell *)cell andModel:(CYRefundModel *)model
{
    CYMoneyDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYMoneyDetailViewController"];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark -
#pragma mark UIAlertViewDelegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 80000) {//删除订单
        if (buttonIndex == 1) {
            [self deleteOrder:selectOrder.orderSn andIndex:selectIndex];
        }
    }else if (alertView.tag == 80001){//关闭订单
        if (buttonIndex == 1) {
            [self closeOrder:selectOrder.orderSn andIndex:selectIndex];
        }
    }else if(alertView.tag == 100023){
        if (buttonIndex ==1) {
            [CYWebClient Post:@"Receipt" parametes:@{@"orderSn":selectOrder.orderSn} success:^(id responObj) {
                if (!responObj) {
                    [self loadTableViewData:NO];
                    CYEvaluationViewController *vc = viewControllerInStoryBoard(@"CYEvaluationViewController", @"My");
                    //            [self.storyboard instantiateViewControllerWithIdentifier:@"CYEvaluationViewController"];
                    vc.blockBack= ^{
                        [self loadTableViewData:NO];
                    };
                    if ([selectOrder.comment_status integerValue] == 1) {
                        vc.isAppend = YES;
                    }else{
                        vc.isAppend = NO;
                    }
                    vc.model = selectOrder;
                    [self.navigationController pushViewController:vc animated:YES];

                    
                }
                
                
            } failure:^(id err) {
                NSLog(@"%@",err);
            }];
        }
   
    }
}

- (IBAction)shijiguangguang_click:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
}
@end
