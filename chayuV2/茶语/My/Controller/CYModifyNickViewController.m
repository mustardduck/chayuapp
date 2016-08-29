//
//  CYModifyNickViewController.m
//  TeaMall
//
//  Created by Chayu on 15/12/11.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYModifyNickViewController.h"

@interface CYModifyNickViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentview;
- (IBAction)confirm_click:(id)sender;
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTf;
@end

@implementation CYModifyNickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = _contentview;
    view.layer.borderColor = LINECOLOR.CGColor;
    view.layer.borderWidth = 1.0f;
    _nickNameTf.text = _nameStr;
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)confirm_click:(id)sender {

    
    if (!_nickNameTf.text.length) {
      [Itost showMsg:@"昵称不能为空！" inView:self.view];
        return;
    }
    
    [CYWebClient Post:@"Usermodify" parametes:@{@"nickname":_nickNameTf.text} success:^(id responObj) {
        if (responObj) {
            if (_name) {
                _name(_nickNameTf.text);
            }
             [self goback:nil];
        }
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
    
   
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController :YES];
}
@end
