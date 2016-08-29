//
//  CYArticleCommentCell.h
//  茶语
//
//  Created by 李峥 on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"

@interface CYArticleCommentCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *mUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *mNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *mGoodLabel;
@property (weak, nonatomic) IBOutlet UILabel *mZanLabel;

@property (weak, nonatomic) IBOutlet UIButton *commBtn;

@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *zanImg;


@end
