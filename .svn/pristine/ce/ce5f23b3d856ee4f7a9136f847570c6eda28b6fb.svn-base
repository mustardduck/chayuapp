//
//  NTNavigationBar.m
//  Nvigationbar
//
//  Created by Chayu on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "NTNavigationBar.h"

#define SC_WIDTH [UIScreen mainScreen].bounds.size.width

@interface NTNavigationBar ()

@property (nonatomic,strong,nonnull)UILabel *titleLable;

@property (nonnull,strong,nonatomic)UIView *leftView;

@property (nonatomic,strong,nonnull)UIView *rightView;

@end

@implementation NTNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height-1,SC_WIDTH,1)];
        line.backgroundColor = [UIColor lightGrayColor];
        line.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
        [self addSubview:line];
    }
    
    return  self;
}




- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = [UIFont systemFontOfSize:17];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLable];
    }
    return _titleLable;
}
- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0,20,90,self.frame.size.height-20)];
        _leftView.backgroundColor = [UIColor clearColor];
    }
    return _leftView;
}


- (UIView *)rightView
{
    if (!_rightView) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90,20,90,self.frame.size.height-20)];
        _rightView.backgroundColor = [UIColor clearColor];
    }
    return _rightView;
}

-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleLable.textColor = _titleColor;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLable.text = _title;
    [_titleLable sizeToFit];
    CGRect titleLblrect = _titleLable.frame;
    if (titleLblrect.size.width>SCREEN_WIDTH - 180) {
        titleLblrect.size.width = SCREEN_WIDTH-180;
        _titleLable.frame = titleLblrect;
    }
    _titleLable.center = self.center;
    
}


-(void)setTitleView:(UIView *)titleView
{
    _titleView = titleView;
    _titleView.center = self.center;
    [self addSubview:_titleView];
}


-(void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem
{
    if (leftBarButtonItem) {
        _leftBarButtonItem = leftBarButtonItem;
        _leftBarButtonItem.frame = CGRectMake(0, 0,50,self.leftView.frame.size.height);
        [self.leftView addSubview:_leftBarButtonItem];
    }else{
        [self.leftView removeFromSuperview];
    }

    
}

- (void)setLeftBarButtonItems:(NSArray<UIButton *> *)leftBarButtonItems
{
    
}

-(void)setRightBarButtonItem:(UIButton *)rightBarButtonItem
{
    _rightBarButtonItem = rightBarButtonItem;
    _rightBarButtonItem.frame = self.rightView.bounds;
    [self.rightView addSubview:_rightBarButtonItem];
}


-(void)setRightBarButtonItems:(NSArray<UIButton *> *)rightBarButtonItems
{
    
    _rightBarButtonItems = rightBarButtonItems;
    CGFloat button_width = self.rightView.frame.size.width/[_rightBarButtonItems count];
    for (int i =0;i<[_rightBarButtonItems count];i++) {
        UIButton *button = _rightBarButtonItems[i];
        button.frame = CGRectMake(i*button_width, 0,button_width,self.rightView.frame.size.height);
        [self.rightView addSubview:button];
        NSLog(@"button.frame = %@",NSStringFromCGRect(button.frame));
    }
}

@end
