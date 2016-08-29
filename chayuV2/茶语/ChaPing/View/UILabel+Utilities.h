//
//  UILabel+Utilities.h
//  PYFramework
//
//  Created by 李峥 on 15/8/11.
//  Copyright (c) 2015年 李峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utilities)

/**
 *  动态计算label的高度，需先设置text
 *
 *  @return
 */
- (CGFloat)boundingRectWithHeight;

/**
 *  动态计算label的宽度，需先设置text
 *
 *  @return
 */
- (CGFloat)boundingRectWithWidth;

@end
