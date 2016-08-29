//
//  CYTeaReviewScoreCell.h
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTeaReviewScoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mReviewScodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *mRecLabel;
@property (weak, nonatomic) IBOutlet UILabel *mPriceLabel;

@property (weak, nonatomic) IBOutlet UIView *zhishuBg;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;


@end
