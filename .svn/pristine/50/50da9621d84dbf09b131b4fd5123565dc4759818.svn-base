//
//  CYBBSTitleView.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBBSTitleView.h"

@interface CYBBSTitleView ()
{
    BOOL installed;
    UISegmentedControl *segControl;
}

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *lengths;

@property (nonatomic, strong) UIView *leftSpacier;
@property (nonatomic, strong) UIView *rightSpacier;


@end

@implementation CYBBSTitleView

+ (instancetype)titleViewWithNames:(NSArray *)names
{
    CGFloat width = 0;
    NSMutableArray *lens = [NSMutableArray array];
    for (int i = 0; i < names.count; i++) {
        NSString *title = [names objectAtIndex:i];
        CGFloat currWidth = [self calcTitleWidth:title];
        [lens addObject:@(currWidth)];
        width += currWidth;
    }
    CYBBSTitleView *view = [[CYBBSTitleView alloc] initWithFrame:CGRectMake(0, 0, 135, 30)];
//    view.backgroundColor = [UIColor lightGrayColor];
    view.names = names;
    view.lengths = lens;

    return view;
}

- (void)layoutSubviews
{
    NSArray *subs = self.subviews;
    [subs makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.names.count == 0) {
        return ;
    }
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:self.names];
    seg.frame = self.bounds;
    seg.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    for (int i = 0; i < self.names.count; i++) {
        NSString *name = [self.names objectAtIndex:i];
        [seg setTitle:name forSegmentAtIndex:i];
    }
    if (self.names.count > 0) {
        [seg setSelectedSegmentIndex:self.selectedIndex];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.],NSFontAttributeName,nil];
    [seg setTitleTextAttributes:dic forState:UIControlStateSelected];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:MAIN_COLOR,NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.],NSFontAttributeName,nil];
    [seg setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    
    seg.tintColor = MAIN_COLOR;
    [seg addTarget:self action:@selector(onSegValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:seg];
    segControl = seg;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex) {
        return ;
    }
    
//    UIButton *last = (UIButton *)[self viewWithTag:_selectedIndex + 10086];
//    last.selected = NO;
//    UIButton *fresh = (UIButton *)[self viewWithTag:selectedIndex + 10086];
//    fresh.selected = YES;
    segControl.selectedSegmentIndex = selectedIndex;
    _selectedIndex = selectedIndex;
}

- (void)onButtonClicked:(UIButton *)button
{
    self.selectedIndex = button.tag - 10086;
    if (self.callback) {
        self.callback(_selectedIndex);
    }
}

- (void)onSegValueChanged:(UISegmentedControl *)seg
{
    self.selectedIndex = seg.selectedSegmentIndex;
    if (self.callback) {
        self.callback(_selectedIndex);
    }
}

+ (CGFloat)calcTitleWidth:(NSString *)title
{
    CGFloat width = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width;
    width += 30;
    return width;
}

@end
