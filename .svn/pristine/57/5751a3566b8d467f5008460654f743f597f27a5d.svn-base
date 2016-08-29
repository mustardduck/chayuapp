//
//  CYBuyerOrderDetailFooterView.h
//  茶语
//
//  Created by Leen on 16/6/15.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBuyerOrderDetailModel.h"

@protocol CYBuyerOrderDetailFooterViewDelegate;

@interface CYBuyerOrderDetailFooterView : UIView

/**
 *  商品详细信息
 */
@property (nonatomic,strong)CYBuyerOrderDetailModel *model;

/**
 *  <#属性说明#>
 */
@property (nonatomic,assign)id<CYBuyerOrderDetailFooterViewDelegate>delegate;

@end

@protocol CYBuyerOrderDetailFooterViewDelegate <NSObject>

-(void)unfoldTheCell:(BOOL)show;


-(void)publicVeew:(CYBuyerOrderDetailFooterView *)cell AndModel:(CYBuyerOrderDetailModel*)model;

-(void)deleteView:(CYBuyerOrderDetailFooterView *)cell WithModel:(CYBuyerOrderDetailModel *)model;


@end