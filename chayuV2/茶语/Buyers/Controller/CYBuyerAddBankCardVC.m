//
//  CYBuyerAddBankCardVC.m
//  茶语
//
//  Created by Leen on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerAddBankCardVC.h"
#import "CYBuyerBankPhoneCodeView.h"
#import "UICommon.h"
#import "NSString+Valid.h"


@interface CYBuyerAddBankCardVC ()<CYBuyerBankPhoneCodeDelegate, UITextFieldDelegate>
{
    UITextField * _currentTxt;
}

@property (nonatomic, strong) CYBuyerBankPhoneCodeView * phoneCodeView;

@property (weak, nonatomic) IBOutlet UIButton *selectBankBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *IDNumberTxt;
@property (weak, nonatomic) IBOutlet UITextField *bankCardTxt;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTxt;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;


@end

@implementation CYBuyerAddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.phoneCodeView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _currentTxt = textField;
}


- (IBAction)commitClicked:(id)sender
{
    if(![self validField])
    {
        return;
    }
    
    [_currentTxt resignFirstResponder];
    
    NSString * str = [_phoneNumberTxt.text stringByReplacingCharactersInRange:NSMakeRange(3, 3) withString:@"***"];
    
    _phoneCodeView.phoneLbl.text = [NSString stringWithFormat:@"安全手机号：%@", str];
    
    _phoneCodeView.hidden = NO;
}

- (BOOL )validField
{
//    if([_selectBankBtn.titleLabel.text isEqualToString:@"请选择开户行"])
//    {
//        [Itost showMsg:@"请选择开户行" inView:self.view];
//        
//        return NO;
//
//    }
     if([UICommon isBlankString:_nameTxt.text])
    {
        [Itost showMsg:@"请输入持卡人姓名" inView:self.view];
        
        [_nameTxt becomeFirstResponder];
        
        return NO;
    }
    else if([UICommon isBlankString:_IDNumberTxt.text])
    {
        [Itost showMsg:@"请输入身份证号码" inView:self.view];
        
        [_IDNumberTxt becomeFirstResponder];
        
        return NO;
    }
    else if([UICommon isBlankString:_bankCardTxt.text])
    {
        [Itost showMsg:@"请输入卡号" inView:self.view];
        
        [_bankCardTxt becomeFirstResponder];
        
        return NO;
    }
    else if([UICommon isBlankString:_phoneNumberTxt.text])
    {
        [Itost showMsg:@"请输入手机号码" inView:self.view];
        
        [_phoneNumberTxt becomeFirstResponder];
        
        return NO;
    }
    else if(![_IDNumberTxt.text isValidPersonIDCardNumber])
    {
        [Itost showMsg:@"请输入正确的身份证号码" inView:self.view];
        
        [_IDNumberTxt becomeFirstResponder];
        
        return NO;
    }
    else if(![_bankCardTxt.text isValidBankCardNumber])
    {
        [Itost showMsg:@"请输入正确的银行卡号码" inView:self.view];
        
        [_bankCardTxt becomeFirstResponder];
        
        return NO;
    }
    else if(![_phoneNumberTxt.text isValidMobileNumber])
    {
        [Itost showMsg:@"请正确的手机号码" inView:self.view];
        
        [_phoneNumberTxt becomeFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (CYBuyerBankPhoneCodeView *)phoneCodeView
{
    if (!_phoneCodeView) {
        _phoneCodeView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerBankPhoneCodeView" owner:nil options:nil] firstObject];
        _phoneCodeView.frame = WINDOW.bounds;
        _phoneCodeView.delegate = self;
        _phoneCodeView.hidden = YES;
    }
    return _phoneCodeView;
}

- (void)okBtnClicked
{
    
}

- (void)editPhoneBtnClicked
{
    _phoneCodeView.hidden = YES;
    
    [_phoneNumberTxt becomeFirstResponder];
}

- (IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
