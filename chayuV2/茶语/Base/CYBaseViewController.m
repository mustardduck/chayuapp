//
//  BBBaseViewController.m
//  JiuLongScene
//
//  Created by iXcoder on 14/11/27.
//  Copyright (c) 2014年 iXcoder. All rights reserved.
//

#import "CYBaseViewController.h"
#import "CYTopMenuView.h"
#import "CYSearchViewController.h"
#import "KxMenu.h"
#import "AppDelegate.h"
#import "CYSouSuoHomeViewController.h"
#import "CYMyViewController.h"


#define NotiCenter      [NSNotificationCenter defaultCenter]
#define COVER_WINDOW_BTN_TAG    10001
#define NAVBAR_HEIGHT  100
@interface CYBaseViewController ()
{
    
}


@end

@implementation CYBaseViewController

- (void)dealloc
{
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = MAIN_BGCOLOR;
    self.navigationController.navigationBar.hidden = YES;
    //    [self.view addSubview:self.navBar];
    //    [self setleftNavButotn];
}

-(void)creatkongNavBar
{
    
    [self.navBar removeFromSuperview];
}

-(NTNavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [[NTNavigationBar alloc] initWithFrame:CGRectMake(0, 0,self.view.width,NAVBAR_HEIGHT)];
        _navBar.backgroundColor = [UIColor clearColor];
    }
    return _navBar;
}

-(void)setleftNavButotn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *theImage = [UIImage imageNamed:@"default_back"];
    [button setImage:theImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.leftBarButtonItem = button;
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}




- (UIView *)emptyView
{
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    emptyView.backgroundColor = MAIN_BGCOLOR;
    emptyView.tag = 1000002;
    UIView *centerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    centerView.backgroundColor = CLEARCOLOR;
    centerView.x = SCREEN_WIDTH/2 - 150/2;
    centerView.y = emptyView.height/2 - centerView.height/2;
    
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    img.image = [UIImage imageNamed:@"juuiui"];
    [img sizeToFit];
    img.y = 10;
    img.x = centerView.width/2 - img.width/2;
    [centerView addSubview:img];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(25, img.height +20, 100, 20)];
    lable.text = @"暂无数据";
    lable.textColor = LIGHTCOLOR;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = FONT(16.);
    [centerView addSubview:lable];
    
    [emptyView addSubview:centerView];
    return emptyView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)showActionSheet:(OSMessage *)message
{
    if (message.link.length>0) {
        UIImage *img = [UIImage imageNamed:@"AppIcon60x60@2x.png"];
        UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        //    [imgView sd_setImageWithURL:[NSURL URLWithString:productModel.albumList[0]] placeholderImage:img];
        NSMutableString *imgUrl = [NSMutableString stringWithString:message.imgUrl];
        
        if ([imgUrl hasSuffix:@"800800"]) {
            imgUrl = [NSMutableString stringWithString:[imgUrl substringToIndex:imgUrl.length -6]];
            [imgUrl appendString:@"160160"];
        }
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:img completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.at = kAuthorizeTypeUMLog;
            if (!error) {
                message.image = UIImageJPEGRepresentation(image, 0.1);
                NSData *data  =UIImageJPEGRepresentation(image, 0.1);
                if (data.length/1024>32) {
                    message.image = UIImageJPEGRepresentation(img, 0.1);
                }
                
            }else{
                message.image = UIImageJPEGRepresentation(img, 0.1);;
            }
            CYActionSheet *sheet = [[CYActionSheet alloc] initWithTitles:nil iconNames:nil];
            sheet.shareMessage = message;
            [sheet showActionSheetWithClickBlock:^(int btnIndex) {
                
            } cancelBlock:^{
                
            }];
        }];
    }
    
}


-(void)shareWeiXin:(OSMessage *)message{
    
    if(message.link.length)
    {
        UIImage *img = [UIImage imageNamed:@"AppIcon60x60@2x.png"];
        UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        //    [imgView sd_setImageWithURL:[NSURL URLWithString:productModel.albumList[0]] placeholderImage:img];
        NSMutableString *imgUrl = [NSMutableString stringWithString:message.imgUrl];
        
        if ([imgUrl hasSuffix:@"800800"]) {
            imgUrl = [NSMutableString stringWithString:[imgUrl substringToIndex:imgUrl.length -6]];
            [imgUrl appendString:@"160160"];
        }
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:img completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.at = kAuthorizeTypeUMLog;
            if (!error) {
                message.image = UIImageJPEGRepresentation(image, 0.1);
                NSData *data  =UIImageJPEGRepresentation(image, 0.1);
                if (data.length/1024>32) {
                    message.image = UIImageJPEGRepresentation(img, 0.1);
                }
                
            }else{
                message.image = UIImageJPEGRepresentation(img, 0.1);;
            }
            [self shareOterAPP:2 And:message];
        }];
        
    }
}

- (void)shareGoods:(OSMessage *)shareMsg
{
    if(shareMsg.desc.length + shareMsg.link.length >= 140)
    {
        NSString * desc = [shareMsg.desc substringToIndex:(139 - shareMsg.link.length)];
        
        shareMsg.desc = desc;
    }
    
    if(shareMsg.link.length)
    {
        UIImage *img = [UIImage imageNamed:@"AppIcon60x60@2x.png"];
        UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        NSMutableString *imgUrl = [NSMutableString stringWithString:shareMsg.imgUrl];
        
        if ([imgUrl hasSuffix:@"800800"]) {
            imgUrl = [NSMutableString stringWithString:[imgUrl substringToIndex:imgUrl.length -6]];
            [imgUrl appendString:@"160160"];
        }
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:img completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.at = kAuthorizeTypeUMLog;
            OSMessage *message = [[OSMessage alloc] init];
            message.title = shareMsg.title;
            if (!shareMsg.desc) {
                message.desc = @"m.chayu.com";
            }else{
                message.desc = shareMsg.desc;
            }
            message.link = shareMsg.link;
            
            
            if (!error) {
                message.image = UIImageJPEGRepresentation(image, 0.1);
                NSData *data  =UIImageJPEGRepresentation(image, 0.1);
                if (data.length/1024>32) {
                    message.image = UIImageJPEGRepresentation(img, 0.1);
                }
                
            }else{
                message.image = UIImageJPEGRepresentation(img, 0.1);;
            }
            CYActionSheet *sheet = [[CYActionSheet alloc] initWithTitles:nil iconNames:nil];
            sheet.shareMessage = message;
            [sheet showActionSheetWithClickBlock:^(int btnIndex) {
                
            } cancelBlock:^{
                
            }];
        }];
        
    }
}

- (void)navBarClicked:(UINavigationController *)nav tag:(NSInteger) tag shareMessage:(OSMessage *)shareMsg
{
    if(tag == 2)//分享
    {
        if(shareMsg.title)
        {
            [self shareGoods:shareMsg];
        }
    }
    else if (tag == 3)//搜索
    {
        CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
        [nav pushViewController:vc animated:YES];
    }
    else if (tag == 4)//个人中心
    {
        if (!MANAGER.isLoged) {
            [APP_DELEGATE showLogView];
            return;
        }
        CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
        [nav pushViewController:vc animated:YES];
    }
}

-(void)shareQQ:(OSMessage *)message
{
    if(message.link.length)
    {
        UIImage *img = [UIImage imageNamed:@"AppIcon60x60@2x.png"];
        UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        //    [imgView sd_setImageWithURL:[NSURL URLWithString:productModel.albumList[0]] placeholderImage:img];
        NSMutableString *imgUrl = [NSMutableString stringWithString:message.imgUrl];
        
        if ([imgUrl hasSuffix:@"800800"]) {
            imgUrl = [NSMutableString stringWithString:[imgUrl substringToIndex:imgUrl.length -6]];
            [imgUrl appendString:@"160160"];
        }
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:img completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.at = kAuthorizeTypeUMLog;
            if (!error) {
                message.image = UIImageJPEGRepresentation(image, 0.1);
                NSData *data  =UIImageJPEGRepresentation(image, 0.1);
                if (data.length/1024>32) {
                    message.image = UIImageJPEGRepresentation(img, 0.1);
                }
                
            }else{
                message.image = UIImageJPEGRepresentation(img, 0.1);;
            }
            [self shareOterAPP:3 And:message];
        }];
        
    }
}

-(void)sharePengYouQuan:(OSMessage *)message
{
    if(message.link.length)
    {
        UIImage *img = [UIImage imageNamed:@"AppIcon60x60@2x.png"];
        UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        //    [imgView sd_setImageWithURL:[NSURL URLWithString:productModel.albumList[0]] placeholderImage:img];
        NSMutableString *imgUrl = [NSMutableString stringWithString:message.imgUrl];
        
        if ([imgUrl hasSuffix:@"800800"]) {
            imgUrl = [NSMutableString stringWithString:[imgUrl substringToIndex:imgUrl.length -6]];
            [imgUrl appendString:@"160160"];
        }
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:img completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.at = kAuthorizeTypeUMLog;
            if (!error) {
                message.image = UIImageJPEGRepresentation(image, 0.1);
                NSData *data  =UIImageJPEGRepresentation(image, 0.1);
                if (data.length/1024>32) {
                    message.image = UIImageJPEGRepresentation(img, 0.1);
                }
                
            }else{
                message.image = UIImageJPEGRepresentation(img, 0.1);;
            }
            [self shareOterAPP:1 And:message];
        }];
    }
}

-(void)shareOterAPP:(NSInteger)type And:(OSMessage *)message
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.at = kAuthorizeTypeUMLog;
    
    [UMSocialData defaultData].extConfig.title = message.title;
    //
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:
                                        message.link];
    NSString *shareType = @"";
    switch (type) {
        case 1:
        {
            
            shareType = UMShareToWechatTimeline;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = message.link;
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = message.desc;
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = message.image;
            break;
        }
        case 2:
        {
            shareType = UMShareToWechatSession;
            
            [UMSocialData defaultData].extConfig.wechatSessionData.url = message.link;
            [UMSocialData defaultData].extConfig.wechatSessionData.shareText = message.desc;
            [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = message.image;
            break;
        }
        case 3:
        {
            shareType = UMShareToQQ;
            [UMSocialData defaultData].extConfig.qqData.url = message.link;
            [UMSocialData defaultData].extConfig.qqData.shareText = message.desc;
            [UMSocialData defaultData].extConfig.qqData.shareImage = message.image;
            break;
        }
            
        default:
            break;
    }
    
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[shareType] content:nil image:nil location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    
}



#pragma mark -
#pragma mark self define method
/*!
 *@description  响应点击返回按钮事件
 *@function     onGoBack:
 *@param        sender     --返回按钮
 *@return       (void)
 */
- (IBAction)onGoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//#pragma mark -
//#pragma mark 导航样式 method
//- (void)layoutNaviBarWithImageName:(NSString *)imgName bundle:(NSBundle *)bundle
//{
//    if (!self.navigationController.navigationBar) {
//        return ;
//    }
//    UIImage *image = [UIImage imageNamed:imgName];
//    if (!image) {
//        return;
//    }
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];;
//}




@end
