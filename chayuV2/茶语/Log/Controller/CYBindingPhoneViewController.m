//
//  CYBindingPhoneViewController.m
//  TeaMall
//
//  Created by Chayu on 15/12/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYBindingPhoneViewController.h"
#import "BaseButton.h"
@interface CYBindingPhoneViewController ()<UITextFieldDelegate>
{
    BOOL        isCountdown;    //是否正在倒计时
    NSTimer     *countTime;
    NSInteger   statusTime;     //倒计时时间
}
- (IBAction)goback:(id)sender;
- (IBAction)reg_click:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (weak, nonatomic) IBOutlet UITextField *calTf;
- (IBAction)huoquyanzhengma_clcik:(id)sender;
@property (weak, nonatomic) IBOutlet BaseButton *yanzhengmaBtn;

@end

@implementation CYBindingPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    statusTime = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatRightItems
{

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

- (IBAction)reg_click:(id)sender {
//    2.0_bind.mobile
    if (_calTf.text.length == 0) {
         [SVProgressHUD showErrorWithStatus:@"手机号不能为空！"];
        return;
    }
    
    if (_codeTf.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空！"];
        return;
    }
    [CYWebClient basePost:@"2.0_bind.mobile" parametes:@{@"mobile":_calTf.text,@"code":_codeTf.text} success:^(id responObj) {
        NSInteger state =[[responObj objectForKey:@"state"] integerValue];
        NSString *msg  =[responObj objectForKey:@"msg"];
        if (state == 400) {
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showErrorWithStatus:msg];
            if (self.backBlock) {
                self.backBlock(_calTf.text);
            }
            [self goback:nil];
        }
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
    
}
- (IBAction)huoquyanzhengma_clcik:(id)sender {
    NSString *urlPath = @"2.0_misc.sms";
    NSString *key = @"mobile";
    [CYWebClient basePost:urlPath parametes:@{key:_calTf.text} success:^(id responObj) {
        NSLog(@"%@dfd",responObj);
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state !=400) {
            statusTime = 0;
            [self countDown:nil];
        }else{
            isCountdown = YES;
            countTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
            self.yanzhengmaBtn.userInteractionEnabled = NO;
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
    
}

#pragma mark 验证码倒计时
-(void)countDown:(NSTimer *)time {
    statusTime --;
    if (statusTime <= -1) {
        isCountdown = NO;
        [time invalidate];
        countTime = nil;
        [self.yanzhengmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.yanzhengmaBtn.userInteractionEnabled = YES;
        statusTime = 60;
        return;
    }
    NSString *timeStr = [NSString stringWithFormat:@"获取验证码%d",(int)statusTime];
    self.yanzhengmaBtn.userInteractionEnabled = NO;
    [self.yanzhengmaBtn setTitle:timeStr forState:UIControlStateNormal];
}


@end
