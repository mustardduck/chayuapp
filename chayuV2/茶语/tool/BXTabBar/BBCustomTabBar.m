//
//  BBCustomTabBar.m
//  CannesClub
//
//  Created by box on 14-8-11.
//  Copyright (c) 2014年 box. All rights reserved.
//

#import "BBCustomTabBar.h"

@interface BBCustomTabBar(){
}


- (IBAction)onClickBtns:(UIButton *)sender;


@end

@implementation BBCustomTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRootView:) name:tabBarIndex object:nil];
    _selectedIndex = -1;//未选中
    self.selectedIndex = 0;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_background"]];
//    self.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.layer.shadowOpacity = 1.;
//    self.layer.shadowRadius = 1.;
//    self.layer.shadowOffset = CGSizeMake(0, -1);
}

-(void)setRootView:(NSNotification *)sender
{
    NSDictionary *info = sender.object;
    NSInteger select = [[info objectForJSONKey:@"selectIndex"] integerValue];
    self.selectedIndex =  select;
    if (_delegate && [_delegate respondsToSelector:@selector(customTabBar:shouldSelectIndex:)]) {
//        shouldSelect = [_delegate customTabBar:self shouldSelectIndex:select];
        [self.delegate customTabBar:self didSelectIndex:select];
    }
//    self.mytabbar.selButton.tag = self.selectedIndex + 12000;
//    [self.mytabbar btnClick:self.mytabbar.selButton];
}




#pragma mark -
#pragma mark self define method
- (IBAction)onClickBtns:(UIButton *)sender {
    BOOL shouldSelect = YES;
    NSInteger index = sender.tag - 1100;
    if (_delegate && [_delegate respondsToSelector:@selector(customTabBar:shouldSelectIndex:)]) {
        shouldSelect = [_delegate customTabBar:self shouldSelectIndex:index];
    }
    
    if (shouldSelect) {
        self.selectedIndex = index;
    }
}


- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex == _selectedIndex) {
        return;
    }
    if (_selectedIndex != -1) {
        UIButton *curView = (UIButton *)[self viewWithTag:1100+_selectedIndex];
        curView.selected = NO;
    }
    _selectedIndex = selectedIndex;
    UIButton *curView = (UIButton *)[self viewWithTag:1100+_selectedIndex ];
    curView.selected = YES;
    self.tabBarController.selectedIndex = _selectedIndex;
    if (_delegate && [_delegate respondsToSelector:@selector(customTabBar:didSelectIndex:)]) {
        [_delegate customTabBar:self didSelectIndex:_selectedIndex];
    }
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated
{
    CGRect frame = self.frame;
    CGFloat y = self.tabBarController.view.frame.size.height - frame.size.height;
    BOOL isHidden = (frame.origin.y != y);
    
    if (isHidden == hidden) {
        return;
    }
    
    if (hidden) {
        frame.origin.y += frame.size.height;
    }else{
        frame.origin.y -= frame.size.height;
    }
    if (animated) {
        [UIView animateWithDuration:0.25f animations:^{
            self.frame = frame;
        }];
    }else{
        self.frame = frame;
    }
}


@end
