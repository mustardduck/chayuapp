//
//  SKSTableViewCell.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableViewCell.h"
#import "SKSTableViewCellIndicator.h"

#define kIndicatorViewTag -1

@interface SKSTableViewCell ()

@end

@implementation SKSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandable = YES;
        self.expanded = NO;

        UILabel * titLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        
        UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(14, 10, 30, 30)];
        [self.contentView addSubview:imgIcon];
        self.icon = imgIcon;
        
        titLbl.x = imgIcon.x + imgIcon.width + 8;
        
        titLbl.textColor = RGBCOLOR(251, 251, 251);
        titLbl.backgroundColor = [UIColor clearColor];
        titLbl.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:titLbl];
        self.titleLbl = titLbl;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier showSelectBtn:(BOOL)isShowSelectBtn
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandable = YES;
        self.expanded = NO;
        
        UILabel * titLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        
        if(isShowSelectBtn)
        {
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(35, 17, 16, 16)];
            [btn setImage:[UIImage imageNamed:@"icon_correct_empty"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"icon_correct"] forState:UIControlStateSelected];
            [self.contentView addSubview:btn];
           
            [btn addTarget:self action:@selector(selectCell:) forControlEvents:UIControlEventTouchUpInside];
            
            self.selectBtn = btn;
            
            titLbl.x = btn.x + btn.width + 8;
            
        }
        else
        {
            UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(14, 10, 30, 30)];
            [self.contentView addSubview:imgIcon];
            self.icon = imgIcon;
            
            titLbl.x = imgIcon.x + imgIcon.width + 8;
            
        }
        
        titLbl.textColor = RGBCOLOR(251, 251, 251);
        titLbl.backgroundColor = [UIColor clearColor];
        titLbl.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:titLbl];
        self.titleLbl = titLbl;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isExpanded) {
        
//        if (![self containsIndicatorView])
//            [self addIndicatorView];
//        else {
//            [self removeIndicatorView];
//            [self addIndicatorView];
//        }
    }
}

- (void)selectCell:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectCellClicked:)]) {
        [self.delegate selectCellClicked:self];
    }
}

static UIImage *_image = nil;
- (UIView *)expandableView
{
    if (!_image) {
        _image = [UIImage imageNamed:@"downGrayArrowIcon"];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    button.frame = frame;
    
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    
    return button;
}

- (void)setExpandable:(BOOL)isExpandable
{
    if (isExpandable)
        [self setAccessoryView:[self expandableView]];
    
    _expandable = isExpandable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)addIndicatorView
{
    CGPoint point = self.accessoryView.center;
    CGRect bounds = self.accessoryView.bounds;
    
    CGRect frame = CGRectMake((point.x - CGRectGetWidth(bounds) * 1.5), point.y * 1.4, CGRectGetWidth(bounds) * 3.0, CGRectGetHeight(self.bounds) - point.y * 1.4);
    SKSTableViewCellIndicator *indicatorView = [[SKSTableViewCellIndicator alloc] initWithFrame:frame];
    indicatorView.tag = kIndicatorViewTag;
    [self.contentView addSubview:indicatorView];
}

- (void)removeIndicatorView
{
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    if (indicatorView)
    {
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}

- (BOOL)containsIndicatorView
{
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
}

- (void)accessoryViewAnimation
{
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isExpanded) {
            
            self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            
        } else {
            self.accessoryView.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finished) {
        
        if (!self.isExpanded)
            [self removeIndicatorView];
        
    }];
}

@end
