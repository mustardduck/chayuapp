//
//  defines.h
//  Framework
//
//  Created by taotao on 15/8/13.
//  Copyright (c) 2015年 taotao. All rights reserved.
//

#ifndef Framework_defines_h
#define Framework_defines_h

typedef NS_ENUM(NSInteger,CYSearchType){
    CYSearchTypeTea = 0, //茶评
    CYSearchTypeSample, //茶样
    CYSearchTypeGoods,  //市集
    CYSearchTypeArticle, //文章
    CYSearchTypeGroupTopic //话题
};

typedef NS_ENUM(NSInteger,CYMyCollectType){
    CYMyColectTypeTea = 0, //茶评
    CYMyColectTypeSample, //茶样
    CYMyColectTypeArticle, //文章
    CYMyColectTypeGoods,  //商品
    CYMyColectTypeGroupTopic //话题
};

typedef NS_ENUM(NSInteger,LogInType){
    LogInTypeQQ = 0,
    LogInTypeSina,
    LogInTypeWeiXin
};

typedef NS_ENUM(NSUInteger, NavBarStyle) {
    NavBarStyleNone = 0,
    NavBarStyleNoneMore = 1 << 0,
    NavBarStyleNoneMoreCar = 1 << 1
};



static NSString *tabBarIndex = @"UITabBarControllerSelect";

static NSString *weiXinPayStatus = @"WeiXinPaySattus";


static NSString *ZHIFUBAOZHIFIHUIDIAO = @"ZHIFUBAOZHIFIHUIDIAO";


static NSString *PENYOUQUANFENXIANG = @"PENYOUQUANFENXIANG";

//支付成功跳转大师/名家列表页
static NSString *PAYSUCCESS_GOTOMASTERLIST = @"PAYSUCCESS_GOTOMASTERLIST";

#define PARTNERKEY @"2JoEJroJTNa7mOGGWftFqGD6WCKL8MuA"

//公用颜色
#define DSCommonColor [UIColor colorWithRed:254/255.0  green:129/255.0 blue:0 alpha:1.0]
//导航栏标题字体大小
#define DSNavigationFont [UIFont boldSystemFontOfSize:16]
//导航栏标题按钮高度和边距
#define DSNavigationItemOfTitleViewHeight 34
#define DSNavigationItemMargin 10
//首页导航popmenu距离顶部高度
#define DSPopMenuMarginTop 10

#define PAGESIZE 10

//宽图
#define WIDEIMG [UIImage imageNamed:@"zwt"]

#define DEFAULT_LOGO [UIImage imageNamed:@"160x160"]

#define SQUARE [UIImage imageNamed:@"320x320"]

#define DEFAULTHEADER [UIImage imageNamed:@"200x200"]
#define FONT(f)  [UIFont systemFontOfSize:f]

#define  WEAKSELF (__weak __typeof(self) weakSelf = self)

//当前屏幕和基础View宽比
#define SCREENBILI  (SCREEN_WIDTH/375.)

//是否为4inch
#define DSFourInch ([UIScreen mainScreen].bounds.size.height >= 568.0)
//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
//屏幕宽度
#define screen_width [UIScreen mainScreen].bounds.size.width
//导航栏高度
#define DSNavigationHeight CGRectGetMaxY([self.navigationController navigationBar].frame)

//window
#define WINDOW  [[UIApplication sharedApplication].delegate window]

#define APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define storyboardWithName(sbName) [UIStoryboard storyboardWithName:sbName bundle:bundle]
#define viewControllerInStoryBoard(vcID, sbName) [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcID]

#define NETWORK_ERRORMESSAGE @"您可能未连接网络，或者网络状态不佳，请确认网络状态后重试。谢谢！"

#define MANAGER [ChaYuManager getCurrentUser]
//NavBar高度
#define NavigationBar_HEIGHT 44



#define DefUUID                [[UIDevice currentDevice].identifierForVendor UUIDString]

#define BUNDLE_EXECUTABLE [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"]

/*-------------------获控制器 高度、宽度--------------------*/
#define VW (self.view.frame.size.width)
#define VH (self.view.frame.size.height)
/*-------------------获控制器 高度、宽度--------------------*/

/*-------------------获控控件 高度、宽度--------------------*/
#define KW (self.frame.size.width)
#define KH (self.frame.size.height)

/*-------------------获控控件 高度、宽度--------------------*/

/*-------------------获取屏幕 宽度、高度--------------------*/
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/*-------------------获取屏幕 宽度、高度--------------------*/

#define NAV_HEIGHT  90 * (SCREEN_WIDTH / 375.)

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

#ifndef SYS_USER
#define SYS_USER            @"CurrentSystemUser"
#endif

//#define curUser ([BlueBoxerManager getCurrentUser])

#define AddBack(backTapped) \
{\
UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 44)];\
UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];\
back.frame = CGRectMake(0, 0, 45, 44);\
[back setBackgroundImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];\
[back setBackgroundImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateHighlighted];\
[back addTarget:self action:@selector(backTopPage) forControlEvents:UIControlEventTouchUpInside];\
[bg addSubview:back];\
UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:bg];\
self.navigationItem.leftBarButtonItem = leftItem;\
}
//当没有数据时，其他行隐藏分割线
#define hiddenSepretor(tableView) \
{\
UIView *v = [[UIView alloc] initWithFrame:CGRectZero];\
[tableView setTableFooterView:v];\
}\
//设置满屏分割线 viewdidload中
#define setSepretor(_table) \
{\
if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {\
[_table setSeparatorInset:UIEdgeInsetsZero];\
}\
if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {\
[_table setLayoutMargins:UIEdgeInsetsZero];\
}\
}
//设置满屏分割线 tableView代理方法中
#define setCellSepretor() \
{\
if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {\
[cell setSeparatorInset:UIEdgeInsetsZero];\
}\
if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {\
[cell setLayoutMargins:UIEdgeInsetsZero];\
}\
}


/*----------------------颜色类---------------------------*/
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#ifndef APP_FRAME_WIDTH
#define APP_FRAME_WIDTH [UIScreen mainScreen].applicationFrame.size.width
#endif

#define UtilAlert(title, msg) { \
UIAlertView *dialAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" \
message:msg \
delegate:nil \
cancelButtonTitle:@"好" \
otherButtonTitles:nil]; \
[dialAlert show]; \
}



#define CALLER_NAME ({\
void *__fromaAddr = __builtin_return_address(0);\
Dl_info __anInfo;\
dladdr(__fromaAddr, &__anInfo);\
NSString *__callerName = [NSString stringWithFormat:@"%s",__anInfo.dli_sname];\
__callerName;\
})

#endif
