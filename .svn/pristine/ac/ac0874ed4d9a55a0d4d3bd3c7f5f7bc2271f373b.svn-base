//
//  CYImpInfoViewController.m
//  茶语
//
//  Created by Chayu on 16/5/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYImpInfoViewController.h"
#import "BaseButton.h"
#import "NSString+Valid.h"
@interface CYImpInfoViewController ()<UITextFieldDelegate>
{
    BOOL        isCountdown;    //是否正在倒计时
    NSTimer     *countTime;
    NSInteger   statusTime;     //倒计时时间
}

@property (weak, nonatomic) IBOutlet UITextField *calTf;

@property (weak, nonatomic) IBOutlet UITextField *codesTf;
- (IBAction)goback:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *pswTf;

- (IBAction)huoquyanzhengma_click:(id)sender;
@property (weak, nonatomic) IBOutlet BaseButton *codeButton;
- (IBAction)confirm_click:(id)sender;
@property (weak, nonatomic) IBOutlet BaseButton *quedingBtn;

@end

@implementation CYImpInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    statusTime = 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatRightItems
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

#pragma mark 验证码倒计时
-(void)countDown:(NSTimer *)time {
    statusTime --;
    if (statusTime <= -1) {
        isCountdown = NO;
        [time invalidate];
        countTime = nil;
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeButton.userInteractionEnabled = YES;
        statusTime =60;
        return;
    }
    
    NSString *timeStr = [NSString stringWithFormat:@"获取验证码(%d)",(int)statusTime];
    self.codeButton.userInteractionEnabled = NO;
    [self.codeButton setTitle:timeStr forState:UIControlStateNormal];
}


- (IBAction)huoquyanzhengma_click:(id)sender {
    
    if (![_calTf.text isValidMobileNumber] ) {
        [Itost showMsg:@"请输入正确的手机号码！" inView:WINDOW];
        return;
    }
    
    [CYWebClient basePost:@"misc_sms" parametes:@{@"mobile":_calTf.text} success:^(id responObj) {
        NSLog(@"%@dfd",responObj);
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state !=400) {
            statusTime = 0;
            [self countDown:nil];
        }else{
            isCountdown = YES;
            countTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
            self.codeButton.userInteractionEnabled = NO;
        }
        
    } failure:^(id err) {
        
        
    }];
}
- (IBAction)confirm_click:(id)sender {
    if (![_calTf.text isValidMobileNumber] ) {
        [Itost showMsg:@"请输入正确的手机号码！" inView:WINDOW];
        return;
    }
    
    if (!_codesTf.text.length) {
        [Itost showMsg:@"验证码不能为空！" inView:WINDOW];
        return;
    }
    
    if (!_pswTf.text.length) {
        [Itost showMsg:@"密码不能为空！" inView:WINDOW];
        return;
    }
    _quedingBtn.userInteractionEnabled = NO;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_calTf.text forKey:@"mobile"];
    [param setObject:_codesTf.text forKey:@"code"];
    [param setObject:_pswTf.text forKey:@"password"];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:@"正在提交信息" maskType:SVProgressHUDMaskTypeNone];
    [CYWebClient basePost:@"perfect_set" parametes:param success:^(id responObj) {
        NSInteger status = [[responObj objectForKey:@"state"] integerValue];
        NSString *msg = [responObj objectForKey:@"msg"];
        _quedingBtn.userInteractionEnabled = YES;
        if (status == 400) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(id err) {
        _quedingBtn.userInteractionEnabled = YES;
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
    
}



- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
