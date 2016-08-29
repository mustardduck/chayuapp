//
//  CYTopWindow.m
//  茶语
//
//  Created by Chayu on 16/5/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTopWindow.h"

@implementation CYTopWindow
static UIWindow *window_;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//初始化window
+ (void)initialize {
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(40, 0, [UIScreen mainScreen].bounds.size.width-40, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}
+ (void)show {
    window_.hidden = NO;
}
+ (void)hide {
    window_.hidden = YES;
}
// 监听窗口点击
+ (void)windowClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}


+ (void)searchScrollViewInView:(UIView *)superview {
    
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && [self isShowingOnKeyWindow:subview]) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        // 递归继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
+ (BOOL)isShowingOnKeyWindow:(UIView *)view {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:view.frame fromView:view.superview];
    CGRect winBounds = keyWindow.bounds;
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !view.isHidden && view.alpha > 0.01 && view.window == keyWindow && intersects;
}

@end
