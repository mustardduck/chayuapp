//
//  CYTeaReviewDetailFooterView.m
//  茶语
//
//  Created by 李峥 on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaReviewDetailFooterView.h"

@implementation CYTeaReviewDetailFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    UIView *slip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5)];
    slip.backgroundColor = UIColorFromRGB(0xbbbbbb);
    
    CGFloat width = CGRectGetWidth(self.frame)/2 - 12 - 4;
    
    _mCommentTeaBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 14, width, 45)];
    [_mCommentTeaBtn setTitle:@"我要评茶" forState:UIControlStateNormal];
    [_mCommentTeaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _mCommentTeaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _mCommentTeaBtn.backgroundColor = MAIN_COLOR;
//    _mCommentTeaBtn.layer.borderColor = RGB(137, 62, 32).CGColor;
//    _mCommentTeaBtn.layer.borderWidth = 1.5;
    _mCommentTeaBtn.layer.masksToBounds = YES;
    _mCommentTeaBtn.layer.cornerRadius = 4;
    
    _mCommentNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(12+8+width, 14, width, 45)];
    [_mCommentNumBtn setTitle:@"0条评论" forState:UIControlStateNormal];
    [_mCommentNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _mCommentNumBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _mCommentNumBtn.backgroundColor = MAIN_COLOR;
//    _mCommentNumBtn.layer.borderColor = RGB(137, 62, 32).CGColor;
//    _mCommentNumBtn.layer.borderWidth = 1.5;
    _mCommentNumBtn.layer.masksToBounds = YES;
    _mCommentNumBtn.layer.cornerRadius = 4;
    
    [self addSubview:slip];
    [self addSubview:_mCommentTeaBtn];
    [self addSubview:_mCommentNumBtn];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(12, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - 12, 0)];
    [RGB(205, 205, 205) setStroke];
    [path stroke];
    
}


@end
