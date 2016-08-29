//
//  CYPDTopView.h
//  TeaMall
//
//  Created by Chayu on 15/10/26.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYProductDetailsModel.h"
#import "CYCarousel.h"

@protocol CYPDTopViewDelegate <NSObject>
@optional
-(void)selectMenu:(NSInteger)selectIndex;
-(void)selectSpecification;
-(void)shareGoods;
-(void)understandTheMaster;
-(void)attention;
-(void)allevaluation;
-(void)selectCity;
@end

@interface CYPDTopView : UIView

@property (nonatomic,strong)CYProductDetailsModel *productModel;
@property (nonatomic,assign)id<CYPDTopViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *yunfeiLbl;

@property (weak, nonatomic) IBOutlet UIImageView *xihuanImg;
@property (weak, nonatomic) IBOutlet UILabel *price_diff_app;

/**
 *  是否已关注
 */
@property (nonatomic,assign)BOOL isAttention;

@property (nonatomic,assign)CGFloat endHeight;

@property (nonatomic, copy) void(^seeFullBlock)(NSInteger);

@property (nonatomic,strong)CYCarousel *bannerView;


@end