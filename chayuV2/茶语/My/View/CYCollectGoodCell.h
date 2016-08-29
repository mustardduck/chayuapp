//
//  CYCollectGoodCell.h
//  茶语
//
//  Created by Leen on 16/6/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"

@protocol CYCollectGoodCellDelegate;

@interface CYCollectGoodCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *mSellCountLbl;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) id<CYCollectGoodCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellLeadingCons;

+ (instancetype)cellWidthTableView:(UITableView *)tableView;

@end

@protocol CYCollectGoodCellDelegate <NSObject>

- (void)selectCollectGoodCell:(CYCollectGoodCell *)cell;

@end
