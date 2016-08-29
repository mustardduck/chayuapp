//
//  CYLeaveMessageViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/25.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYLeaveMessageViewController.h"
#import "PlaceholderTextView.h"

#define MAX_LIMIT_NUMS 100
@interface CYLeaveMessageViewController ()<UITextViewDelegate>
- (IBAction)confirm_click:(id)sender;

- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView  *messageTf;

@property (weak, nonatomic) IBOutlet UILabel *numLable;

@property (weak, nonatomic) IBOutlet UILabel *mTipLabel;

@end

@implementation CYLeaveMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.barStyle = NavBarStyleNoneMore;
    
//    _messageTf.showWordCountLabel = YES;
//    _messageTf.placeholder = @"请输入留言内容，不超过100字";
    UIView *view = _messageTf;
    view.layer.borderColor = LINECOLOR.CGColor;
    view.layer.borderWidth = 1.0f;
    view.layer.cornerRadius = 3.0f;
    
    if (_levemessage.length) {
        _messageTf.text = _levemessage;
        self.mTipLabel.hidden = YES;
        self.numLable.text = [NSString stringWithFormat:@"%ld/%d字",_levemessage.length,MAX_LIMIT_NUMS];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirm_click:(id)sender {
    
    if (!_messageTf.text.length) {
        [Itost showMsg:@"留言不能为空！" inView:self.view];
        return;
    }
    
    if (_block) {
        _block(_messageTf.text);
    }
    [self goback:nil];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
  
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (textView.text.length > 0) {
        self.mTipLabel.hidden = YES;
    }else
    {
        self.mTipLabel.hidden = NO;
    }
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.numLable.text = [NSString stringWithFormat:@"%ld/%d字",existTextNum,MAX_LIMIT_NUMS];
}



- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [self.view endEditing:YES];
//    return YES;
//}
@end
