//
//  CYEvaCollectionView.m
//  茶语
//
//  Created by 李峥 on 16/3/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYEvaCollectionView.h"

@implementation CYEvaCollectionView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNeedBorder:(BOOL)needBorder
{
    _needBorder = needBorder;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (_needBorder) {
//        UIBezierPath *tpath = [UIBezierPath bezierPath];
//        [tpath moveToPoint:CGPointMake(0, 0)];
//        [tpath addLineToPoint:CGPointMake(rect.size.width, 0)];
//        [[UIColor getColorWithHexString:@"dddddd"] setStroke];
//        [tpath stroke];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, rect.size.height)];
        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
        [[UIColor getColorWithHexString:@"dddddd"] setStroke];
        [path stroke];
        
        UIBezierPath *cpath = [UIBezierPath bezierPath];
        [cpath moveToPoint:CGPointMake(rect.size.width, 0)];
        [cpath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
        [[UIColor getColorWithHexString:@"dddddd"] setStroke];
        [cpath stroke];
    }else{
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:CGPointMake(0, rect.size.height)];
//        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
//        [[UIColor getColorWithHexString:@"ffffff"] setStroke];
//        [path stroke];
//        
//        UIBezierPath *cpath = [UIBezierPath bezierPath];
//        [cpath moveToPoint:CGPointMake(rect.size.width, 0)];
//        [cpath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
//        [[UIColor getColorWithHexString:@"ffffff"] setStroke];
//        [cpath stroke];
    }
    
        
}

@end
