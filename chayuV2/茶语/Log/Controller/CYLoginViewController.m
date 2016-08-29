//
//  CYLoginViewController.m
//  TeaMall
//
//  Created by Chayu on 15/10/29.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYLoginViewController.h"
#import "CYRegisterViewController.h"
#import "CYFindPasswordViewController.h"
#import "AppDelegate.h"
#import "CYQuickLoginViewController.h"
#import "CYImpAltView.h"
#import "BaseButton.h"
@interface CYLoginViewController ()<UITextFieldDelegate>
{
    LogInType logType;
    NSDictionary *userinfo;//用户信息
    NSString *uid;//新浪微博登录需要用
    NSString *sessionid;
    NSString *unionid;
}

@property (weak, nonatomic) IBOutlet UITextField *accountTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

- (IBAction)login_click:(id)sender;


- (IBAction)third_click:(id)sender;
- (IBAction)goback:(id)sender;
- (IBAction)forgetPassword_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UIView *third_littleview;
@property (weak, nonatomic) IBOutlet BaseButton *logBtn;

@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqbtn;

@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;

@end

@implementation CYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    logType = LogInTypeWeiXin;
    //        _accountTf.text = @"13101363950";
    //        _passwordTf.text = @"999999";
    //    
//    _accountTf.text = @"18108390553";
//    _passwordTf.text = @"123456";
    //
    //    _accountTf.text = @"18716407306";
    //    _passwordTf.text = @"123456";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self disanfangDengLuXianShi];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    self.navigationController.navigationBarHidden  = NO;
    [MobClick beginLogPageView:@"登录"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"登录"];
}
-(void)disanfangDengLuXianShi
{
    //    2.0_account.oauth.way
    [CYWebClient Post:@"2.0_account.oauth.way" parametes:nil success:^(id responObj) {
        NSDictionary *way = [responObj objectForKey:@"way"];
        if ([way isKindOfClass:[NSDictionary class]] && way.count>0) {
            BOOL weixin = [[way objectForKey:@"weixin"] integerValue] == 1?YES:NO;
            BOOL weibo = [[way objectForKey:@"weibo"] integerValue] == 1?YES:NO;
            BOOL qq = [[way objectForKey:@"qq"] integerValue] == 1?YES:NO;
            
            //            qq = NO;
            //            weixin = NO;
            //            weibo = NO;
            if (weibo || !weixin || qq) {
                _thirdView.hidden = NO;
            }
            
            if (weixin && qq && !weibo) {
                _weixinBtn.x = 57.5;
                _qqbtn.x = 133;
                _weiboBtn.hidden = YES;
            }
            
            if (weixin && weibo && !qq) {
                _weixinBtn.x = 57.5;
                _weiboBtn.x = 133;
                _qqbtn.hidden = YES;
            }
            
            if (qq && weibo && !weixin) {
                _qqbtn.x = 57.5;
                _weiboBtn.x = 133;
                _weixinBtn.hidden = YES;
            }
            
            
            if (weixin &&!qq && !weibo) {
                _qqbtn.hidden = YES;
                _weiboBtn.hidden = YES;
                _weixinBtn.x = 95;
            }
            if (weibo &&!qq && !weixin) {
                _qqbtn.hidden = YES;
                _weixinBtn.hidden = YES;
                _weiboBtn.x = 95;
            }
            
            if (qq &&!weixin && !weibo) {
                _weixinBtn.hidden = YES;
                _weiboBtn.hidden = YES;
                _qqbtn.x = 95;
            }
            
        }
        
    } failure:^(id err) {
        
    }];
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
#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)login_click:(id)sender {
    
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    _logBtn.userInteractionEnabled = NO;
    [CYWebClient Post:@"Login" parametes:@{@"account":_accountTf.text,@"password":_passwordTf.text} success:^(id responObj) {
        _logBtn.userInteractionEnabled = YES;
        if ([responObj count]) {
            NSDictionary *info = [responObj objectForJSONKey:@"user_info"];
            ChaYuer *manager = [ChaYuManager getCurrentUser];
            [manager updateUserInfo:info];
            [self dismissViewControllerAnimated:YES completion:^{
                //                 [self perfectcheck];
            }];
        }
        
    } failure:^(id err) {
        _logBtn.userInteractionEnabled = YES;
        NSLog(@"%@",err);
    }];
    
    
    
}
- (IBAction)third_click:(UIButton *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.at = kAuthorizeTypeUMLog;
    switch (sender.tag) {
        case 500://qq
        {
            logType =LogInTypeQQ;
            
            NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeMobileQQ];
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                NSLog(@"login response is %@",response);
                //获取微博用户名、uid、token等
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
                    NSLog(@"username is %@, uid is %@, token is %@,iconUrl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    userinfo = @{@"figureurl_qq_2":snsAccount.iconURL,@"nickname":snsAccount.userName};
                    [self thirdLogin:@"1" WithOpenid:snsAccount.usid AndAccess_token:snsAccount.accessToken];
                    
                }
            });
            
            break;
        }
        case 501://新浪
        {
            logType =LogInTypeSina;
            
            
            NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeSina];
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                NSLog(@"login response is %@",response);
                //          获取微博用户名、uid、token等
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    //                    NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
                    NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
                    
                    
                    userinfo = @{@"figureurl_qq_2":snsAccount.iconURL,@"nickname":snsAccount.userName};
                    
                    [self thirdLogin:@"2" WithOpenid:snsAccount.usid AndAccess_token:snsAccount.accessToken];
                    
                    
                }});
            
            break;
        }
        case 502:
        {
            logType =LogInTypeWeiXin;
            NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeWechatSession];
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                NSLog(@"response = %@",response);
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    //                    NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
                    NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
                    
                    
                    unionid = snsAccount.unionId;
                    userinfo = @{@"figureurl_qq_2":snsAccount.iconURL,@"nickname":snsAccount.userName};
                    [self thirdLogin:@"4" WithOpenid:snsAccount.usid AndAccess_token:snsAccount.accessToken];
                    
                }
                
            });
            break;
        }
            
        default:
            break;
    }
    
}


- (IBAction)regist_click:(id)sender {
    CYRegisterViewController *regVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CYRegisterViewController"];
    [self.navigationController pushViewController:regVC animated:YES];
}

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)forgetPassword_click:(id)sender {
    CYFindPasswordViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYFindPasswordViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark 自定义方法 method
/**
 *  qq登录
 */
-(void)thirdLogin:(NSString *)type WithOpenid:(NSString *)openid AndAccess_token:(NSString *)access_token
{
    NSDictionary *dict = [NSDictionary dictionary];
    if ([type integerValue] == 4) {
        dict = @{@"type":type,@"openid":openid,@"access_token":access_token,@"unionid":unionid};
    }else{
        dict = @{@"type":type,@"openid":openid,@"access_token":access_token};
    }
    
    [CYWebClient basePost:@"Thirdlogin" parametes:dict success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        sessionid = [[responObj[@"data"] objectForKey:@"sessionid"] description];
        if (state == 302) {
            if (logType == LogInTypeQQ ) {
                [self qucikLog:LogInTypeQQ WithUserinfo:userinfo];
            }else if(logType == LogInTypeWeiXin){
                [self qucikLog:LogInTypeWeiXin WithUserinfo:userinfo];
            }else{
                [self qucikLog:LogInTypeSina WithUserinfo:userinfo];
            }
        }else if (state == 400){
            [[NSUserDefaults standardUserDefaults] setObject:sessionid forKey:@"sessionid"];
            NSDictionary *info = [responObj[@"data"] objectForJSONKey:@"user_info"];
            ChaYuer *manager = [ChaYuManager getCurrentUser];
            [manager updateUserInfo:info];
            [self dismissViewControllerAnimated:YES completion:^{
                [self perfectcheck];
            }];
        }else if (state == 501){
            [SVProgressHUD showErrorWithStatus:[responObj objectForKey:@"msg"]];
        }
        
        
    } failure:^(id err) {
        
    }];
    
    
}


/**
 *  方法说明：跳转快速登录页面
 *
 *  @param type   登录类型
 *  @param userInfo   用户信息
 *
 *  @return void
 */
-(void)qucikLog:(LogInType)type WithUserinfo:(NSDictionary *)userInfo
{
    CYQuickLoginViewController *vc =viewControllerInStoryBoard(@"CYQuickLoginViewController", @"Log");
    //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYQuickLoginViewController"];
    vc.userInfo = userInfo;
    vc.sessionid = sessionid;
    vc.type = type;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)perfectcheck
{
    
    [CYWebClient basePost:@"perfect_check" parametes:nil success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state == 304) {
            [CYImpAltView show];
        }
    } failure:^(id err) {
        
        
    }];
}



@end
