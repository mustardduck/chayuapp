//
//  CYTeaReviewRatingCell.m
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaReviewRatingCell.h"

@implementation CYTeaReviewRatingCell

- (void)awakeFromNib {
    // Initialization code
    
    self.slipWidth.constant = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
