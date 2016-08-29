//
//  CYCollectTeaSampleCell.h
//  茶语
//
//  Created by Leen on 16/5/31.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"
#import "CYTeaSampleInfo.h"
#import "PYMultiLabel.h"
#import "CYCollectTeaReviewCell.h"

@protocol CYCollectTeaSampleCellDelegate;

@interface CYCollectTeaSampleCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet PYMultiLabel *mStockLabel;
@property (weak, nonatomic) IBOutlet PYMultiLabel *mPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet PYMultiLabel *mYDLabel;

@property (nonatomic, strong) id<CYCollectTeaSampleCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLeadingCons;
+ (instancetype)cellWidthTableView:(UITableView *)tableView;


@end

@protocol CYCollectTeaSampleCellDelegate <NSObject>

- (void)selectCollectTeaSampleCell:(CYCollectTeaSampleCell *)cell;

@end
