//
//  CYQuickLoginViewController.m
//  TeaMall
//
//  Created by Chayu on 15/12/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYQuickLoginViewController.h"
#import "CYRegisterViewController.h"
#import "CYBindingViewController.h"
@interface CYQuickLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
- (IBAction)regist_click:(id)sender;
- (IBAction)binding_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bindingBtn;
- (IBAction)goback:(id)sender;

@end

@implementation CYQuickLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"快速登录"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"快速登录"];
}


-(void)readyForView
{
    self.view.backgroundColor = [UIColor whiteColor];
    _headImg.layer.cornerRadius = _headImg.height/2.;
    NSURL *userHead = [NSURL URLWithString:[_userInfo objectForJSONKey:@"figureurl_qq_2"]];
    [_headImg sd_setImageWithURL:userHead placeholderImage:DEFAULTHEADER];
    NSString *status = nil;
    switch (_type) {
        case LogInTypeQQ:
            status = @"QQ";
            break;
        case LogInTypeSina:
            status = @"微博";
            break;
        case LogInTypeWeiXin:
            status = @"微信";
            break;
        default:
            break;
    }
    NSString *itostStr  = [NSString stringWithFormat:@"亲爱的%@用户：%@",status,[_userInfo objectForJSONKey:@"nickname"]];
    _nameLbl.text = itostStr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)regist_click:(id)sender {
    CYRegisterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYRegisterViewController"];
    vc.isThired = YES;
    vc.sessionid = _sessionid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)binding_click:(id)sender {
    CYBindingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYBindingViewController"];
    vc.logType = _type;
    vc.sessionid = _sessionid;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
