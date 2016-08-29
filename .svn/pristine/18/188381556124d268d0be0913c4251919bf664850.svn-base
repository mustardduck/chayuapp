//
//  CYHomeArticleCell.m
//  茶语
//
//  Created by Leen on 16/3/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeArticleCell.h"
#import "CYHomeInfo.h"

@implementation CYHomeArticleCell

- (void)parseData:(id)data
{
    CYHomeToDayNewsInfo *info = data;
    
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:[UIImage imageNamed:@"zwt_shiji"]];

    _mTitleLabel.text = info.title;
    _mZanLabel.text = info.suports;
    _mCommentLabel.text = info.comments;
//    if (info.created.length >=10) {
         _mDateLabel.text = info.clicks;
//    }
   
    
    self.mClickData = data;
}

- (void)setLastCell:(BOOL)lastCell
{
    _lastCell = lastCell;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (!_lastCell) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(12, rect.size.height)];
        [path addLineToPoint:CGPointMake(rect.size.width - 12, rect.size.height)];
        [[UIColor getColorWithHexString:@"dddddd"] setStroke];
        [path stroke];
    }
    
}


@end
