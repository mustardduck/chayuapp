//
//  SlideSwitchView.m
//  Dishes
//
//  Created by 李 峥 on 14/12/29.
//  Copyright (c) 2014年 李 峥. All rights reserved.
//

#import "SlideSwitchView.h"

@interface SlideSwitchView ()<UIScrollViewDelegate>
{
    BOOL _isBuildUI;
    CGFloat _userContentOffsetX;
}

@property (nonatomic, strong) NSMutableArray *viewArray;

@end

@implementation SlideSwitchView

- (UIScrollView *)mContentScrollView
{
    if (_mContentScrollView == nil) {
        _mContentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _mContentScrollView.delegate = self;
        _mContentScrollView.backgroundColor = [UIColor clearColor];
        _mContentScrollView.pagingEnabled = YES;
        _mContentScrollView.showsHorizontalScrollIndicator = NO;
        _mContentScrollView.showsVerticalScrollIndicator = NO;
        _mContentScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        _mContentScrollView.bounces = NO;
        _mContentScrollView.userInteractionEnabled = YES;

        [self addSubview:_mContentScrollView];
    }
    
    return _mContentScrollView;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _isBuildUI = NO;
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    if (_isBuildUI) {
        self.mContentScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(self.mContentScrollView.bounds.size.width*i, 0,
                                           self.mContentScrollView.bounds.size.width, self.mContentScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [self.mContentScrollView setContentOffset:CGPointMake(_mSelectIndex*self.bounds.size.width, 0) animated:NO];
    }
}

- (void)setup
{
    if (!_isBuildUI) {
        for (UIView *view in self.mContentScrollView.subviews) {
            [view removeFromSuperview];
        }
        
        _viewArray = [[NSMutableArray alloc] init];
        NSUInteger number = [_mDataSource numberOfSwitchView:self];
        for (int i = 0; i < number; i++) {
            UIViewController *vc = [_mDataSource slideSwitchView:self itemOfIndex:i];
            [_viewArray addObject:vc];
            [self.mContentScrollView addSubview:vc.view];
        }
        
        _isBuildUI = YES;
        
        //创建完子视图UI才需要调整布局
    }
    
    [self setNeedsLayout];
}

- (void)setMSelectIndex:(NSInteger)mSelectIndex
{
    if (self.mSelectIndex == mSelectIndex) {
        return;
    }else
    {
        [self.mContentScrollView setContentOffset:CGPointMake(mSelectIndex*self.bounds.size.width, 0) animated:NO];
        
        _mSelectIndex = mSelectIndex;
    }
}

- (void)reloadData
{
    _isBuildUI = NO;
    [self setup];
}

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.mContentScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}
//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.mContentScrollView) {
        //调整顶部滑条按钮状态
        
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width;
        _mSelectIndex = tag;
        if (_mDataSource && [_mDataSource respondsToSelector:@selector(slideSwitchView:didSelectItemIndex:)]) {
            [_mDataSource slideSwitchView:self didSelectItemIndex:tag];
        }
    }
}

@end
