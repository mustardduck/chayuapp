//
//  CYShenQingWeiQuanController.m
//  茶语
//
//  Created by Chayu on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYShenQingWeiQuanController.h"
#import "PlaceholderTextView.h"
#import "NTAlbum.h"
#import "CYSelectWeiQuanController.h"
#define IMGCOUNT 5
@interface CYShenQingWeiQuanController ()


- (IBAction)goback:(id)sender;

- (IBAction)selectdingdan_click:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *weixinTf;

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *contentTf;

@property (weak, nonatomic) IBOutlet UIView *imgchooseBg;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgchoose_height_cons;

@property (nonatomic,strong)NTAlbum *albumView;

@property (weak, nonatomic) IBOutlet UITextField *calTf;

@property (weak, nonatomic) IBOutlet UITextField *orderSignTf;

- (IBAction)shenqingweiquan_click:(id)sender;


@end

@implementation CYShenQingWeiQuanController

- (void)viewDidLoad {
    [super viewDidLoad];
     [CYTopWindow hide];
    _contentTf.placeholder = @"描述您所遇到的问题（300字以内）";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NTAlbum *)albumView
{
    if (!_albumView) {
        _albumView = [[[NSBundle mainBundle] loadNibNamed:@"NTAlbum" owner:nil options:nil] firstObject];
        _albumView.frame = _imgchooseBg.bounds;
        _albumView.imageCountLimit = IMGCOUNT;
        _albumView.contro = self;
    }
    return _albumView;
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

- (IBAction)selectdingdan_click:(id)sender {
    CYSelectWeiQuanController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYSelectWeiQuanController"];
    vc.backInfoBlock = ^(NSString *orderStr){
        _orderSignTf.text = orderStr;
    };
    vc.selectOrderStr = _orderSignTf.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shenqingweiquan_click:(id)sender {
//    2.0_user.rights.saveRights
    
    if (_orderSignTf.text.length==0) {
        [SVProgressHUD showInfoWithStatus:@"请选择维权订单"];
//        [Itost showMsg:@"请选择维权订单！" inView:WINDOW];
        return;
    }
    
    if (_calTf.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请填写联系电话"];
//        [Itost showMsg:@"请填写联系电话！" inView:WINDOW];
        return;
    }
    
    if (_contentTf.text.length == 0) {
         [SVProgressHUD showInfoWithStatus:@"请填写描述内容"];
//        [Itost showMsg:@"请填写描述内容" inView:WINDOW];
        return;
        
        
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_contentTf.text forKey:@"rights_content"];
    [params setObject:_orderSignTf.text forKey:@"order_sn"];
    
    if (_weixinTf.text.length>0) {
        [params setObject:_weixinTf.text forKey:@"wechat_number"];
    }
    
    
    if (_calTf.text.length >0) {
        [params setObject:_calTf.text forKey:@"mobile"];
    }
    
    
    NSMutableDictionary *files = [NSMutableDictionary dictionary];
    if (self.albumView.imageArr > 0) {
        [files setObject:self.albumView.imageArr forKey:@"attach"];
    }
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient Post:@"2.0_user.rights.saveRights" parametes:params files:files success:^(id responObject) {
        NSInteger status = [[responObject objectForKey:@"state"] integerValue];
        NSString *msg = [responObject objectForKey:@"msg"];
        if (status == 400) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [self performSelector:@selector(goback:) withObject:nil afterDelay:0.5f];
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@""];
    }];
    
}
@end
