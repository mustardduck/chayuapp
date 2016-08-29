//
//  CYShenQingQuanZhuController.m
//  茶语
//
//  Created by Chayu on 16/7/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYShenQingQuanZhuController.h"
#import "PlaceholderTextView.h"
#import "BaseButton.h"
#import "CYTopicDetailController.h"
@interface CYShenQingQuanZhuController ()
{
    BOOL        isCountdown;    //是否正在倒计时
    NSTimer     *countTime;
    NSInteger   statusTime;     //倒计时时间
}

@property (weak, nonatomic) IBOutlet UITextField *nameTf;

@property (weak, nonatomic) IBOutlet UITextField *qqhaoTf;

@property (weak, nonatomic) IBOutlet UITextField *shenfenzhengTf;
@property (weak, nonatomic) IBOutlet UITextField *addressTf;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *liyouTf;

@property (weak, nonatomic) IBOutlet UITextField *calTf;

@property (weak, nonatomic) IBOutlet UITextField *codeTf;


- (IBAction)huoquyanzhengma_click:(id)sender;

- (IBAction)tijiao_click:(id)sender;


- (IBAction)changestatus_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;

@property (weak, nonatomic) IBOutlet BaseButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *topLable;

- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet BaseButton *tijiaoBtn;
- (IBAction)guanliguifan_click:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *yuedBtn;

@end

@implementation CYShenQingQuanZhuController

- (void)viewDidLoad {
    [super viewDidLoad];
    statusTime = 60;
    _liyouTf.placeholder = @"请输入申请理由，字数在100字以内";
    _statusImg.highlighted = YES;
    NSString *str = [NSString stringWithFormat:@"您正在申请“%@”圈子的圈主，请提供一下信息：",_quanziName];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,_quanziName.length +2)];
    _topLable.attributedText = attrStr;
    
    NSString *yueduStr = @"已阅读并同意《茶语圈主管理规范》";
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:yueduStr];
    [attrStr1 addAttribute:NSForegroundColorAttributeName value:MAIN_COLOR range:NSMakeRange(6,yueduStr.length -6)];
    _yuedBtn.attributedText = attrStr1;
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
#pragma mark 验证码倒计时
-(void)countDown:(NSTimer *)time {
    statusTime --;
    if (statusTime <= -1) {
        isCountdown = NO;
        [time invalidate];
        countTime = nil;
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = YES;
        statusTime = 60;
        return;
    }
    NSString *timeStr = [NSString stringWithFormat:@"获取验证码%d",(int)statusTime];
    self.codeBtn.userInteractionEnabled = NO;
    [self.codeBtn setTitle:timeStr forState:UIControlStateNormal];
}



- (IBAction)huoquyanzhengma_click:(id)sender {

    if (_calTf.text.length==0) {
        [Itost showMsg:@"请输入手机号" inView:WINDOW];
        return;
    }
    [CYWebClient basePost:@"2.0_misc.sms" parametes:@{@"mobile":_calTf.text} success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state !=400) {
            statusTime = 0;
            [self countDown:nil];
        }else{
            isCountdown = YES;
            countTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
            self.codeBtn.userInteractionEnabled = NO;
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
    
}

- (IBAction)tijiao_click:(id)sender {
    
    if (_nameTf.text.length==0) {
        [Itost showMsg:@"请输入真实姓名" inView:WINDOW];
        return;
    }
    if (_shenfenzhengTf.text.length==0) {
        [Itost showMsg:@"请输入身份证号" inView:WINDOW];
        return;
    }
    if (_addressTf.text.length==0) {
        [Itost showMsg:@"请输入联系地址" inView:WINDOW];
        return;
    }
    if (_liyouTf.text.length==0) {
        [Itost showMsg:@"请输入申请理由" inView:WINDOW];
        return;
    }
    if (_calTf.text.length==0) {
        [Itost showMsg:@"请输入手机号" inView:WINDOW];
        return;
    }
    if (_codeTf.text.length==0) {
        [Itost showMsg:@"请输入验证码" inView:WINDOW];
        return;
    }
    
    if (_statusImg.highlighted == NO) {
        [Itost showMsg:@"请阅读并同意《茶语圈主管理规范》" inView:WINDOW];
        return;
    }
    
//    2.0_quanzi.group.applay_manger
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_quanziId.length) {
        [params setObject:_quanziId forKey:@"gid"];
    }
    
    [params setObject:_nameTf.text forKey:@"name"];
    if (_qqhaoTf.text.length) {
        [params setObject:_qqhaoTf.text forKey:@"qq"];
    }
    
    [params setObject:_shenfenzhengTf.text forKey:@"idcard"];
    [params setObject:_liyouTf.text forKey:@"reason"];
    [params setObject:_calTf.text forKey:@"mobile"];
    [params setObject:_addressTf.text forKey:@"address"];
    [params setObject:_codeTf.text forKey:@"capta"];
    
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    _tijiaoBtn.userInteractionEnabled = NO;
    [CYWebClient basePost:@"2.0_quanzi.group.applay_manger" parametes:params success:^(id responObject) {
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        if (state == 400) {
            [self goback:nil];
        }
        _tijiaoBtn.userInteractionEnabled = YES;
        

    } failure:^(id error) {
        _tijiaoBtn.userInteractionEnabled = YES;
    }];
    
    
}

- (IBAction)changestatus_click:(id)sender {
    _statusImg.highlighted = !_statusImg.highlighted;
    
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)guanliguifan_click:(id)sender {
    CYTopicDetailController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYTopicDetailController"];
    vc.tid = @"455165";
    vc.gid = @"";//[info objectForKey:@"gid"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
