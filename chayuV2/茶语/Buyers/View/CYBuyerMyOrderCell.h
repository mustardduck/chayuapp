//
//  CYBuyerMyOrderCell.h
//  茶语
//
//  Created by Leen on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBuyerOrderInfoModel.h"

typedef NS_ENUM(NSInteger,BuyerOrderType){
    BuyerOrderTypeAll = 0,       //全部
    BuyerOrderTypePendingPayment,//待付款
    BuyerOrderTypePendingShipped,//待发货
    BuyerOrderTypeOnTheWay,       //已发货
    BuyerOrderTypeDone,      //已完成
    BuyerOrderTypeRefund //退款
};

#define BASECELLHEIGHT  245.0f

@protocol CYBuyerMyOrderCellDelegate;

@interface CYBuyerMyOrderCell : UITableViewCell
@property (nonatomic,strong) CYBuyerOrderInfoModel *orderModel;
@property (nonatomic,assign) BuyerOrderType ordertype;
+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *customerImgView;
@property (weak, nonatomic) IBOutlet UILabel *customerLbl;

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLbl;
@property (weak, nonatomic) IBOutlet UIView *orderView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderViewHeightCons;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLbl;
@property (weak, nonatomic) IBOutlet UIButton *orderDetailBtn;
@property (nonatomic,strong)id<CYBuyerMyOrderCellDelegate>delegate;

@end

@protocol CYBuyerMyOrderCellDelegate <NSObject>

-(void)publicCell:(CYBuyerMyOrderCell *)cell AndModel:(CYBuyerOrderInfoModel*)model;
//
//-(void)deleteCell:(CYBuyerMyOrderCell *)cell WithModel:(CYBuyerOrderInfoModel *)model;
//
//
//-(void)chakanwuliu:(CYOrderInfoModel *)model;

@end
