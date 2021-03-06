//
//  CYCollectTeaReviewCell.h
//  茶语
//
//  Created by Leen on 16/5/30.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"
#import "CYTeaReviewInfo.h"

@protocol CYCollectTeaReviewCellDelegate;

@interface CYCollectTeaReviewCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mComplexLabel;
@property (weak, nonatomic) IBOutlet UILabel *mOfficialLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *kucunLbl;

@property (weak, nonatomic) IBOutlet UIButton *duihuanBtn;


@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) id<CYCollectTeaReviewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellLeadingCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *totalPointLeadingConsFor4Inch;

+ (instancetype)cellWidthTableView:(UITableView *)tableView;

@end

@protocol CYCollectTeaReviewCellDelegate <NSObject>

- (void)selectCollectTeaReviewCell:(CYCollectTeaReviewCell *)cell;

@end
