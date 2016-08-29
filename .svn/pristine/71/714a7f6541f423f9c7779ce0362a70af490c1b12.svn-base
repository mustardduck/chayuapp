//
//  SlideSwitchView.h
//  Dishes
//
//  Created by 李 峥 on 14/12/29.
//  Copyright (c) 2014年 李 峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideSwitchViewDataSource;

@interface SlideSwitchView : UIView

@property (nonatomic, strong) UIScrollView *mContentScrollView;

@property (nonatomic, assign) NSInteger mSelectIndex;

@property (nonatomic, weak) IBOutlet id<SlideSwitchViewDataSource> mDataSource;

- (void)reloadData;

@end


@protocol SlideSwitchViewDataSource <NSObject>

@required
- (NSInteger)numberOfSwitchView:(SlideSwitchView *)switchView;
- (UIViewController *)slideSwitchView:(SlideSwitchView *)switchView itemOfIndex:(NSInteger)index;


@optional
- (void)slideSwitchView:(SlideSwitchView *)switchView didSelectItemIndex:(NSInteger)index;

@end