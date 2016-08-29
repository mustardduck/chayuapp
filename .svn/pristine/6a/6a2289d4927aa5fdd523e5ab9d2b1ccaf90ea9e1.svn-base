//
//  CYBuyerPDTopView.h
//  茶语
//
//  Created by Leen on 16/6/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CYProductDetailsModel.h"

@protocol CYBuyerPDTopViewDelegate <NSObject>
@optional
-(void)selectMenu:(NSInteger)selectIndex;
-(void)selectSpecification;
-(void)shareGoods;
-(void)understandTheMaster;
-(void)attention;
-(void)allevaluation;
-(void)selectCity;
- (void) PDTopViewlikeClicked;
@end

@interface CYBuyerPDTopView : UIView

@property (nonatomic,strong)CYProductDetailsModel *productModel;
@property (nonatomic,assign)id<CYBuyerPDTopViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *xihuanImg;

/**
 *  是否已关注
 */
@property (nonatomic,assign)BOOL isAttention;

@property (nonatomic,assign)CGFloat endHeight;

@end
