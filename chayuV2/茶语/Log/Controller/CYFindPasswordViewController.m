//
//  CYFirstFindPasswordViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/3.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYFindPasswordViewController.h"
#import "NSString+Valid.h"
#import "BaseButton.h"
@interface CYFindPasswordViewController ()<UIAlertViewDelegate>
{
    //重置密码密钥
    NSString *reset_code;
    BOOL        isCountdown;    //是否正在倒计时
    NSTimer     *countTime;
    NSInteger   statusTime;     //倒计时时间
}
- (IBAction)next_click:(id)sender;
- (IBAction)completeVerification_click:(id)sender;
@property (weak, nonatomic) IBOutlet CYBorderButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *calNumTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

@property (weak, nonatomic) IBOutlet UITextField *securityCodeTf;

@property (weak, nonatomic) IBOutlet CYBorderButton *completeBtn;
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secView;

@property (weak, nonatomic) IBOutlet BaseButton *getVerifyCodeBtn;

@end

@implementation CYFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    statusTime = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"找回密码"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"找回密码"];
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

- (IBAction)next_click:(id)sender {
//    
//    if (![_calNumTf.text isValidMobileNumber]) {
//        [Itost showMsg:@"请输入正确的手机号码！" inView:self.view];
//        return;
//    }
    
    NSRange rang = [_calNumTf.text rangeOfString:@"@"];
    [CYWebClient Post:@"2.0_account.findpwd.step_one" parametes:@{@"account":_calNumTf.text} success:^(id responObj) {
        if (rang.location == NSNotFound) {
            _statusLable.text = [NSString stringWithFormat:@"点击获取验证码，系统将向您的邮箱%@发送一条验证短信",_calNumTf.text];
        }else{
            _statusLable.text = [NSString stringWithFormat:@"点击获取验证码，系统将向您的手机%@发送一条验证短信",_calNumTf.text];
        }
        reset_code = [responObj objectForKey:@"reset_code"];
        _firstView.hidden = YES;
        _secView.hidden = NO;
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];

}

- (IBAction)completeVerification_click:(id)sender {
    

    [CYWebClient Post:@"2.0_account.findpwd.step_two" parametes:@{@"code":_securityCodeTf.text,@"password":_passwordTf.text,@"reset_code":reset_code} success:^(id responObj) {
         [SVProgressHUD dismiss];
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:nil message:@"修改密码成功，请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"重新登录", nil];
        [alt show];
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
   
}

- (IBAction)save_click:(id)sender {
    if (![_passwordTf.text isEqualToString:_passwordTf.text]) {
        [Itost showMsg:@"两次密码输入不一致!" inView:self.view];
        return;
    }
    [CYWebClient Post:@"Reset_pwd" parametes:@{@"password":_passwordTf.text} success:^(id responObj) {
        if (responObj) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(id err) {
        
    }];
//    [self performSelector:@selector(goback:) withObject:nil afterDelay:1.0f];
}


#pragma mark 验证码倒计时
-(void)countDown:(NSTimer *)time {
    statusTime --;
    if (statusTime <= -1) {
        isCountdown = NO;
        [time invalidate];
        countTime = nil;
        [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getVerifyCodeBtn.userInteractionEnabled = YES;
        statusTime = 60;
        return;
    }
    NSString *timeStr = [NSString stringWithFormat:@"获取验证码%d",(int)statusTime];
    self.getVerifyCodeBtn.userInteractionEnabled = NO;
    [self.getVerifyCodeBtn setTitle:timeStr forState:UIControlStateNormal];
}


- (IBAction)resend_click:(id)sender {
    
//    2.0_misc.sms
    NSRange rang = [_calNumTf.text rangeOfString:@"@"];
    NSString *urlPath = @"2.0_misc.sms";
    NSString *key = @"mobile";
    if (rang.location!=NSNotFound) {
        urlPath = @"2.0_misc.email";
        key = @"email";
    }
    [CYWebClient basePost:urlPath parametes:@{key:_calNumTf.text} success:^(id responObj) {
        NSLog(@"%@dfd",responObj);
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state !=400) {
            statusTime = 0;
            [self countDown:nil];
        }else{
            isCountdown = YES;
            countTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
            self.getVerifyCodeBtn.userInteractionEnabled = NO;
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
