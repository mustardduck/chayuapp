//
//  CYPublicAvtiveViewController.m
//  茶语
//
//  Created by Chayu on 16/4/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPublicAvtiveViewController.h"

@interface CYPublicAvtiveViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CYPublicAvtiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;

    NSString *weUrl = nil;
    if ([_isRedPack integerValue] ==1) {
        ChaYuer *manager = [ChaYuManager getCurrentUser];
         weUrl = [NSString stringWithFormat:@"%@?uid=%@",_requestUrl,manager.uid];
    }else{
        weUrl = _requestUrl;
    }
   
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:weUrl]];
    [_webView loadRequest:request];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
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

@end
