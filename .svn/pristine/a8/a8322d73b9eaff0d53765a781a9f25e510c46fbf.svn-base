//
//  CYBrandWebViewController.m
//  茶语
//
//  Created by 李峥 on 16/4/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBrandWebViewController.h"

@interface CYBrandWebViewController ()

- (IBAction)goback:(id)sender;


@end

@implementation CYBrandWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"榜单详情"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"榜单详情"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)zhijiefenxiang_click:(UIButton *)sender {
    
    switch (sender.tag) {
        case 320:
        {
            [self sharePengYouQuan:_shareMsg];
            break;
        }
        case 321:
        {
            [self shareWeiXin:_shareMsg];
            break;
        }
        case 322:
        {
            [self shareQQ:_shareMsg];
            break;
        }
        case 2:
        {
            [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
            break;
        }
            
        default:
            break;
    }
    
}
@end
