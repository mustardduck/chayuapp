//
//  CYPostCardViewController.m
//  茶语
//
//  Created by Chayu on 16/3/4.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPostCardViewController.h"
#import "PlaceholderTextView.h"
#import "BaseButton.h"
#import "NTAlbum.h"
#import "CYTopWindow.h"
#ifndef NEW_TOPIC_IMG_COUNT
#define NEW_TOPIC_IMG_COUNT 10 
#endif

#define IMGCOUNT 9

@interface CYPostCardViewController ()<UITextFieldDelegate , UIActionSheetDelegate, NTAlbumDelegate>

@property (weak, nonatomic) IBOutlet PlaceholderTextView *contentTxt;

- (IBAction)confirm_click:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *titleTf;

@property (weak, nonatomic) IBOutlet UIView *imgchooseBg;


@property (weak, nonatomic) IBOutlet BaseButton *btn_comfirm;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgchoose_height_cons;

@property (nonatomic,strong)NTAlbum *albumView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet BaseButton *tijiaoBtn;


@end

@implementation CYPostCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [CYTopWindow hide];
    _contentTxt.placeholder = @"请输入内容，字数不少于10个字";
    [_imgchooseBg addSubview:self.albumView];
    __weak __typeof(self) weakSelf = self;
    weakSelf.albumView.imgcuntChangeBlock = ^(NSInteger imgcount){
        if (imgcount <IMGCOUNT) {
            _imgchoose_height_cons.constant = ceilf((imgcount+1)/4.)*82 +58;
        }else{
            _imgchoose_height_cons.constant = ceilf(imgcount/4.)*82 +58;
        }
        
        [_contentView layoutIfNeeded];
        
    };
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"发布话题"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"发布话题"];
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

- (NTAlbum *)albumView
{
    if (!_albumView) {
        _albumView = [[[NSBundle mainBundle] loadNibNamed:@"NTAlbum" owner:nil options:nil] firstObject];
        _albumView.delegate = self;
        _albumView.frame = _imgchooseBg.bounds;
        _albumView.imageCountLimit = IMGCOUNT;
        _albumView.contro = self;
    }
    return _albumView;
}



- (IBAction)confirm_click:(id)sender {
    if (_titleTf.text.length == 0) {
        [Itost showMsg:@"标题不能为空！" inView:self.view];
        return;
    }
    
    if (_contentTxt.text.length == 0) {
        [Itost showMsg:@"内容不能为空！" inView:self.view];
        return;
    }
    if(_contentTxt.text.length < 10)
    {
        [Itost showMsg:@"内容不能低于10个字！" inView:self.view];
        return;
    }
    NSMutableDictionary *files = [NSMutableDictionary dictionary];
    if (self.albumView.imageArr > 0) {
        [files setObject:self.albumView.imageArr forKey:@"photo"];
    }
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    _tijiaoBtn.userInteractionEnabled = NO;
    [CYWebClient Post:@"bbs_post_topic_add" parametes:@{@"gid":_gid,@"subject":_titleTf.text,@"content":_contentTxt.text} files:files success:^(id responObject) {
        _tijiaoBtn.userInteractionEnabled = YES;
        NSInteger status = [[responObject objectForKey:@"state"] integerValue];
        NSString *msg = [responObject objectForKey:@"msg"];
        if (status == 400) {
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showSuccessWithStatus:@"发帖成功"];
            [self performSelector:@selector(goback:) withObject:nil afterDelay:0.5f];
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
     
    } failure:^(id error) {
         _tijiaoBtn.userInteractionEnabled = YES;
        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD showErrorWithStatus:@"发帖失败"];
    }];
}



#pragma mark -
#pragma mark UITextFieldDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_titleTf resignFirstResponder];
    return YES;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"])
    {
        
        [textView resignFirstResponder];
        return NO;
        
    }
    
    return YES;
    
}
- (IBAction)goback:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)addImageClicked
{
    [_titleTf resignFirstResponder];
    
    [_contentTxt resignFirstResponder];
}

@end
