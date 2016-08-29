//
//  CYRatingCell.h
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYRatingView.h"

@interface CYRatingCell : UITableViewCell<PYRatingViewDelegate>
@property (weak, nonatomic) IBOutlet PYRatingView *mRatingView;
@property (weak, nonatomic) IBOutlet UILabel *mTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mNumLabel;

@end
