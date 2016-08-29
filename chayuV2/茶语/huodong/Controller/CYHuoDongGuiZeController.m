//
//  CYHuoDongGuiZeController.m
//  茶语
//
//  Created by Chayu on 16/6/3.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHuoDongGuiZeController.h"

@interface CYHuoDongGuiZeController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation CYHuoDongGuiZeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatRightItems{
    
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
