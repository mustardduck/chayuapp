//
//  CYApplyRerundViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/9.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYApplyRerundViewController.h"
#import "BBImageChooseView.h"
#import "NSString+Valid.h"
#import "LDXDropDown.h"
//#import "MLInputDodger.h"
#import "CYOrderDetailViewController.h"
#import "NTAlbum.h"
#import "PlaceholderTextView.h"
#import "CYXuanZeTuiKuanYuanYinController.h"
#define IMGCOUNT 5
@interface CYApplyRerundViewController ()<UITextFieldDelegate,LDXDropDownDelegate>
{
    BBImageChooseView *imageChooseView;
    LDXDropDown *dropDown_company;
    NSInteger resonint;
    
}
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

- (IBAction)selectMenu_click:(UIButton *)sender;
- (IBAction)selectReason_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *refundImg;
@property (weak, nonatomic) IBOutlet UIImageView *returnImg;

@property (weak, nonatomic) IBOutlet UIButton *returnBtn;

@property (weak, nonatomic) IBOutlet UIView *typeBgView;

- (IBAction)apply_click:(id)sender;
- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *imgChooseContentView;

@property (weak, nonatomic) IBOutlet UITextField *moneyTf;

@property (weak, nonatomic) IBOutlet UITextField *resonTxt;


@property (weak, nonatomic) IBOutlet PlaceholderTextView *shuomingTxt;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topview_cons;
@property (nonatomic,strong)NTAlbum *albumView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgchoose_height_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shuliang_height_cons;
@property (weak, nonatomic) IBOutlet UITextField *numTf;

@end

@implementation CYApplyRerundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    resonint = -1;
    //self.barStyle = NavBarStyleNone;
    //    UIScrollView *scro = (UIScrollView *)[self.view viewWithTag:3005];
    _applyBtn.layer.cornerRadius = 3.0f;
    _priceLbl.text = [NSString stringWithFormat:@"（最多%.2f）",[_model.refund_price floatValue]];
    //    [self addImgChooseView];
    //    [_contentView registerAsDodgeViewForMLInputDodger];
    [_imgChooseContentView addSubview:self.albumView];
    __weak __typeof(self) weakSelf = self;
    weakSelf.albumView.imgcuntChangeBlock = ^(NSInteger imgcount){
        if (imgcount <IMGCOUNT) {
            _imgchoose_height_cons.constant = ceilf((imgcount+1)/4.)*82 +58;
        }else{
            _imgchoose_height_cons.constant = ceilf(imgcount/4.)*82 +58;
        }
        
        [_contentView layoutIfNeeded];
    };
    _shuomingTxt.placeholder = @"请详细说明退款原因";
    _refundImg.highlighted = YES;
    _shuliang_height_cons.constant = 0.0;
    if ([_states integerValue] == 2) {
        _returnBtn.userInteractionEnabled = NO;
        _resonTxt.placeholder = @"请选择退款原因";
        _titleLbl.text = @"申请退款-未发货";
        _imgchoose_height_cons.constant = 5.0;
        _moneyTf.text = [NSString stringWithFormat:@" %.2f",[_model.refund_price floatValue]];;
        _moneyTf.userInteractionEnabled = NO;
        
    }else if ([_states integerValue] ==3){
        _titleLbl.text = @"申请退款-已发货";
        _moneyTf.userInteractionEnabled = YES;
    }else if([_states integerValue] >3){
        _titleLbl.text = @"申请退款";
    }
    
    _contentView.contentSize = CGSizeMake(SCREEN_WIDTH,_applyBtn.height +_applyBtn.y +50);
    _bottom_cons.constant = 20.;
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

- (NTAlbum *)albumView
{
    if (!_albumView) {
        _albumView = [[[NSBundle mainBundle] loadNibNamed:@"NTAlbum" owner:nil options:nil] firstObject];
        _albumView.frame = _imgChooseContentView.bounds;
        _albumView.imageCountLimit = IMGCOUNT;
        _albumView.contro = self;
    }
    return _albumView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addImgChooseView
{
    _refundImg.highlighted = YES;
    imageChooseView = [BBImageChooseView imageChooseViewWithFrame:_imgChooseContentView.bounds andShowViewController:self];
    imageChooseView.imageSize = CGSizeMake(_imgChooseContentView.height, _imgChooseContentView.height);
    [imageChooseView setAddImageBtnImage:[UIImage imageNamed:@"icon_pic_add"]];
    //    imageChooseView.delegateForMe = self;
    imageChooseView.gap = 5.;
    imageChooseView.maxWidthLimit = SCREEN_WIDTH - 20;
    imageChooseView.imageCountLimit = 5;
    imageChooseView.removeMode = BBImageChooseViewRemoveModeLongpress;
    imageChooseView.onlyForShow = NO;
    imageChooseView.autoAdjustFrameToContentSize = YES;
    imageChooseView.sourceType = BBImageChooseViewSourceTypeAll;
    [_imgChooseContentView addSubview:imageChooseView];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)selectMenu_click:(UIButton *)sender {
    for (int i =2700; i<2702; i++) {
        UIButton *selectBtn = (UIButton *)[_typeBgView viewWithTag:i];
        if (selectBtn.tag  == sender.tag) {
            selectBtn.selected = YES;
        }else{
            selectBtn.selected = NO;
        }
    }
    if (sender.tag == 2700) {
        _refundImg.highlighted = YES;
        _returnImg.highlighted = NO;
        _shuliang_height_cons.constant = 0.0;
        
    }else{
        _refundImg.highlighted = NO;
        _returnImg.highlighted = YES;
        //        _titleLbl.text = @"申请退货";
        _shuliang_height_cons.constant = 80.0;
    }
    
}

/**
 *  选择原因
 */
- (IBAction)selectReason_click:(id)sender {
    
    NSArray *arr = _refundImg.highlighted?@[@"收到的商品破损",@"商品错发/漏发",@"商品质量问题",@"未收到货"]:@[@"收到的商品破损",@"商品错发/漏发",@"商品质量问题"];
    if ([_states isEqualToString:@"2"]) {
        arr = @[@"拍错了",@"不想买了"];
    }
    
    CYXuanZeTuiKuanYuanYinController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYXuanZeTuiKuanYuanYinController"];
    vc.dataArr = arr;
    vc.tuikuanyuanyinBlock = ^(NSString *reson,NSInteger index){
        _resonTxt.text = reson;
        resonint = index;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) ldxDropDownDelegateMethod:(LDXDropDown *)sender index:(NSInteger)index title:(NSString *)title{
    if (sender == dropDown_company) {
        resonint = index;
        _resonTxt.text = title;
        //        [_resonBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  提交申请
 */
- (IBAction)apply_click:(id)sender {
    
    if (!_resonTxt.text.length) {
        [Itost showMsg:@"请选择退款原因" inView:WINDOW];
        return;
    }
    
    if (!_moneyTf.text.length) {
        [Itost showMsg:@"请输入退款金额！" inView:WINDOW];
        
        return;
    }
    
    //    [[NSScanner scannerWithString:_moneyTf.text] scanFloat:NULL];
    //    NSRange rang = [_moneyTf.text rangeOfString:@"."];
    if (![self isPureFloat:_moneyTf.text]) {
        [Itost showMsg:@"请输入正确的退款金额" inView:WINDOW];
        return;
    }
    
    if ([_moneyTf.text floatValue]>[_model.refund_price floatValue]) {
        [Itost showMsg:@"请输入正确的退款金额" inView:WINDOW];
        return;
    }
    
    if (_returnImg.highlighted) {
        
        if (!_numTf.text.length) {
            [Itost showMsg:@"请输入退款数量" inView:WINDOW];
            return;
        }
        
        if ([_numTf.text isNumber] && [_numTf.text integerValue]>[_model.goodsNumber integerValue]) {
            [Itost showMsg:@"请输入正确的退款数量" inView:WINDOW];
            return;
        }
    }
    
    _applyBtn.userInteractionEnabled = NO;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_orderModel.orderSn forKey:@"orderSn"];
    [param setObject:_model.goods_id forKey:@"goodsId"];
    [param setObject:_model.name forKey:@"goodsName"];
    [param setObject:_model.specdataId forKey:@"specDataId"];
    NSString *refundType = _refundImg.highlighted?@"1":@"2";
    [param setObject:refundType forKey:@"refundType"];
    [param setObject:_moneyTf.text              forKey:@"money"];
    [param setObject:@(resonint+1)  forKey:@"reson"];
    [param setObject:_shuomingTxt.text forKey:@"coption"];
    if ([refundType isEqualToString:@"2"]) {
        [param setObject:_numTf.text forKey:@"backNumber"];
    }
    
    __weak __typeof(self) weakSelf = self;
    [SVProgressHUD showWithStatus:@"正在提交申请..."];
    if (self.albumView.imageArr.count) {
        [CYWebClient Post:@"Goodsrefund" parametes:param files:@{@"image":self.albumView.imageArr} success:^(id responObject) {
            _applyBtn.userInteractionEnabled = YES;
            NSInteger state =[[responObject objectForKey:@"state"] integerValue];
            if (state == 400) {
                if (responObject) {
                    if (weakSelf.applyBlock) {
                        weakSelf.applyBlock();
                    }
                    [SVProgressHUD showSuccessWithStatus:@"申请提交成功,等待卖家处理"];
                    [self performSelector:@selector(goback:) withObject:nil afterDelay:1.0];
                }
            }
            
            
        } failure:^(id error) {
            _applyBtn.userInteractionEnabled = YES;
            [SVProgressHUD showInfoWithStatus:@"请求失败"];
        }];
    }else{
        [CYWebClient basePost:@"Goodsrefund" parametes:param success:^(id responObject) {
            _applyBtn.userInteractionEnabled = YES;
            NSInteger state =[[responObject objectForKey:@"state"] integerValue];
            if (state == 400) {
                
                //                if (responObject) {
                if (weakSelf.applyBlock) {
                    weakSelf.applyBlock();
                }
                [SVProgressHUD showSuccessWithStatus:@"申请提交成功,等待卖家处理"];
                [self performSelector:@selector(goback:) withObject:nil afterDelay:1.0];
                //                }
            }
        } failure:^(id error) {
            _applyBtn.userInteractionEnabled = YES;
            [SVProgressHUD showInfoWithStatus:@"请求失败"];
        }];
    }
    
    
}

- (IBAction)goback:(id)sender {
    NSArray *vcArr = self.navigationController.viewControllers;
    UIViewController *aimVC = nil;
    for (NSInteger i=vcArr.count-1; i>=0; i--) {
        if ([vcArr[i] isKindOfClass:[CYOrderDetailViewController class]] ) {
            aimVC = vcArr[i];
            break;
        }
    }
    if (aimVC) {
        [self.navigationController popToViewController:aimVC animated:YES];
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

@end
