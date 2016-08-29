//
//  BaseButton.m
//  鲜蜂队
//
//  Created by Chayu on 15/12/21.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
    [self setNeedsDisplay];
}

-  (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.masksToBounds = _cornerRadius>0;
    self.layer.cornerRadius = _cornerRadius;
    [self setNeedsDisplay];
}

+ (BaseButton *)initWithStyle:(UIButtonType)buttonType Frame:(CGRect)rect Title:(NSString *)title TitleColor:(UIColor *)titleColor Font:(UIFont *)font{
    BaseButton *button = [BaseButton buttonWithType:buttonType];
    [button setFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

@end
