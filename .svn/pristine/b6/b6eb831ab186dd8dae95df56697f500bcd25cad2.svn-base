//
//  CYCollectArticleCell.m
//  茶语
//
//  Created by Leen on 16/6/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCollectArticleCell.h"
#import "CYArticleInfo.h"

@implementation CYCollectArticleCell

- (void)parseData:(id)data
{
    CYArticleInfo *info = [CYArticleInfo objectWithKeyValues:data];
    
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
    
    _mTitleLabel.text = info.title;
    _mZanLabel.text = info.suports;
    _mCommentLabel.text = info.comments;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[info.created integerValue]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    _mDateLabel.text = [df stringFromDate:date];
    df = nil;
    
    self.mClickData = info;
}

+ (instancetype)cellWidthTableView:(UITableView *)tableView
{
    static NSString *cellName = @"CYCollectArticleCell";
    CYCollectArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYCollectArticleCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (IBAction)selectBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectCollectArticleCell:)]) {
        [self.delegate selectCollectArticleCell:self];
    }
}


@end
