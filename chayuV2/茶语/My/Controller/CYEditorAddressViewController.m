//
//  CYEditorAddressViewController.m
//  TeaMall
//  修改收货地址
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYEditorAddressViewController.h"
#import "CYLocationPickerView.h"
#import "NSString+Valid.h"
#import "FMDB.h"
@interface CYEditorAddressViewController ()<UITextFieldDelegate,CYLocationPickerViewDelegate>
{
    NSMutableDictionary *_locationInfo;
    NSString *phoneNumber;
    FMDatabase *fmdb;
    
}


@property (weak, nonatomic) IBOutlet UITextField *youzhengCode;


- (IBAction)goback:(id)sender;

@property (nonatomic,strong)CYLocationPickerView *locationView;
@property (weak, nonatomic) IBOutlet UITextField *addressTf;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;

@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@property (weak, nonatomic) IBOutlet UITextField *userNameTf;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)saveAddress_click:(id)sender;
- (IBAction)selectLocation_click:(id)sender;



- (IBAction)chooseStatusToDefault_click:(id)sender;

@end

@implementation CYEditorAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationInfo = [[NSMutableDictionary alloc] init];
    _saveBtn.layer.cornerRadius = 3.0f;
    //self.barStyle = NavBarStyleNoneMore;
   [self.view addSubview:self.locationView];
    if (_addressType == CYEditorAddressTypeEdit) {
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [self updateVIewData];
    }else{
        
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



- (void)updateVIewData
{
    _userNameTf.text = _shopModel.name;
    
    NSMutableString *phoneNum = [NSMutableString stringWithFormat:@"%@",_shopModel.mobile];
    [phoneNum replaceCharactersInRange:NSMakeRange(3,4) withString:@"****"];
    _phoneTf.text = phoneNum;
    phoneNumber = phoneNum;
    if (_shopModel.postcode.length) {
        _youzhengCode.text = _shopModel.postcode;
    }

    _addressTf.text = _shopModel.areaAddress;
    NSString *province = _shopModel.provinceName;
    NSString *city = _shopModel.cityName;
    NSString *area = _shopModel.areaName;
    
    
    NSString *locStr = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    [_areaBtn setTitle:locStr forState:UIControlStateNormal];
    if (_shopModel.isDefault) {
        _defaultBtn.selected = YES;
       
    }
    
}
-(void)openTheFMDB
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chayu" ofType:@"db"];
    fmdb = [FMDatabase databaseWithPath:filePath];
    [fmdb open];
}
-(NSString *)loadAddressData:(NSString *)parentid
{
    NSString *result = @"";
    NSString *querySql = [NSString stringWithFormat:@"select * from tea_area where areaid = %@",parentid];
    FMResultSet *set = [fmdb executeQuery:querySql];
    while ([set next]) {
        result = [set stringForColumn:@"name"];
    }
    
    return result;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [fmdb close];
    [self.locationView removeFromSuperview];
    self.locationView = nil;
}
- (CYLocationPickerView *)locationView
{
    if (!_locationView) {
        _locationView = [[[NSBundle mainBundle] loadNibNamed:@"CYLocationPickerView" owner:nil options:nil] firstObject];
        _locationView.frame = CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,256);
        _locationView.delegate = self;
    }
    return _locationView;
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
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveAddress_click:(id)sender {
    
    if ([_userNameTf.text length] == 0) {
        [Itost showMsg:@"收货人姓名不能为空！" inView:self.view];
        return;
    }
    if ([_phoneTf.text length] == 0) {
        [Itost showMsg:@"手机号码不能为空！" inView:self.view];
        return;
    }
    if (![phoneNumber isEqualToString:_phoneTf.text]) {
        if (![_phoneTf.text isValidMobileNumber]) {
            [Itost showMsg:@"请输入正确的手机号码！" inView:self.view];
            return;
        }
    }
    if ([_areaBtn.titleLabel.text length] == 0) {
        [Itost showMsg:@"请选择所在地区！" inView:self.view];
        return;
    }
    
    if ([_addressTf.text length] == 0) {
        [Itost showMsg:@"详细地址不能为空！" inView:self.view];
        return;
    }
    
//    if ([_youzhengCode.text length] == 0) {
//        [Itost showMsg:@"邮政编码不能为空！" inView:self.view];
//        return;
//    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (_addressType == CYEditorAddressTypeEdit) {
        [param setObject:_addressId forKey:@"addressId"];
    }
    
    [param setObject:_userNameTf.text forKey:@"name"];
    if ([phoneNumber isEqualToString:_phoneTf.text]) {
           [param setObject:_shopModel.mobile forKey:@"mobile"];
    }else{
        [param setObject:_phoneTf.text forKey:@"mobile"];
    }
    if (_locationInfo.count >0 &&(![[_locationInfo objectForJSONKey:@"provinceId"] isEqualToString:_shopModel.province] ||
        ![[_locationInfo objectForJSONKey:@"cityId"] isEqualToString:_shopModel.city] || ![[_locationInfo objectForJSONKey:@"areaId"] isEqualToString:_shopModel.areaid])) {
        [param setObject:[_locationInfo objectForJSONKey:@"provinceId"] forKey:@"province"];
        [param setObject:[_locationInfo objectForJSONKey:@"cityId"] forKey:@"city"];
        [param setObject:[_locationInfo objectForJSONKey:@"areaId"] forKey:@"areaid"];
    }else{
        [param setObject:_shopModel.province forKey:@"province"];
        [param setObject:_shopModel.city forKey:@"city"];
        [param setObject:_shopModel.areaid forKey:@"areaid"];
    }

    [param setObject:_addressTf.text forKey:@"address"];
    
    if (_youzhengCode.text.length != 0) {
         [param setObject:_youzhengCode.text forKey:@"postcode"];
    }
    
   
    if (_defaultBtn.selected) {
         [param setObject:@"1" forKey:@"isDefault"];
    }else{
         [param setObject:@"0" forKey:@"isDefault"];
    }
   
    __weak typeof(self) weakSelf = self;
    [CYWebClient basePost:@"AddAddress" parametes:param success:^(id responObj) {
        NSInteger state =[[responObj objectForKey:@"state"] integerValue];
        if (state == 400) {
            if (weakSelf.addessBack) {
                weakSelf.addessBack();
            }
            [weakSelf goback:nil];
        }
  
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
    [self goback:nil];
}

- (IBAction)selectLocation_click:(id)sender {
    [self showDataPickerView:YES];
}

- (IBAction)chooseStatusToDefault_click:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark -
#pragma mark UITextFieldDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(void)showDataPickerView:(BOOL)show
{
    [self.view endEditing:YES];
    CGFloat picker_top = 0.0f;
    if (show) {
        picker_top = SCREEN_HEIGHT - self.locationView.height;
    }else{
        picker_top = SCREEN_HEIGHT;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.locationView.y = picker_top;
    }];
}


#pragma mark -
#pragma mark CYLocationPickerViewDelegate method
- (void)confirmselectLocationInfo:(NSDictionary *)info
{
    [_locationInfo addEntriesFromDictionary:info];
    NSString *area = [NSString stringWithFormat:@"%@ %@ %@",[info objectForJSONKey:@"province"],[info objectForJSONKey:@"city"],[info objectForJSONKey:@"area"]];
    [_areaBtn setTitle:area forState:UIControlStateNormal];
    [self showDataPickerView:NO];
}

-(void)cancel
{
    [self showDataPickerView:NO];
}




@end
