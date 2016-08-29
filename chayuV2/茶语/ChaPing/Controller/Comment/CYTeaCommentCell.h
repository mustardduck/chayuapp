//
//  CYTeaCommentCell.h
//  茶语
//
//  Created by 李峥 on 16/2/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"
#import "CYEvaCommentInfo.h"

@interface CYTeaCommentCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *mUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *mNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *mGoodLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mImageConstraintHeight;
@property (weak, nonatomic) IBOutlet UIView *imgcontentView;

@property (weak, nonatomic) IBOutlet UILabel *mZanLabel;

@property (weak, nonatomic) IBOutlet UIButton *commBtn;

@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *zanimg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableconsheight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tablebottomcons;

@property (copy,nonatomic)void (^zhankaiBlock)();

@property (copy,nonatomic)void (^huifuBlock)(NSDictionary *huifuInfo);

@property (copy,nonatomic)void (^dianzanBlock)(NSDictionary *);

@property (nonatomic, copy) void (^seeFullBlock)(NSInteger);

@end
