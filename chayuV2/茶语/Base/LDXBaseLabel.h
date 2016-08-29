//
//  CYBaseLabel.h
//  TeaTimer
//
//  Created by Leen on 15/7/13.
//  Copyright (c) 2015年 ChaYu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface LDXBaseLabel : UILabel

@property (nonatomic, assign) IBInspectable NSInteger style;
@end


@interface UILabel (Extension)
- (void) setLableStyle:(NSInteger)style;

@end