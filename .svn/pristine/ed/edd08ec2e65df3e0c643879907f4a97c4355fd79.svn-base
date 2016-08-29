//
//  CYPingPaiCollectionItem.m
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPingPaiCollectionItem.h"

@implementation CYPingPaiCollectionItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, rect.size.height)];
        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
        [[UIColor getColorWithHexString:@"ffffff"] setStroke];
        [path stroke];
        
        UIBezierPath *cpath = [UIBezierPath bezierPath];
        [cpath moveToPoint:CGPointMake(rect.size.width, 0)];
        [cpath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
        [[UIColor getColorWithHexString:@"ffffff"] setStroke];
        [cpath stroke];
    }
}


@end
