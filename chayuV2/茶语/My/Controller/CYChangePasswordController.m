//
//  CYChangePasswordController.m
//  TeaMall
//修改密码
//  Created by Chayu on 15/11/3.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYChangePasswordController.h"

@interface CYChangePasswordController ()
- (IBAction)goback:(id)sender;
- (IBAction)confirm_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (weak, nonatomic) IBOutlet UITextField *oldPswTf;
@property (weak, nonatomic) IBOutlet UITextField *paswwordTf;

@property (weak, nonatomic) IBOutlet UITextField *confirmPswTf;

@end

@implementation CYChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    _confirmBtn.layer.cornerRadius = 3.0f;
    //self.barStyle = NavBarStyleNoneMore;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)confirm_click:(id)sender {
    if (_oldPswTf.text.length==0) {
        [Itost showMsg:@"原密码不能为空!" inView:self.view];
        return;
    }
    
    if ([_paswwordTf.text length] <6 || [_paswwordTf.text length]>20) {
        [Itost showMsg:@"新密码为6-20位字母、数字!" inView:self.view];
        return;
    }
    
    if (![_paswwordTf.text isEqualToString:_confirmPswTf.text]) {
         [Itost showMsg:@"两次密码输入不一致!" inView:self.view];
         return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_oldPswTf.text forKey:@"oldPwd"];
    [param setObject:_confirmPswTf.text forKey:@"newPwd"];
    [CYWebClient Post:@"Modify" parametes:param success:^(id responObj) {
        [self goback:nil];
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}
@end
