//
//  CYPublicPostCardController.m
//  茶语
//
//  Created by Chayu on 16/7/15.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPublicPostCardController.h"
#import "PlaceholderTextView.h"
#import "BaseButton.h"
@interface CYPublicPostCardController ()


- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *contentTxt;
- (IBAction)tijiao_click:(id)sender;

@property (weak, nonatomic) IBOutlet BaseButton *tijiaoBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;


@end

@implementation CYPublicPostCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_huifutype == HuiFuTypeWenChaPing) {
        _titleLbl.text = @"发表回复";
    }
    _contentTxt.placeholder = @"请输入回复内容，字数不少于5个字";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick beginLogPageView:@"发表评论"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"发表评论"];
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

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)tijiao_click:(id)sender {
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    
    [_contentTxt resignFirstResponder];
    NSString *content = self.contentTxt.text;
    if (content.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    
    [param setObject:self.contentTxt.text forKey:@"content"];
    
    NSString *urlPath = nil;
    if (_huifutype == HuiFuTypeWenZhang) {
        if (_mItemid!=nil) {
            [param setObject:_mItemid forKey:@"itemid"];
        }
        if (self.pid != nil) {
            [param setObject:self.pid forKey:@"pid"];
        }
        
        if (self.touid != nil) {
            [param setObject:self.touid forKey:@"touid"];
        }
        urlPath = @"ArticleCommentsSave";
    }else if (_huifutype == HuiFuTypeWenHuaTi){
        [param setObject:_mItemid forKey:@"tid"];
        if (self.pid != nil) {
            [param setObject:self.pid forKey:@"pid"];
        }
        
        if (self.touid != nil) {
            [param setObject:self.touid forKey:@"touid"];
        }
        urlPath = @"freply_review";
    }else{
        if (self.pid != nil) {
            [param setObject:self.pid forKey:@"reviewid"];
        }
        
        if (self.touid != nil) {
            [param setObject:self.touid forKey:@"touid"];
        }
        urlPath = @"freply_review";
    }
    
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    _tijiaoBtn.userInteractionEnabled = NO;
    [CYWebClient basePost:urlPath parametes:param success:^(id responObject) {
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        NSString *msg =[responObject objectForKey:@"msg"];
        _tijiaoBtn.userInteractionEnabled = YES;
        if (state == 400) {
            [SVProgressHUD dismiss];
            if (self.postcardbackBlock) {
                self.postcardbackBlock();
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(id error) {
        _tijiaoBtn.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
}
@end
