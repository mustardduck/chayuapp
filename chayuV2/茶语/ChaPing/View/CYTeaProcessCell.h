//
//  CYTeaProcessCell.h
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"

@interface CYTeaProcessCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *mNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mNameTopMargins;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mImgHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mImgTopMargins;

@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
- (void)parseData:(id)data atIndex:(NSInteger)idx;
+ (CGFloat)calcCellHeight:(id)data atIndex:(NSInteger)idx;

@property (weak, nonatomic) IBOutlet UIView *mtopColorView;
@property (weak, nonatomic) IBOutlet UILabel *mTimeLbl;

@property (weak, nonatomic) IBOutlet UILabel *mTemLbl;
@property (weak, nonatomic) IBOutlet UIView *timeAndTemView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timecenter_cons;
@property (weak, nonatomic) IBOutlet UIButton *seeFullBtn;

@end
