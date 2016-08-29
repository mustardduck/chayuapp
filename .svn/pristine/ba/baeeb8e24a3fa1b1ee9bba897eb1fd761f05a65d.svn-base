//
//  CYEvaFooterCollectionView.m
//  茶语
//
//  Created by 李峥 on 16/3/30.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYEvaFooterCollectionView.h"

@implementation CYEvaFooterCollectionView

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIBezierPath *tpath = [UIBezierPath bezierPath];
    [tpath moveToPoint:CGPointMake(0, 0)];
    [tpath addLineToPoint:CGPointMake(rect.size.width, 0)];
    [[UIColor getColorWithHexString:@"dddddd"] setStroke];
    [tpath stroke];
}

@end
