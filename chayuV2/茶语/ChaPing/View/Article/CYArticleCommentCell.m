//
//  CYArticleCommentCell.m
//  茶语
//
//  Created by 李峥 on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYArticleCommentCell.h"
#import "CYArticleCommentInfo.h"

static CYArticleCommentCell *__cell = nil;
@implementation CYArticleCommentCell

- (void)parseData:(id)data
{
    CYArticleCommentInfo *info = [CYArticleCommentInfo objectWithKeyValues:data];
    
    [_mUserImageView sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"zwt_width"]];
    _mNameLabel.text = info.nickname;
    
    if (info.toNickname.length) {
        _mNameLabel.text = [NSString stringWithFormat:@"%@@%@",info.nickname,info.toNickname];
    }
    
    _mDesLabel.text = info.content;
    _mDateLabel.text = info.created;
    _mGoodLabel.text = info.comments;
    _mZanLabel.text = info.suports;
    _zanImg.highlighted = info.isSuported;
    _mZanLabel.textColor = info.isSuported?MAIN_COLOR:LIGHTCOLOR;
    self.mClickData = info;
}

+ (CGFloat)calcCellHeight:(id)data
{
    if (__cell == nil) {
        __cell = [[[NSBundle mainBundle] loadNibNamed:@"CYArticleCommentCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    [__cell parseData:data];
    
    [__cell setNeedsUpdateConstraints];
    [__cell updateConstraintsIfNeeded];
    
    CGFloat height = [__cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    
    return height;
}

@end
