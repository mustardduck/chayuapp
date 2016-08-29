//
//  BXTabBarController.m
//  BaoXianDaiDai
//
//  Created by JYJ on 15/5/28.
//  Copyright (c) 2015年 baobeikeji.cn. All rights reserved.
//

#import "BXTabBarController.h"
#import "BXNavigationController.h"

#import "CYHomeViewController.h"
#import "CYForumViewController.h"
#import "CYMyViewController.h"
#import "CYTeaMallViewController.h"
#import "CYWenZhangViewController.h"
#import "CYEvaHomeViewController.h"

#define kTabbarHeight (65*(SCREEN_WIDTH/375.))
#define  kContentFrame  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kTabbarHeight)
#define  kDockFrame CGRectMake(0, self.view.frame.size.height-kTabbarHeight, self.view.frame.size.width, kTabbarHeight)

@interface BXTabBarController ()<UITabBarControllerDelegate, UINavigationControllerDelegate, BXTabBarDelegate>

@property (nonatomic, assign) BOOL jump;
@property (nonatomic, assign) NSInteger lastSelectIndex;
@property (nonatomic, strong) UIView *redPoint;
/** view */


@property (nonatomic, strong) id popDelegate;
/** 保存所有控制器对应按钮的内容（UITabBarItem）*/
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation BXTabBarController

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;
    // 把系统的tabBar上的按钮干掉
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[BXTabBar class]]) {
            [childView removeFromSuperview];
        }
    }
   
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
   
 

    // 添加所有子控制器
    [self addAllChildVc];
    // 自定义tabBar
    [self setUpTabBar];
}

-(void)setRootView:(NSNotification *)sender
{
    NSDictionary *info = sender.object;
    NSInteger select = [[info objectForJSONKey:@"selectIndex"] integerValue];
    self.selectedIndex =  select;
    self.mytabbar.selButton.tag = self.selectedIndex + 12000;
    [self.mytabbar btnClick:self.mytabbar.selButton];
}

#pragma mark - 自定义tabBar
- (void)setUpTabBar
{
        BXTabBar *tabBar = [[BXTabBar alloc] init];
        tabBar.clipsToBounds = YES;
        // 存储UITabBarItem
        tabBar.items = self.items;
        tabBar.delegate = self;
        tabBar.frame = CGRectMake(0, SCREEN_HEIGHT-kTabbarHeight, SCREEN_WIDTH, kTabbarHeight);
        tabBar.height = kTabbarHeight;
        tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_background"]];
        [self.view addSubview:tabBar];
        self.mytabbar = tabBar;
}



/**
 *  添加所有的子控制器
 */
- (void)addAllChildVc {
    /**
     *  首页
     */
    CYHomeViewController *view1= viewControllerInStoryBoard(@"CYHomeViewController", @"Home");
    [self addOneChildVC:view1 title:@"首页" imageName:@"tabbar_home_d" selectedImageName:@"tabbar_home_s"];
    
    /**
     *  茶评
     */
    CYEvaHomeViewController * view2= viewControllerInStoryBoard(@"CYEvaHomeViewController", @"Eva");
    [self addOneChildVC:view2 title:@"茶评" imageName:@"tabbar_chaping_d" selectedImageName:@"tabbar_chaping_s"];
    
    /**
     *  市集
     */
    CYTeaMallViewController *view3= viewControllerInStoryBoard(@"CYTeaMallViewController", @"TeaMall");
    [self addOneChildVC:view3 title:@"市集" imageName:@"tabbar_shiji_d" selectedImageName:@"tabbar_shiji_s"];
    
    /**
     *  圈子
     */
    CYForumViewController *view4= viewControllerInStoryBoard(@"CYForumViewController", @"BBS");
    [self addOneChildVC:view4 title:@"圈子" imageName:@"tabbar_quanzi_d" selectedImageName:@"tabbar_quanzi_s"];
    /**
     *  我的
     */
    CYWenZhangViewController *view5= viewControllerInStoryBoard(@"CYWenZhangViewController", @"WenZhang");
    [self addOneChildVC:view5 title:@"文章" imageName:@"tabbar_wenzhang_d" selectedImageName:@"tabbar_wenzhang_s"];
}


/**
 *  添加一个自控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */

- (void)addOneChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    childVc.tabBarItem.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置tabbarItem的普通文字
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [[UIColor alloc]initWithRed:113/255.0 green:109/255.0 blue:104/255.0 alpha:1];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor getColorWithHexString:@"893e20"];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 记录所有控制器对应按钮的内容
    [self.items addObject:childVc.tabBarItem];
    
    // 添加为tabbar控制器的子控制器
    BXNavigationController *nav = [[BXNavigationController alloc] initWithRootViewController:childVc];

    nav.delegate = self;
    [self addChildViewController:nav];
}

#pragma mark - BXTabBarDelegate方法
// 监听tabBar上按钮的点击
- (void)tabBar:(BXTabBar *)tabBar didClickBtn:(NSInteger)index
{
    self.selectedIndex = index;
//    self.lastSelectIndex = index;
}



#pragma mark navVC代理
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    if (viewController != root) {
        //更改导航控制器的高度
        navigationController.view.frame = self.view.bounds;
        //从HomeViewController移除
        [self.mytabbar removeFromSuperview];
        // 调整tabbar的Y值
        CGRect dockFrame = self.mytabbar.frame;
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollview = (UIScrollView *)root.view;
            dockFrame.origin.y = scrollview.contentOffset.y + root.view.frame.size.height - kTabbarHeight;
        } else {
            dockFrame.origin.y = root.view.frame.size.height - kTabbarHeight;
        }
        self.mytabbar .frame = dockFrame;

        self.tabBar.hidden = YES;
        //添加dock到根控制器界面
        [root.view addSubview:self.mytabbar];
    }
}

// 完全展示完调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    BXNavigationController *nav = (BXNavigationController *)navigationController;
    if (viewController == root) {
        // 更改导航控制器view的frame
        navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kTabbarHeight);
        
        navigationController.interactivePopGestureRecognizer.delegate = nav.popDelegate;
        // 让Dock从root上移除
        [self.mytabbar removeFromSuperview];
        self.tabBar.hidden = YES;
        //_mytabbar添加dock到HomeViewControllers
        self.mytabbar.frame = CGRectMake(0, SCREEN_HEIGHT-kTabbarHeight, SCREEN_WIDTH, kTabbarHeight);
        [self.view addSubview:self.mytabbar];

        NSLog(@"执行了该方法");
    }
}


@end
