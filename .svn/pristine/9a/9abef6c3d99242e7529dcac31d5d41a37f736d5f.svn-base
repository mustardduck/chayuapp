//
//  CYCollectTopicCell.h
//  茶语
//
//  Created by Leen on 16/6/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"

@protocol CYCollectTopicCellDelegate;

@interface CYCollectTopicCell : BaseCell

@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) id<CYCollectTopicCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellLeadingCons;

+ (instancetype)cellWidthTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *pinglunLbl;

@property (weak, nonatomic) IBOutlet UILabel *liulanLbl;

@end

@protocol CYCollectTopicCellDelegate <NSObject>

- (void)selectCollectTopicCell:(CYCollectTopicCell *)cell;

@end