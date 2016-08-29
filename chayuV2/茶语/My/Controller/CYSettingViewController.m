//
//  CYSettingViewController.m
//  TeaMall
//  设置
//  Created by Chayu on 15/11/3.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYSettingViewController.h"
#import "CYPersonalCenterViewController.h"
@interface CYSettingViewController ()<UIActionSheetDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
- (IBAction)logout_click:(id)sender;
- (IBAction)clearcache_click:(id)sender;
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dataSizeLbl;
- (IBAction)gerenziliao_click:(id)sender;

@end

@implementation CYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _logoutBtn.hidden = !MANAGER.isLoged;
    _logoutBtn.layer.cornerRadius = 3.0f;
   _dataSizeLbl.text = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache] getSize]/1024./1024.] ;

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

- (IBAction)logout_click:(id)sender {
    
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alt show];
    
    
}


- (IBAction)clearcache_click:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定清除缓存吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    [sheet showInView:self.view];

}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIActionSheetDelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0) {
        [[SDImageCache sharedImageCache] clearDisk];
        _dataSizeLbl.text = @"0M";
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        ChaYuer *manager = MANAGER;
        manager.loged = NO;
        manager.uid = @"";
        manager.nickname = @"";
        manager.avatar = @"";
        manager.regtime = @"";
        manager.loginToken = @"";
        manager.loginssectionid = @"";
        manager.tuijianInfo = nil;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"sessionid"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
        [ChaYuManager archiveCurrentUser:manager];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"0"}];
    }
}
- (IBAction)gerenziliao_click:(id)sender {
    CYPersonalCenterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYPersonalCenterViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
