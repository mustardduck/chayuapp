//
//  CYTeaReviewRatingCell.h
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYRatingView.h"
@interface CYTeaReviewRatingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mScodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTeaReviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *mZJLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDRLabel;
@property (weak, nonatomic) IBOutlet UILabel *mUserLabel;

@property (weak, nonatomic) IBOutlet PYRatingView *teaView;
@property (weak, nonatomic) IBOutlet PYRatingView *zjView;

@property (weak, nonatomic) IBOutlet PYRatingView *drView;

@property (weak, nonatomic) IBOutlet PYRatingView *yhView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *slipWidth;
@end
