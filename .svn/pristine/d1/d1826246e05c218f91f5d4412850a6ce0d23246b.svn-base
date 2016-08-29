//
//  CYBuyerBankPhoneCodeView.m
//  茶语
//
//  Created by Leen on 16/7/4.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerBankPhoneCodeView.h"
#import "UICommon.h"

@implementation CYBuyerBankPhoneCodeView

- (void)awakeFromNib
{
    _msgView.hidden = YES;
    
    _getCodeBtn.layer.borderColor = RGB(137, 62, 32).CGColor;
    _getCodeBtn.layer.borderWidth = 0.5f;
    _getCodeBtn.layer.cornerRadius = 14.0f;
    
    _okBtn.layer.cornerRadius = 2.5f;
}


- (IBAction)touchUpInsideOn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    if(btn == _notReceiveMsgBtn)
    {
        _msgView.hidden = NO;
    }
    else if (btn == _getCodeBtn)
    {
        [_codeTxt becomeFirstResponder];
        
        [UICommon startTime:_getCodeBtn];
    }
    else if (btn == _okBtn)
    {
        if([UICommon isBlankString:_codeTxt.text])
        {
            [Itost showMsg:@"验证码不能为空" inView:self];
            
            [_codeTxt becomeFirstResponder];
            
            return;
        }
        
        [_codeTxt resignFirstResponder];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(okBtnClicked)])
        {
            [self.delegate okBtnClicked];
        }
        
    }
    else if (btn == _closePhoneCodeBtn)
    {
        self.hidden = YES;
    }
    else if (btn == _editPhoneBtn)
    {
        _msgView.hidden = YES;
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(editPhoneBtnClicked)])
        {
            [self.delegate editPhoneBtnClicked];
        }
    }
    else if (btn == _closeMsgBtn)
    {
        _msgView.hidden = YES;
    }

}

@end
