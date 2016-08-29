//
//  BBCustomTabBar.h
//  CannesClub
//
//  Created by box on 14-8-11.
//  Copyright (c) 2014年 box. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBCustomTabBarDelegate;

@interface BBCustomTabBar : UIView

@property (nonatomic,assign)id<BBCustomTabBarDelegate> delegate;
@property (nonatomic,assign)NSInteger selectedIndex;
@property (weak, nonatomic) UITabBarController *tabBarController;

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;

@end


@protocol BBCustomTabBarDelegate <NSObject>

@optional

- (BOOL)customTabBar:(BBCustomTabBar *)aCustomTabBar shouldSelectIndex:(NSInteger)aIndex;

- (void)customTabBar:(BBCustomTabBar *)aCustomTabBar didSelectIndex:(NSInteger)aIndex;

@end