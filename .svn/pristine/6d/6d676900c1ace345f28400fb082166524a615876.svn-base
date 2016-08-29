//
//  CYBuyerOrderDetailGoodsCell.h
//  茶语
//
//  Created by Leen on 16/6/15.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBuyerOrderDetailModel.h"
@class CYShopTrolleyModel;

@protocol CYBuyerOrderDetailGoodsCellDelegate;

@interface CYBuyerOrderDetailGoodsCell : UITableViewCell


+(instancetype)cellWidthTableView:(UITableView*)tableView;

/**
 *  商品信息
 */
@property (nonatomic,strong)CYBuyerOrderDetailModel *model;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)id<CYBuyerOrderDetailGoodsCellDelegate>delegate;

@end


@protocol CYBuyerOrderDetailGoodsCellDelegate <NSObject>

-(void)returnTheGoods:(CYShopTrolleyModel *)model;

@optional
- (void)goodsdetails:(CYShopTrolleyModel *)model;

@end
