//
//  CYInvoiceViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYInvoiceViewController.h"

@interface CYInvoiceViewController ()
{
    UIButton *tabBtn;
}
@property (weak, nonatomic) IBOutlet UITextField *titleTxf;
- (IBAction)goback:(id)sender;

@end

@implementation CYInvoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tabBtn = (UIButton*)[self.view viewWithTag:101];
    //self.barStyle = NavBarStyleNoneMore;
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

- (IBAction)tabbtnTouchUpInside:(UIButton*)sender
{
    if (tabBtn) {
        tabBtn.selected = NO;
    }
    tabBtn = sender;
    tabBtn.selected = YES;
}

- (IBAction)comfirebtnTouchUpInside:(id)sender
{
    if (tabBtn.tag == 102) {
        //需要发票
        if (self.block) {
            NSString *title = _titleTxf.text;
            if (title == nil) {
                title = @"";
            }
            self.block(title);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
