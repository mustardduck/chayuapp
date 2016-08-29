//
//  AppDelegate.h
//  茶语
//
//  Created by Chayu on 16/2/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXTabBarController.h"
#import "BBCustomTabBar.h"
static NSString *appKey = @"dd9d9c4fcfee347620c1def9";
static NSString *channel = @"AppStore";

#define UMENG_APPKEY @"5733e922e0f55a9a7b000240"


//生产环境请换成YES 开发环境请选择NO
static BOOL isProduction = YES;

typedef NS_ENUM(NSInteger, AuthorizeType) {
    kAuthorizeTypeOpenShare = 0,
    kAuthorizeTypeWeinXinPay, //微信支付
    kAuthorizeTypeAliPay, //支付宝支付
    kAuthorizeTypeUMLog,//友盟登录
    kAuthorizeTypeGoods//商品
    
};
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) AuthorizeType at;// 当前类型

@property (assign ,nonatomic)CYSearchType searchType;

//@property (nonatomic,strong)BXTabBarController *tabBarController;
@property (nonatomic, assign) BOOL canUseNetwork;


@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic)BBCustomTabBar *customTabBar;

- (void)setTabbarHidden:(BOOL)hidden animated:(BOOL)animated;

-(void)showLogView;
@end

