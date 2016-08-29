//
//  CYOrderDetailGoodsCell.h
//  TeaMall
//  商品信息
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYOrderDetailModel.h"
@class CYShopTrolleyModel;


@protocol CYOrderDetailGoodsCellDelegate;
@interface CYOrderDetailGoodsCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

/**
 *  商品信息
 */
@property (nonatomic,strong)CYOrderDetailModel *model;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)id<CYOrderDetailGoodsCellDelegate>delegate;

@end


@protocol CYOrderDetailGoodsCellDelegate <NSObject>

-(void)returnTheGoods:(CYShopTrolleyModel *)model;

@optional
- (void)goodsdetails:(CYShopTrolleyModel *)model;

@end