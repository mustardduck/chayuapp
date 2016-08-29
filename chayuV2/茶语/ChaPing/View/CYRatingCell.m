//
//  CYRatingCell.m
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYRatingCell.h"

@implementation CYRatingCell

- (void)awakeFromNib {
    // Initialization code
    _mRatingView.iSpacing = 6;
    [_mRatingView setImagesDeselected:@"eva03" partlySelected:@"eva02" fullSelected:@"eva01" andDelegate:self];
}

- (void)ratingChanged:(float)newRating
{
    self.mNumLabel.text = [NSString stringWithFormat:@"%.1f",newRating*2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
