//
//  CYBuyerMyOrderDetailVC.m
//  茶语
//
//  Created by Leen on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerMyOrderDetailVC.h"
#import "CYBuyerOrderDetailModel.h"
#import "CYBuyerOrderDetailFooterView.h"
#import "CYBuyerOrderDetailGoodsCell.h"
#import "CYGiftTableViewCell.h"
#import "CYInvoiceInfoCell.h"
#import "CYDeliveryInfoTableViewCell.h"
#import "CYOrderInfoCell.h"
#import "CYOrderPriceCell.h"
#import "CYProductDetViewController.h"


#define DEFAULTCELL_HEIGHT 88.0

@interface CYBuyerMyOrderDetailVC ()<UITableViewDataSource,UITableViewDelegate,CYBuyerOrderDetailFooterViewDelegate,CYBuyerOrderDetailGoodsCellDelegate>
{
    NSMutableArray *_dataArr;
    CYBuyerOrderDetailModel *detailModel;
    CGFloat firstCellHeight;
    CYBuyerOrderDetailModel *selectOrder;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_cons;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//- (IBAction)goback:(id)sender;

- (IBAction)pay_click:(id)sender;

@property (nonatomic,strong)CYBuyerOrderDetailFooterView *footerView;

@property (weak, nonatomic) IBOutlet CYBorderButton *brownBtn;

@property (weak, nonatomic) IBOutlet CYBorderButton *clearBtn;


@end

@implementation CYBuyerMyOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.barStyle = NavBarStyleNoneMore;
    _dataArr = [[NSMutableArray alloc] init];
    firstCellHeight = DEFAULTCELL_HEIGHT;
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
    [self loadOrderData];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}


-(void)loadOrderData
{
    [_dataArr removeAllObjects];
    __weak __typeof(self) weakSelf = self;
//    [CYWebClient Post:@"OrderDetail" parametes:@{@"orderSn":_model.orderSn} success:^(id responObject) {
//        NSLog(@"%@",responObject);
//        detailModel = [CYOrderDetailModel objectWithKeyValues:responObject];
//        [_dataArr addObjectsFromArray:detailModel.goodsList];
//        //        if ([_dataArr count]>=2) {
//        //            firstCellHeight = DEFAULTCELL_HEIGHT+89;
//        //        }
//        firstCellHeight = DEFAULTCELL_HEIGHT *[_dataArr count];
//        if ([detailModel.status integerValue]!=2) {
//            weakSelf.footerView.height = 80;
//        }
//        
//        weakSelf.footerView.model  = detailModel;
//        [weakSelf.tableView reloadData];
//    } failure:^(id error) {
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)goback:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (IBAction)pay_click:(id)sender {
    //[1待付款，2待发货，3待收货，4待评价，5交易成功，6交易关闭，7追加评价]
//    NSInteger state = [_model.status integerValue];
//    switch (state) {
//        case 1:
//        {
//            CYPayTableViewController *vc =viewControllerInStoryBoard(@"CYPayTableViewController", @"TeaMall");
//            vc.orderId = detailModel.orderSn;
//            vc.price = detailModel.orderPrice;
//            [self.navigationController pushViewController:vc animated:YES];
//            break;
//        }
//        case 4:
//        {
//            break;
//        }
//        case 5:
//        {
//            break;
//        }
//        case 2:
//        case 3:
//        case 6:
//        case 7:
//        {
//            break;
//        }
//        default:
//            break;
//    }
}

- (CYBuyerOrderDetailFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerOrderDetailFooterView" owner:nil options:nil] firstObject];
        _footerView.delegate = self;
        _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,45);
    }
    return _footerView;
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
    return 6;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 2) {
//        if (detailModel.goodsordergift.count>0) {
//            return 80.0f + (detailModel.goodsordergift.count -1) *38;
//        }
//        else{
//            return 0.0f;
//        }
//        
//    }else if (indexPath.section == 3){
//        return 120.0f;
//    }else if (indexPath.section == 4){
//        if (!detailModel.buyersMessage.length) {
//            return 0;
//        }else{
//            return 80.0f;
//        }
//        
//    }else if(indexPath.section == 5){
//        return 120.0f;
//    }else if(indexPath.section == 1){
//        return 282.;
//        
//    }else{
//        return firstCellHeight;
//    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (indexPath.section == 0) {
        CYBuyerOrderDetailGoodsCell *cell = [CYBuyerOrderDetailGoodsCell cellWidthTableView:tableView];
        cell.model = detailModel;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 2){
        if (detailModel.goodsordergift.count) {
            CYGiftTableViewCell *cell = [CYGiftTableViewCell cellWidthTableView:tableView];
            if ([detailModel.goodsordergift count]>0) {
                cell.goodsordergift = detailModel.goodsordergift;
            }
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"giftcell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"giftcell"];
            }
            return cell;
        }
        
        
    }else if(indexPath.section == 3){
        CYDeliveryInfoTableViewCell *cell = [CYDeliveryInfoTableViewCell cellWidthTableView:tableView];
        cell.deliverInfo = detailModel.dataDeliver;
        return cell;
        
    }else if (indexPath.section == 4){
        if (detailModel.buyersMessage.length) {
            CYInvoiceInfoCell *cell = [CYInvoiceInfoCell cellWidthTableView:tableView];
            if (detailModel) {
                cell.invoiceInfo = @{@"invPayee":detailModel.invPayee,@"buyersMessage":detailModel.buyersMessage};
            }
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"invcell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"invcell"];
            }
            return cell;
        }
        
        
        
    }else if(indexPath.section == 5){
        CYOrderInfoCell *cell = [CYOrderInfoCell cellWidthTableView:tableView];
        if (detailModel) {
            NSString *payPlatFrom = detailModel.payPlatform;
            if (!payPlatFrom) {
                payPlatFrom = @"";
            }
            cell.orderinfo = @{@"created":detailModel.created,@"payPlatform":payPlatFrom,@"orderSn":detailModel.orderSn};
        }
        
        return cell;
    }else{
        CYOrderPriceCell *cell = [CYOrderPriceCell cellWidthTableView:tableView];
        if (detailModel) {
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            [info setObject:detailModel.orderPrice forKey:@"goods_amount"];
            [info setObject:detailModel.coupon_price forKey:@"coupon_price"];
            [info setObject:detailModel.ship_price forKey:@"ship_price"];
            [info setObject:detailModel.goods_amount forKey:@"orderPrice"];
            [info setObject:detailModel.isEditOrderPrice forKey:@"isEditOrderPrice"];
            cell.priceInfo = info;
            cell.sellerInfo = detailModel.seller;
        }
        
        return cell;
    }
     */
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    /*
    if (section>0) {
        if (section == 2) {
            if (detailModel.goodsordergift.count) {
                return 10.;
            }else{
                return 0.000000001;
            }
        }
        
        if (section == 4) {
            if (detailModel.buyersMessage.length) {
                return 10.0;
            }else{
                return 0.00000001;
            }
        }
        return 10;
    }else{
        return 0.000000001;
    }
     */
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    /*
    if (section > 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = CLEARCOLOR;
        if (section ==2) {
            if (detailModel.goodsordergift.count) {
                view.height = 10.;
            }else{
                view.height = 0.0;
            }
        }
        
        if (section ==4) {
            if (detailModel.buyersMessage.length) {
                view.height = 10;
            }else{
                view.height = 0.0;
            }
        }
        return view;
    }else{
        return nil;
    }
    */
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return self.footerView.height;
    }else{
        return 0.0000000001;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return self.footerView;
    }else{
        return nil;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -
#pragma mark CYOrderDetailFooterViewDelegate method

-(void)unfoldTheCell:(BOOL)show
{
    if (show) {
        if ([_dataArr count]>2) {
            firstCellHeight = DEFAULTCELL_HEIGHT +([_dataArr count]-1)*89;
        }    }else{
            if ([_dataArr count]>2) {
                firstCellHeight = DEFAULTCELL_HEIGHT +89;
            }else{
                firstCellHeight = DEFAULTCELL_HEIGHT;
            }
        }
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)deleteView:(CYBuyerOrderDetailFooterView *)cell WithModel:(CYBuyerOrderDetailModel *)model
{
    /*
    selectOrder = model;
    //订单状态(string) [1待付款，2待发货，3待收货，5交易成功，6交易关闭]
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
        case 5:
        case 6:{
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要删除订单！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alt.tag = 80000;
            [alt show];
            
            break;
        }
            
        default:
            break;
    }
     */
    
}
-(void)publicVeew:(CYBuyerOrderDetailFooterView *)cell AndModel:(CYBuyerOrderDetailModel *)model
{
    /*
    selectOrder = model;
    //订单状态(string) [1待付款，2待发货，3待收货，5交易成功，6交易关闭]
    NSInteger status = [model.status integerValue];
    switch (status) {
        case 1:
        {
            CYPayTableViewController *vc = viewControllerInStoryBoard(@"CYPayTableViewController", @"TeaMall");
            vc.orderId = model.orderSn;
            vc.price = model.orderPrice;
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
                                                cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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
                    //                    [self loadOrderData];
                    if (self.changeOrderBlock) {
                        self.changeOrderBlock();
                    }
                };
                if ([model.comment_status integerValue] == 1) {
                    vc.isAppend = YES;
                }else{
                    vc.isAppend = NO;
                }
                vc.model = _model;
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
    */
    
    
}


#pragma mark -
#pragma mark CYOrderDetailGoodsCellDelegate method
- (void)returnTheGoods:(CYShopTrolleyModel *)model
{
    /*
    
    NSInteger refundType = [model.backInfo[@"refundType"] integerValue];
    if (refundType == 1 || refundType == 2) {//
        CYRefundDetailViewController *vc = viewControllerInStoryBoard(@"CYRefundDetailViewController", @"My");
        CYRefundModel *refmodel = [[CYRefundModel alloc] init];
        refmodel.refundType = model.backInfo[@"refundType"];
        refmodel.status = model.backInfo[@"status"];
        refmodel.shippingStatus = model.backInfo[@"shippingStatus"];
        refmodel.orderSn = detailModel.orderSn;
        refmodel.specDataId = model.specdataId;
        refmodel.refund_price = model.refund_price;
        refmodel.good_id = model.goods_id;
        refmodel.name = model.name;
        refmodel.orderState = detailModel.status;
        vc.model = refmodel;
        
        vc.refundcancelBlock = ^(){
            //           [self loadOrderData];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        CYApplyRerundViewController *vc = viewControllerInStoryBoard(@"CYApplyRerundViewController", @"My");
        vc.model = model;
        vc.orderModel = detailModel;
        vc.states = detailModel.status;
        vc.applyBlock = ^(){
            //            [self loadOrderData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    */
    
}


- (void)goodsdetails:(CYShopTrolleyModel *)model
{
    CYProductDetViewController *vc= viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
//    vc.goodId = model.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  删除订单
 */
-(void)deleteOrder:(NSString *)orderId andIndex:(NSIndexPath *)index
{
    [CYWebClient Post:@"DelOrder" parametes:@{@"orderSn":orderId} success:^(id responObj) {
        if (!responObj) {
            if (self.changeOrderBlock) {
                self.changeOrderBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
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
        if (!responObj) {
            if (self.changeOrderBlock) {
                self.changeOrderBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

#pragma mark -
#pragma mark UIAlertViewDelegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /*
    if (alertView.tag == 80000) {//删除订单
        if (buttonIndex == 1) {
            
            
            [self deleteOrder:selectOrder.orderSn andIndex:0];
        }
    }else if (alertView.tag == 80001){//关闭订单
        if (buttonIndex == 1) {
            
            [self closeOrder:selectOrder.orderSn andIndex:0];
        }
    }else if (alertView.tag == 100023){
        
        if (buttonIndex == 1) {
            [CYWebClient Post:@"Receipt" parametes:@{@"orderSn":selectOrder.orderSn} success:^(id responObj) {
                NSLog(@"responObj %@",responObj);
                if (!responObj) {
                    if (self.changeOrderBlock) {
                        self.changeOrderBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(id err) {
                NSLog(@"%@",err);
            }];
            
        }
    }
     */
}

@end
