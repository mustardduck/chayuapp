//
//  CYOrderDetailFooterView.h
//  TeaMall
//
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYOrderDetailModel.h"

@protocol CYOrderDetailFooterViewDelegate;

@interface CYOrderDetailFooterView : UIView

/**
 *  商品详细信息
 */
@property (nonatomic,strong)CYOrderDetailModel *model;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)id<CYOrderDetailFooterViewDelegate>delegate;


@property (weak, nonatomic) IBOutlet CYBorderButton *wuliuBtn;

@end

@protocol CYOrderDetailFooterViewDelegate <NSObject>

-(void)unfoldTheCell:(BOOL)show;


-(void)publicVeew:(CYOrderDetailFooterView *)cell AndModel:(CYOrderDetailModel*)model;

-(void)deleteView:(CYOrderDetailFooterView *)cell WithModel:(CYOrderDetailModel *)model;


@end