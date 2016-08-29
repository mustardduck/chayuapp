//
//  CYCollectArticleCell.h
//  茶语
//
//  Created by Leen on 16/6/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"

@protocol CYCollectArticleCellDelegate;

@interface CYCollectArticleCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mZanLabel;
@property (weak, nonatomic) IBOutlet UILabel *mCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDateLabel;

@property (nonatomic, assign) BOOL lastCell;
 
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) id<CYCollectArticleCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellLeadingCons;

+ (instancetype)cellWidthTableView:(UITableView *)tableView;

@end

@protocol CYCollectArticleCellDelegate <NSObject>

- (void)selectCollectArticleCell:(CYCollectArticleCell *)cell;

@end