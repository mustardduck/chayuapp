//
//  CYOrderGoodsView.h
//  TeaMall
//
//  Created by Chayu on 15/11/6.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYShopTrolleyModel.h"

@protocol CYOrderGoodsViewDelegate;

@interface CYOrderGoodsView : UIView

@property (nonatomic,strong)CYShopTrolleyModel *goodsInfo;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;


/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)id<CYOrderGoodsViewDelegate>delegate;
/**
 *  为1时显示退款按钮，0不显示
 */
@property (nonatomic,strong)NSString *status;

@end


@protocol CYOrderGoodsViewDelegate <NSObject>

-(void)refundTheGoodsModel:(CYShopTrolleyModel *)model;

- (void)showgoodsdetails:(CYShopTrolleyModel *)model;

@end