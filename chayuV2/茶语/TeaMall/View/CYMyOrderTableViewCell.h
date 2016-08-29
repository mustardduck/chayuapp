//
//  CYMyOrderTableViewCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/6.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYOrderInfoModel.h"

typedef NS_ENUM(NSInteger,OrderType){
    OrderTypeAll = 0,       //全部
    OrderTypePendingPayment,//待付款
    OrderTypePendingShipped,//待发货
    OrderTypeInbound,       //待收货
    OrderTypeEvaluated,      //待评价
    OrderTypeRefund //退款
};

#define BASECELLHEIGHT  217.0f

@protocol CYMyOrderTableViewCellDelegate;

@interface CYMyOrderTableViewCell : UITableViewCell
@property (nonatomic,strong)CYOrderInfoModel *orderModel;
@property (nonatomic,assign)OrderType ordertype;
@property (nonatomic,strong)id<CYMyOrderTableViewCellDelegate>delegate;
+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (weak, nonatomic) IBOutlet CYBorderButton *wuliuBtn;


@end


@protocol CYMyOrderTableViewCellDelegate <NSObject>

-(void)publicCell:(CYMyOrderTableViewCell *)cell AndModel:(CYOrderInfoModel*)model;

-(void)deleteCell:(CYMyOrderTableViewCell *)cell WithModel:(CYOrderInfoModel *)model;


-(void)chakanwuliu:(CYOrderInfoModel *)model;

@end