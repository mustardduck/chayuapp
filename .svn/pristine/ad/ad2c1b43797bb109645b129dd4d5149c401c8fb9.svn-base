//
//  CYArticleListCell.m
//  茶语
//
//  Created by 李峥 on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYArticleListCell.h"
#import "CYArticleInfo.h"

@implementation CYArticleListCell

- (void)parseData:(id)data
{
    CYArticleInfo *info = [CYArticleInfo objectWithKeyValues:data];
    
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:[UIImage imageNamed:@"zwt_width"]];
    
    _mTitleLabel.text = info.title;
    _mZanLabel.text = info.suports;
    _mCommentLabel.text = info.comments;
    _mDateLabel.text = info.created;

    
    
    self.mClickData = info;
}

@end
