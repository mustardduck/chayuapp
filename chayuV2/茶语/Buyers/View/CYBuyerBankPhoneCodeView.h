//
//  CYBuyerBankPhoneCodeView.h
//  茶语
//
//  Created by Leen on 16/7/4.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerBankPhoneCodeDelegate;

@interface CYBuyerBankPhoneCodeView : UIView

@property (weak, nonatomic) IBOutlet UIView *codeView;

@property (weak, nonatomic) IBOutlet UIView *msgView;

@property (nonatomic, assign)id<CYBuyerBankPhoneCodeDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UIButton *notReceiveMsgBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTxt;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UIButton *closePhoneCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeMsgBtn;
@property (weak, nonatomic) IBOutlet UIButton *editPhoneBtn;

@end

@protocol CYBuyerBankPhoneCodeDelegate <NSObject>

@optional

- (void)okBtnClicked;
- (void)editPhoneBtnClicked;

@end
