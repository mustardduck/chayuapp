//
//  CYBaseTableViewController.m
//  TeaMall
//
//  Created by Chayu on 16/1/26.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseTableViewController.h"

#define NAVBAR_HEIGHT  100

@interface CYBaseTableViewController ()
{
    BOOL topmenushow;
}

@end

@implementation CYBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = MAIN_BGCOLOR;
    
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.navBar];
    [self setleftNavButotn];
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

#pragma mark -
#pragma mark 导航样式 method
- (void)layoutNaviBarWithImageName:(NSString *)imgName bundle:(NSBundle *)bundle
{
    if (!self.navigationController.navigationBar) {
        return ;
    }
    UIImage *image = [UIImage imageNamed:imgName];
    if (!image) {
        return;
    }
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];;
}



//手动实现图片压缩，可以写到分类里，封装成常用方法。按照大小进行比例压缩，改变了图片的size。

- (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage scale:(double)imageScale {
    
    UIImage *thumbnail = nil;
    
    CGSize imageSize = CGSizeMake(srcImage.size.width * imageScale, srcImage.size.height * imageScale);
    
    if (srcImage.size.width != imageSize.width || srcImage.size.height != imageSize.height)
        
    {
        
        UIGraphicsBeginImageContext(imageSize);
        
        CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        
        [srcImage drawInRect:imageRect];
        
        thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    else
        
    {
        
        thumbnail = srcImage;
        
    }
    
    return thumbnail;
    
}


@end
