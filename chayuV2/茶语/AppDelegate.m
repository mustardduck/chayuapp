//
//  AppDelegate.m
//  茶语
//


//  Created by Chayu on 16/2/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "AppDelegate.h"
//#import "Reachability.h"
#import "WXApiManager.h"
#import "CYLoginViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "BBGuidePageView.h"
#import "JPUSHService.h"
#import "CYArticleInfo.h"
#import "CYArticleDetailViewController.h"
#import "CYProductDetViewController.h"
#import "CYPublicAvtiveViewController.h"
#import "CYTopicDetailController.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYTeaSampleDetailViewController.h"
#import "CYTopWindow.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "CYImpAltView.h"
#import "CYGuangGaoView.h"
#import "KeychainItemWrapper.h"
#import "IQKeyboardManager.h"
#import "AdvertiseView.h"
#import "UMessage.h"
#import "CYWenZhangDetailsController.h"
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTCallCenter.h>

#import <CoreTelephony/CTCall.h>
@interface AppDelegate ()<UIScrollViewDelegate,UIAlertViewDelegate,BBCustomTabBarDelegate>
{
    BOOL isback;
    BOOL tabbarHidden;
    
}
//@property (nonatomic, retain) Reachability *reachablity;
@property (nonatomic,strong) CTCallCenter *callCenter;
//@property (nonatomic,strong)UIPageControl *pageContro;
@end

@implementation AppDelegate


/**
 *  初始化友盟统计SDK
 */
- (void)umengTrack {
    NSString *bundleKey = @"CFBundleShortVersionString";
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:bundleKey];
    [MobClick setAppVersion:curVersion];
    if (TARGET_IPHONE_SIMULATOR) {
        [MobClick setLogEnabled:YES];
    }else{
        [MobClick setLogEnabled:YES];
    }
    UMConfigInstance.appKey = UMENG_APPKEY;
    UMConfigInstance.channelId = channel;
    UMConfigInstance.ePolicy = BATCH;
    [MobClick startWithConfigure:UMConfigInstance];
    
    
}


//检测当前APP网络状态
-(void)jiancewangluo{
    // 1.获得网络监控的管理者
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    
    
    // 2.设置网络状态改变后的处理
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态改变了, 就会调用这个block
        
        switch
        (status) {
                
            case
            AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
            case
            AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                message:NETWORK_ERRORMESSAGE
                                                               delegate:nil
                                                      cancelButtonTitle:@"我知道了"
                                                      otherButtonTitles:nil];
                [alert show];
                
                break;
            }
            case
            AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                
                NSLog(@"手机自带网络");
                
                break;
                
                
                
            case
            AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                NSLog(@"WIFI");
                
                break;
                
        }
        
    }];
    
    
    
    // 3.开始监控
    
    [mgr startMonitoring];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CYTopWindow show];
    });
    
    
    CTCallCenter *center = [[CTCallCenter alloc]init];
    self.callCenter = center;
    
    //    [self jianceLaiDian];
    
    ChaYuer *user  = [ChaYuManager getCurrentUser];
    if (user.loginToken.length) {
        [self reload];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showGuidePage];
    });
    [self jiancewangluo];
    [self umengTrack];
    [self alertyingdaopingjia];
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (isExist) {// 图片存在
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ChaYuer *manager = [ChaYuManager getCurrentUser];
            AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:self.window.bounds];
            advertiseView.filePath = filePath;
            [advertiseView show:manager.guanggaoInfo];
        });
        
        
    }
    
    // 控制点击背景是否收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    // 控制键盘上的工具条文字颜色是否用户自定义
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    isback = YES;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    ////
    //    [UMessage startWithAppkey:UMENG_APPKEY launchOptions:launchOptions];
    //    
    //    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
    //    [UMessage registerForRemoteNotifications];
    //    
    
    //    如不需要使用IDFA，advertisingIdentifier 可为nil
    //    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //    _tabBarController = [[BXTabBarController alloc] init];
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.tabBar.hidden = YES;
    [self.tabBarController setTabBarHidden:YES];
    [self initTabBarController];
    self.window.rootViewController = self.tabBarController;
    //2.显示窗口成为主窗口
    [self.window makeKeyAndVisible];
    
    [self monitorNetworkStatus];
    _at = kAuthorizeTypeGoods;
    [UMSocialData setAppKey:UMENG_APPKEY];
    [UMSocialWechatHandler setWXAppId:@"wxea386816bae46f5a" appSecret:@"c42aad7f2c8d59b4a588797bf27acf4d" url:@"http://www.chayu.com/app"];
    [UMSocialQQHandler setQQWithAppId:@"1105019283" appKey:@"kdxZOisKPyA5LKmh" url:@"http://www.umeng.com/social"];//@"chayu://"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"4174485384"
                                              secret:@"7260d292c67fd62a6290c83ca9e7b7d8"
                                         RedirectURL:@"http://www.chayu.com"];
    
    //向微信注册wxd930ea5d5a258f4f
    [WXApi registerApp:@"wxea386816bae46f5a"];
    //    [OpenShare connectQQWithAppId:@"1105019283"];
    //    [OpenShare connectWeiboWithAppKey:@"4174485384"];
    //    [OpenShare connectWeixinWithAppId:@"wxea386816bae46f5a"];
    
//    [self xiaoyuzhuanqianxiangguan];
    [self jiancebanben];
    [self startHomePage];
    
    
    return YES;
}


-(void)jianceLaiDian
{
    
    __weak __typeof(self) weakSelf = self;
    self.callCenter.callEventHandler = ^(CTCall* call) {
        NSLog(@"来过");
        
        NSLog(@"weakSelf.tabBarController.bounds = %@",NSStringFromCGRect(weakSelf.tabBarController.view.frame));
        
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            CGRect frame = weakSelf.customTabBar.frame;
            frame.origin.y = WINDOW.height - 65*SCREENBILI;
            frame.size.width = SCREEN_WIDTH;
            frame.size.height = 65*SCREENBILI;
            weakSelf.customTabBar.frame = frame;
            NSLog(@"Call has been disconnected");
        }
        else if ([call.callState isEqualToString:CTCallStateConnected])
        {
            CGRect frame = weakSelf.customTabBar.frame;
            frame.origin.y = WINDOW.height - 65*SCREENBILI;
            frame.size.width = SCREEN_WIDTH;
            frame.size.height = 65*SCREENBILI;
            weakSelf.customTabBar.frame = frame;
            NSLog(@"Call has just been connected");
        }
        else if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
        }
        else if ([call.callState isEqualToString:CTCallStateDialing])
        {
            NSLog(@"call is dialing");
        }
        else
        {
            NSLog(@"Nothing is done");
        }
    };
}

//检测老用户是否是第三方登录
-(void)perfectcheck
{
    
    //    [CYWebClient basePost:@"perfect_check" parametes:nil success:^(id responObj) {
    //        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
    //        if (state == 304) {
    //            [CYImpAltView show];
    //        }
    //    } failure:^(id err) {
    //        
    //        
    //    }];
}




//APP外部合作需要
-(void)xiaoyuzhuanqianxiangguan
{
    NSString *adid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (adid) {
        
    }
    [CYWebClient Get:@"2.0_app.tongji.down" parametes:@{@"token":@"b8yfmQpGlWQMzXjA",@"appid":@"1019041167",@"idfa":adid,@"source":@"xiaoyu"} success:^(id responObj) {
    } failure:^(id err) {
        
        
    }];
}

-(void)showLogView
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Log" bundle:nil];
    UINavigationController *vc = [sb instantiateInitialViewController];
    //    [vc setNavigationBarHidden:YES animated:NO];
    [_tabBarController presentViewController:vc animated:YES completion:^{
        
    }];
    
}



- (void)initTabBarController
{
    NSArray *sbArr = @[@"Home",@"Eva",@"TeaMall",@"BBS",@"WenZhang"];
    NSMutableArray *vcArr = [NSMutableArray array];
    for (NSString *sbName in sbArr) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
        UINavigationController *vc = (UINavigationController *)[sb instantiateInitialViewController];
        [vcArr addObject:vc];
    }
    
    self.tabBarController.viewControllers = vcArr;
    self.customTabBar = [[[NSBundle mainBundle]loadNibNamed:@"BBCustomTabBar" owner:nil options:nil]firstObject];
    _customTabBar.delegate = self;
    _customTabBar.tabBarController = self.tabBarController;
    _customTabBar.y = _tabBarController.view.frame.size.height - 65*SCREENBILI;
    _customTabBar.width = WINDOW.width;
    _customTabBar.height = 65*SCREENBILI;
    CGRect frame = _customTabBar.frame;
    frame.origin.y = _tabBarController.view.frame.size.height - 65*SCREENBILI;
    frame.size.width = SCREEN_WIDTH;
    frame.size.height = 65*SCREENBILI;
    _customTabBar.frame = frame;
    NSLog(@"_customTabBar.size = %@",NSStringFromCGSize(_customTabBar.size));
    [_tabBarController.view addSubview:_customTabBar];
    _customTabBar.selectedIndex = 0;
}

#pragma mark -
#pragma mark self define


- (void)setTabbarHidden:(BOOL)hidden animated:(BOOL)animated
{
    if (tabbarHidden & hidden) {
        return ;
    }
    tabbarHidden = hidden;
    CGRect frame = _customTabBar.frame;
    frame.origin.y = [[UIScreen mainScreen] bounds].size.height;
    if (!hidden) {
        frame.origin.y -= frame.size.height;
    }
    if (animated) {
        [UIView animateWithDuration:0.25
                         animations:^{
                             _customTabBar.frame = frame;
                         }];
    } else {
        _customTabBar.frame = frame;
    }
    
}


#pragma mark -
#pragma mark BBCustomTabBarDelegate method
- (BOOL)customTabBar:(BBCustomTabBar *)aCustomTabBar shouldSelectIndex:(NSInteger)aIndex
{
    BOOL flag = YES;
    _customTabBar.selectedIndex = aIndex;
    return flag;
}

- (void)customTabBar:(BBCustomTabBar *)aCustomTabBar didSelectIndex:(NSInteger)aIndex
{
    
}


-(void)reload
{
    NSString *token =[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    ChaYuer *user  = [ChaYuManager getCurrentUser];
    if (!token.length) {
        token = user.loginToken;
    }
    
    if (!token.length) {
        token = @"";
    }
    
    [CYWebClient Post:@"Reload" parametes:@{@"token":token} success:^(id responObject) {
        NSString *token = [[responObject objectForKey:@"data"] objectForKey:@"token"];
        if (token) {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
        }
        NSString *sessionid = [[responObject objectForKey:@"data"] objectForKey:@"sessionid"];
        if (sessionid) {
            [[NSUserDefaults standardUserDefaults] setObject:sessionid forKey:@"sessionid"];
        }
        [self perfectcheck];
        
    } failure:^(id error) {
        NSLog(@"Reload failed");
    }];
    
}

//检测版本以便后期可强制关闭APP
-(void)jiancebanben
{
    NSString *bundleKey = @"CFBundleShortVersionString";
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:bundleKey];
    [CYWebClient backgroundPost:@"upgrade" parametes:@{@"appId":@"1",@"type":@"2",@"version_name":curVersion} success:^(id responObject) {
        NSInteger state  =[[responObject objectForKey:@"state"] integerValue];
        if (state == 400) {
            NSDictionary *data  =[responObject objectForKey:@"data"];
            NSInteger force_upgrade = [[data objectForKey:@"force_upgrade"] integerValue];
            //            force_upgrade = 1;
            if (force_upgrade == 1) {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该版本不可用，请升级到最新版本！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alt.tag = 9000;
                [alt show];
            }
        }
    } failure:^(id error) {
        NSLog(@"Reload failed");
    }];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //第二步：添加回调
    
    
    NSString *urlString=[url absoluteString];
    NSLog(@"urlString = %@",urlString);
    if ([urlString hasPrefix:@"chayuapp://"]) {
        NSArray *goodidArr = [urlString componentsSeparatedByString:@"="];
        id viewCon = self.tabBarController.selectedViewController;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CYProductDetViewController  *vc = viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
            vc.goodId = goodidArr[1];
            //            //vc.hidesBottomBarWhenPushed = YES;
            NSLog(@"viewCon = %@",viewCon);
            if ([viewCon isKindOfClass:[UINavigationController class]]) {
                [viewCon pushViewController:vc animated:YES];
            }
        });
    }
    
    if (_at == kAuthorizeTypeOpenShare) {
        //        return YES;
        ////        if ([OpenShare handleOpenURL:url]) {
        ////            return YES;
        ////        }
    }else if (_at == kAuthorizeTypeWeinXinPay){
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if(_at == kAuthorizeTypeAliPay){
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                [[NSNotificationCenter defaultCenter] postNotificationName:ZHIFUBAOZHIFIHUIDIAO object:resultDic];
                NSLog(@"result1 = %@",resultDic);
            }];
        }
        return YES;
    }else if(_at == kAuthorizeTypeUMLog){
        [[NSNotificationCenter defaultCenter] postNotificationName:PENYOUQUANFENXIANG object:nil];
        return [UMSocialSnsService handleOpenURL:url];
    }
    //这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    
    if (_at == kAuthorizeTypeWeinXinPay) {
        return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if (_at == kAuthorizeTypeUMLog){
        [UMSocialSnsService  applicationDidBecomeActive];
    }else if (_at == kAuthorizeTypeAliPay ){
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"即将挂起");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"即将进入后台");
    isback = YES;
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"即将进入前台");
    //    [self jianceLaiDian];
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", token]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSLog(@"收到通知--------------->1:%@", [self logDic:userInfo]);
    //    UtilAlert(@"收到同通知",@"很好");
    [JPUSHService handleRemoteNotification:userInfo];
    [JPUSHService resetBadge];
    //    if (isback) {
    //        isback = NO;
    //        NSInteger type = [[userInfo objectForKey:@"type"] integerValue];
    //        id viewCon = self.tabBarController.selectedViewController;
    //        switch (type) {
    //            case 1://文章
    //            {
    //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //                    CYArticleInfo *info = [[CYArticleInfo alloc] init];
    //                    info.itemid = [userInfo objectForKey:@"id"];
    //                    CYArticleDetailViewController *vc = [[CYArticleDetailViewController alloc] initWithNibName:@"CYArticleDetailViewController" bundle:nil];
    //                    vc.mArticleInfo = info;
    //                    //vc.hidesBottomBarWhenPushed = YES;
    //                    NSLog(@"viewCon = %@",viewCon);
    //                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
    //                        [viewCon pushViewController:vc animated:YES];
    //                    }
    //                });
    //                
    //                break;
    //            }
    //            case 2://商品
    //            {
    //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //                    CYProductDetViewController  *vc = viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    //                    vc.goodId = [userInfo objectForKey:@"id"];
    //                    //vc.hidesBottomBarWhenPushed = YES;
    //                    NSLog(@"viewCon = %@",viewCon);
    //                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
    //                        [viewCon pushViewController:vc animated:YES];
    //                    }
    //                });
    //                
    //                break;
    //            }
    //            case 3://活动
    //            {
    //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //                    if (!MANAGER.isLoged) {
    //                        [APP_DELEGATE showLogView];
    //                        return;
    //                    }
    //                    CYPublicAvtiveViewController *vc = viewControllerInStoryBoard(@"CYPublicAvtiveViewController", @"TeaMall");
    //                    vc.requestUrl = [userInfo objectForKey:@"url"];
    //                    vc.titleStr = [userInfo objectForKey:@"title"];
    //                    vc.isRedPack = @"0";
    //                    //vc.hidesBottomBarWhenPushed = YES;
    //                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
    //                        [viewCon pushViewController:vc animated:YES];
    //                    }
    //                });
    //                break;
    //            }
    //            case 4://话题
    //            {
    //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //                    CYTopicDetailController *tdc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
    //                    tdc.hidesBottomBarWhenPushed = YES;
    //                    tdc.tid = [userInfo objectForKey:@"id"];
    //                    tdc.hidesBottomBarWhenPushed = YES;
    //                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
    //                        [viewCon pushViewController:tdc animated:YES];
    //                    }
    //                });
    //                break;
    //            }
    //            case 5://茶样
    //            {
    //                
    //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //                    CYTeaSampleDetailViewController *vc = [[CYTeaSampleDetailViewController alloc] initWithNibName:@"CYTeaSampleDetailViewController" bundle:nil];
    //                    vc.mSampleid = [userInfo objectForKey:@"id"];
    //                    //vc.hidesBottomBarWhenPushed = YES;
    //                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
    //                        [viewCon pushViewController:vc animated:YES];
    //                    }
    //                });
    //                
    //                break;
    //            }
    //                
    //            case 6://茶评
    //            {
    //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //                    CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
    //                    vc.mTeaId = [userInfo objectForKey:@"id"];
    //                    //vc.hidesBottomBarWhenPushed = YES;
    //                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
    //                        [viewCon pushViewController:vc animated:YES];
    //                    }
    //                });
    //                
    //                break;
    //            }
    //            default:
    //                break;
    //        }
    //    }
    
}

- (void)application:(UIApplication *)application  didReceiveRemoteNotification:(NSDictionary *)userInfo  fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //     UtilAlert(@"收到同通知",@"很好");
    [JPUSHService handleRemoteNotification:userInfo];
    [JPUSHService resetBadge];
    if (isback) {
        isback = NO;
        NSInteger type = [[userInfo objectForKey:@"type"] integerValue];
        id viewCon = self.tabBarController.selectedViewController;
        switch (type) {
            case 1://文章
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController",@"WenZhang");
                    vc.wenzhangId = [userInfo objectForKey:@"id"];
                    //            //vc.hidesBottomBarWhenPushed = YES;
                    //                    [viewCon pushViewController:vc animated:YES];
                    NSLog(@"viewCon = %@",viewCon);
                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
                        [viewCon pushViewController:vc animated:YES];
                    }
                });
                
                break;
            }
            case 2://商品
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    CYProductDetViewController  *vc = viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                    vc.goodId = [userInfo objectForKey:@"id"];
                    //vc.hidesBottomBarWhenPushed = YES;
                    NSLog(@"viewCon = %@",viewCon);
                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
                        [viewCon pushViewController:vc animated:YES];
                    }
                });
                
                break;
            }
            case 3://活动
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (!MANAGER.isLoged) {
                        [APP_DELEGATE showLogView];
                        return;
                    }
                    CYPublicAvtiveViewController *vc = viewControllerInStoryBoard(@"CYPublicAvtiveViewController", @"TeaMall");
                    vc.requestUrl = [userInfo objectForKey:@"url"];
                    vc.titleStr = [userInfo objectForKey:@"title"];
                    vc.isRedPack = @"0";
                    //vc.hidesBottomBarWhenPushed = YES;
                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
                        [viewCon pushViewController:vc animated:YES];
                    }
                });
                break;
            }
            case 4://话题
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    CYTopicDetailController *tdc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
                    //                    tdc.hidesBottomBarWhenPushed = YES;
                    tdc.tid = [userInfo objectForKey:@"id"];
                    //                    tdc.hidesBottomBarWhenPushed = YES;
                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
                        [viewCon pushViewController:tdc animated:YES];
                    }
                });
                break;
            }
            case 5://茶样
            {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    CYTeaSampleDetailViewController *vc = viewControllerInStoryBoard(@"CYTeaSampleDetailViewController", @"Eva");
                    vc.mSampleid = [userInfo objectForKey:@"id"];
                    //vc.hidesBottomBarWhenPushed = YES;
                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
                        [viewCon pushViewController:vc animated:YES];
                    }
                });
                
                break;
            }
                
            case 6://茶评
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
                    vc.mTeaId = [userInfo objectForKey:@"id"];
                    //vc.hidesBottomBarWhenPushed = YES;
                    if ([viewCon isKindOfClass:[UINavigationController class]]) {
                        [viewCon pushViewController:vc animated:YES];
                    }
                });
                
                break;
            }
            default:
                break;
        }
    }
    
    
}

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    
    return str;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}


#pragma mark Network Monitor method
- (void)monitorNetworkStatus
{
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(networkChanged:)
    //                                                 name:kReachabilityChangedNotification
    //                                               object:nil];
    //    self.reachablity = [Reachability reachabilityForInternetConnection];
    //    _canUseNetwork = [self.reachablity currentReachabilityStatus] != NotReachable;
    //    if (!_canUseNetwork) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
    //                                                        message:NETWORK_ERRORMESSAGE
    //                                                       delegate:nil
    //                                              cancelButtonTitle:@"我知道了"
    //                                              otherButtonTitles:nil];
    //        [alert show];
    //    }
    //    [self.reachablity startNotifier];
}

//- (void)networkChanged:(id)sender
//{
//    NSNotification *notification = (NSNotification *)sender;
//    Reachability *r = notification.object;
//    NetworkStatus currentStatus = [r currentReachabilityStatus];
//    _canUseNetwork = currentStatus != NotReachable;
//    switch (currentStatus) {
//        case NotReachable:
//        {
//            //            [Itost showMsg:@"当前网络不可用！" inView:WINDOW];
//            //            //            NSLog(@"当前网络不可用");
//            

//
//            break;
//        }
//        case ReachableViaWiFi:
//            NSLog(@"使用wifi");
//            break;
//        case ReachableViaWWAN:
//            NSLog(@"使用WWAN");
//            break;
//        default:
//            break;
//    }
//}




#pragma mark -
#pragma mark 显示引导页
/*!
 *@description  显示引导页
 *@function     showGuidePage
 *@param        (void)
 *@return       (void)
 */
- (void)showGuidePage
{
    
    NSString *bundleKey = @"CFBundleShortVersionString";
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:bundleKey];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"FreshBeeKey"];
    if (lastVersion && [curVersion isEqualToString:lastVersion]) {
        return;
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:curVersion forKey:@"FreshBeeKey"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    NSMutableArray *imageNameArr = [NSMutableArray array];
    for (NSInteger i=1; i<=5; i++) {
        NSString *newImageName = [NSString stringWithFormat:@"app_%d",(int)i];
        UIImage *image = [UIImage imageNamed:newImageName];
        [imageNameArr addObject:image];
    }
    BBGuidePageView *guide = [[BBGuidePageView alloc] initWithFrame:WINDOW.frame];
    guide.pagingEnabled = YES;
    guide.guidePageImageArr = imageNameArr;
    guide.bounces = NO;
    guide.showsHorizontalScrollIndicator = NO;
    guide.delegate = self;
    [_window addSubview:guide];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 8856) {
        ChaYuer *manager = [ChaYuManager getCurrentUser];
        manager.isEva = YES;
        [ChaYuManager archiveCurrentUser:manager];
        if (buttonIndex  == 1) {
            NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",
                             @"997658411"];
            NSURL * url = [NSURL URLWithString:str];
            
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
            else
            {
                NSLog(@"can not open");
            }
        }
    }else if (alertView.tag == 9000){
        exit(0);
    }
    
}

-(void)alertyingdaopingjia
{
    ChaYuer *manager = [ChaYuManager getCurrentUser];
    NSString *bundleKey = @"CFBundleShortVersionString";
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:bundleKey];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"PingJia"];
    if (!manager.isEva) {
        if (lastVersion && [curVersion isEqualToString:lastVersion]) {
            NSCalendar *gregorian = [[NSCalendar alloc]
                                     initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            [gregorian setFirstWeekday:2];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *fromDate;
            NSDate *toDate;
            //            manager.firstTime = @"2016-06-1 12:23:49";
            //            NSString *time = @"2016-05-25 12:23:49";
            [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:manager.firstTime]];
            [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[NSDate date]];
            NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
            NSLog(@"dayComponents.day = %d天",(int)dayComponents.day);
            if (dayComponents.day>=3) {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"茶语的成长，需要您的鼓励！请给我们一个好评吧！" message:@"" delegate:self cancelButtonTitle:@"暂不发表评论" otherButtonTitles:@"喜欢，给予鼓励",nil];
                alt.tag = 8856;
                [alt show];
            }
            return;
        }else{
            manager.isEva = NO;
            NSDate *  senddate=[NSDate date];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *locationString=[dateformatter stringFromDate:senddate];
            NSLog(@"locationString:%@",locationString);
            manager.firstTime = locationString;
            [[NSUserDefaults standardUserDefaults]setObject:curVersion forKey:@"PingJia"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [ChaYuManager archiveCurrentUser:manager];
        }
    }
    
}

-(void)startHomePage
{
    [CYWebClient basePost:@"youli_startHomePage" parametes:@{@"version":@"3"} success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        NSDictionary *data = [responObj objectForKey:@"data"];
        if (state == 400) {
            if (![data isKindOfClass:[NSNull class]]) {
                ChaYuer *manager = [ChaYuManager getCurrentUser];
                manager.guanggaoInfo = data;
                [ChaYuManager archiveCurrentUser:manager];
                NSString *thumb = [data objectForKey:@"thumb"];
                [self getAdvertisingImage:thumb];
            }else{
                [self deleteOldImage];
            }
        }
    } failure:^(id err) {
        
        
    }];
}



/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage:(NSString *)imgUrl;
{
    
    // TODO 请求广告接口
    NSString *imageUrl = imgUrl;
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
        
    }
    
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            [self deleteOldImage];
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
