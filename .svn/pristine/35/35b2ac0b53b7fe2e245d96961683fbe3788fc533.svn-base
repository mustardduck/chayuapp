//
//  PYRatingView.h
//  Frameworks
//
//  Created by 李 峥 on 14/11/28.
//  Copyright (c) 2014年 李 峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PYRatingViewDelegate;

/**
 *  星星评分,支持半颗心
 */
@interface PYRatingView : UIView

/**
 *  间距 默认为5 如需自定义需在调用set方法前设置
 */
@property (nonatomic, assign) CGFloat iSpacing;

/**
 *  设置各个评分状态下的图标 （必须设置，无默认状态）
 *
 *  @param unselectedImage     无评分图标
 *  @param partlySelectedImage 半颗星图标
 *  @param fullSelectedImage   满星图标
 *  @param delegate            代理
 */
-(void)setImagesDeselected:(NSString *)unselectedImage
            partlySelected:(NSString *)partlySelectedImage
              fullSelected:(NSString *)fullSelectedImage
               andDelegate:(id<PYRatingViewDelegate>)delegate;
/**
 *  设置当前分数
 *
 *  @param rating 分数 float
 */
-(void)displayRating:(CGFloat)rating;

/**
 *  获取当前分数
 *
 *  @return
 */
-(CGFloat)rating;



@end



@protocol PYRatingViewDelegate
@optional
-(void)ratingChanged:(float)newRating andPYRatingView:(PYRatingView *)view;

@end

