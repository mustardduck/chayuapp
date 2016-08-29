//
//  SlipView.m
//  茶语
//
//  Created by Leen on 16/3/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "SlipView.h"

@implementation SlipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect{
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,0.5);
    //线宽度
    CGContextSetStrokeColorWithColor(context,LINECOLOR.CGColor);
    CGFloat lengths[] = {4,2};
    if(self.lineStyle == 1)
    {
        
    }
    else{
        
        //先画4个点再画2个点
        CGContextSetLineDash(context,0, lengths,2);
    }
    //注意2(count)的值等于lengths数组的长度
    CGContextMoveToPoint(context,0 ,1);
    CGContextAddLineToPoint(context,CGRectGetWidth(self.frame),1);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}
@end
