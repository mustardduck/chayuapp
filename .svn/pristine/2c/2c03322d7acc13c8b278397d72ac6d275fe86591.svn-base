//
//  CYWriteArticelCommentViewController.m
//  茶语
//
//  Created by 李峥 on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWriteArticelCommentViewController.h"
#import "AppDelegate.h"
@interface CYWriteArticelCommentViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *mTextView;
@property (weak, nonatomic) IBOutlet UILabel *mTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *mSendBtn;

@property (weak, nonatomic) IBOutlet UILabel *numLable;


@end

@implementation CYWriteArticelCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发表评论";
    
    [_mSendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _mSendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _mSendBtn.backgroundColor = MAIN_COLOR;
    _mSendBtn.layer.masksToBounds = YES;
    _mSendBtn.layer.cornerRadius = 4;
    
    _mTextView.layer.borderColor = RGB(179, 179, 179).CGColor;
    _mTextView.layer.borderWidth = 1;
    _mTextView.layer.masksToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"文章评论"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"文章评论"];
}



- (IBAction)clickSend:(id)sender {
    
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    
    NSString *content = self.mTextView.text;
    if (content.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:_mItemid forKey:@"itemid"];
    [param setObject:self.mTextView.text forKey:@"content"];
    
    if (self.pid != nil) {
        [param setObject:self.pid forKey:@"pid"];
    }
    
    if (self.touid != nil) {
        [param setObject:self.touid forKey:@"touid"];
    }
    
    
    [SVProgressHUD showInfoWithStatus:@"正在提交"];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    if (_isTea) {
        [CYWebClient Post:@"freply_review" parametes:@{@"reviewid":_pid,@"content":content,@"touid":_touid} success:^(id responObject) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(commentSuccess)]) {
                [_delegate commentSuccess];
            }
             [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(id error) {
             [SVProgressHUD dismiss];
        }];
        
    }else{
        [CYWebClient Post:@"ArticleCommentsSave" parametes:param success:^(id responObject) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(commentSuccess)]) {
                [_delegate commentSuccess];
            }
             [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(id error) {
             [SVProgressHUD dismiss];
        }];
    }
    
    
    
}



#define MAX_LIMIT_NUMS 500

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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
