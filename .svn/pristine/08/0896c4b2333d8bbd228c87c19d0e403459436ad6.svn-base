//
//  BaseImageView.m
//  鲜蜂队
//
//  Created by Chayu on 15/12/28.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "BaseImageView.h"

@implementation BaseImageView

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


@end
