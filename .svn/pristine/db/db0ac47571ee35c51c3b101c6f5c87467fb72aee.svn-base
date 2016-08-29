//
//  CYHomeBrandCell.m
//  茶语
//
//  Created by 李峥 on 16/3/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeBrandCell.h"
#import "UILabel+Utilities.h"

@implementation CYHomeBrandCell

- (void)awakeFromNib
{
    self.mNumberLabel.layer.cornerRadius = 7;
    self.mNumberLabel.layer.masksToBounds = YES;
}


- (void)setInfo:(NSDictionary *)info{
    _info = info;
    
    CGFloat labelw = [self.mNumberLabel boundingRectWithWidth];
    CGFloat w = labelw + 6;
    if (w < 14) {
        w = 14;
    }
    self.mNumWidthCons.constant = w;
    
}

@end
