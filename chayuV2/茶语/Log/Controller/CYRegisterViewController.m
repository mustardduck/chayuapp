//
//  CYRegisterViewController.m
//  TeaMall
//
//  Created by Chayu on 15/10/29.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYRegisterViewController.h"
#import "NSString+Valid.h"
@interface CYRegisterViewController ()<UITextFieldDelegate>
{
    BOOL        isCountdown;    //是否正在倒计时
    NSTimer     *countTime;
    NSInteger   statusTime;     //倒计时时间
    
}
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@property (weak, nonatomic) IBOutlet UITextField *securityCodeTf;

@property (weak, nonatomic) IBOutlet UITextField *nickNameTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
- (IBAction)regist_click:(id)sender;
- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet CYBorderButton *regBtn;


@end

@implementation CYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    statusTime = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatRightItems
{
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    self.navigationController.navigationBarHidden  = NO;
    [MobClick beginLogPageView:@"快速登录"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"快速登录"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBarHidden = NO;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
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
    NSString *timeStr = [NSString stringWithFormat:@"获取验证码(%d)",(int)statusTime];
    self.getVerifyCodeBtn.userInteractionEnabled = NO;
    [self.getVerifyCodeBtn setTitle:timeStr forState:UIControlStateNormal];
}

- (IBAction)regist_click:(id)sender {
    
    if (![_phoneTf.text isValidMobileNumber] ) {
        [Itost showMsg:@"请输入正确的手机号码！" inView:WINDOW];
        return;
    }
    
    if (![_securityCodeTf.text length]) {
        [Itost showMsg:@"验证码不能为空！" inView:WINDOW];
        return;
    }
    
    if (!_nickNameTf.text.length) {
        [Itost showMsg:@"昵称不能为空！" inView:WINDOW];
        return;
    }
    
    if (!_passwordTf.text.length) {
        [Itost showMsg:@"昵称能不能为空！" inView:WINDOW];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_phoneTf.text forKey:@"mobile"];
    [param setObject:_nickNameTf.text forKey:@"nickname"];
    [param setObject:_passwordTf.text forKey:@"password"];
    [param setObject:_securityCodeTf.text forKey:@"code"];
    [param setObject:@"4" forKey:@"source"];
    NSString *urlName = @"Oauth_register";
    _regBtn.userInteractionEnabled = NO;
    if (!_isThired) {
        urlName = @"Register";
    }else{
        if (_sessionid) {
            [param setObject:_sessionid forKey:@"sessionid"];
        }
        
    }
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    
    [CYWebClient basePost:urlName parametes:param success:^(id responObj) {
        _regBtn.userInteractionEnabled = YES;
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state == 400) {
            [[NSUserDefaults standardUserDefaults] setObject:_sessionid forKey:@"sessionid"];
            NSDictionary *info = [responObj objectForJSONKey:@"user_info"];
            ChaYuer *manager = [ChaYuManager getCurrentUser];
            [manager updateUserInfo:info];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
    } failure:^(id err) {
        _regBtn.userInteractionEnabled = YES;
    }];
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)obtainSecurityCode_click:(id)sender {
    
    BOOL phoneIsAvl = [_phoneTf.text isValidMobileNumber];
    
    if (!phoneIsAvl ) {
        [Itost showMsg:@"请输入正确的手机号码！" inView:WINDOW];
        return;
    }
    
    [CYWebClient basePost:@"RegisterVerify" parametes:@{@"mobile":_phoneTf.text} success:^(id responObj) {
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
        
        
    }];
    
}
#pragma mark -
#pragma mark UITextFieldDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
}


@end
