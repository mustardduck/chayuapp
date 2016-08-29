//
//  CYPersonalCenterViewController.m
//  TeaMall
//  个人中心
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYPersonalCenterViewController.h"
#import "CYAddressListViewController.h"
#import "CYChangePasswordController.h"
#import "CYModifyNickViewController.h"
#import "KSDatePicker.h"
#import "CYXuanZeDiQuController.h"
#import "CYBindingPhoneViewController.h"
@interface CYPersonalCenterViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate>
{
    NSDictionary *addressInfo;
    NSDictionary *userInfo;
    NSString *province;
    NSString *city;
    NSString *area;
    BOOL changeAddress;
}
- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nicknameTf;

@property (weak, nonatomic) IBOutlet UITextField *sexTf;
@property (weak, nonatomic) IBOutlet UITextField *addressTf;
@property (weak, nonatomic) IBOutlet UITextField *shengriTf;
@property (weak, nonatomic) IBOutlet UITextField *calTf;

- (IBAction)selectshengri_click:(id)sender;

- (IBAction)quxiao_click:(id)sender;

- (IBAction)selectSex_click:(id)sender;

- (IBAction)bangdingshouji_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *lijibangdingLbl;
- (IBAction)queding_click:(id)sender;

- (IBAction)selectquyu_click:(id)sender;


@end

@implementation CYPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectQuYu:) name:@"XUANZEQUYUNOTIFI" object:nil];
    changeAddress = NO;
    [self loadUserInfo];
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

-(void)selectQuYu:(NSNotification *)center
{
    changeAddress = YES;
    NSDictionary *info = center.object;
    NSLog(@"quyuInfo = %@",info);
    NSString *quyuStr = [NSString stringWithFormat:@"%@ %@ %@",[info objectForKey:@"shengName"],[info objectForKey:@"shiName"],[info objectForKey:@"quName"]];
    _addressTf.text = quyuStr;
    addressInfo = info;
}

-(void)loadUserMessage
{
    
    ChaYuer *manager = [ChaYuManager getCurrentUser];
      _nicknameTf.text = manager.nickname;
    if ([manager.sex integerValue] == 1) {
        _sexTf.text = @"男";
    }else{
        _sexTf.text = @"女";
    }
}


-(void)loadUserInfo
{
    [CYWebClient Post:@"user_info" parametes:nil success:^(id responObject) {
        userInfo = responObject;
        if (![userInfo isKindOfClass:[NSNull class]] && userInfo.count>0) {
            _nicknameTf.text =[userInfo objectForKey:@"nickname"];
            NSInteger sex = [[userInfo objectForJSONKey:@"sex"] integerValue];
            if (sex == 1) {
                _sexTf.text = @"男";
            }else{
                _sexTf.text = @"女";
            }
            _addressTf.text = [NSString stringWithFormat:@"%@ %@ %@",[userInfo objectForKey:@"province_str"],[userInfo objectForKey:@"city_str"],[userInfo objectForKey:@"area_str"]];
            _calTf.text = [userInfo objectForKey:@"mobile"];
            if (_calTf.text.length>0) {
                [_lijibangdingLbl setTitle:@"修改" forState:UIControlStateNormal];
            }
            province = [userInfo objectForJSONKey:@"province"];
            city = [userInfo objectForJSONKey:@"city"];
            area = [userInfo objectForJSONKey:@"area"];
            CGFloat birthday = [[userInfo objectForKey:@"birthday"] doubleValue];
            _shengriTf.text = [self dataWithSince:birthday];
        }
    } failure:^(id error) {
        
    }];
}


- (NSString *)dataWithSince:(NSTimeInterval )dataString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataString];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goback:(id)sender {
    

    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark UIActionSheetDelegate method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    self.view.frame = WINDOW.bounds;
    if (actionSheet.tag == 1600) {//选择性别
        if (buttonIndex !=2) {
            NSLog(@"buttonIndex = %d",(int)buttonIndex);
            if (buttonIndex == 0) {
                _sexTf.text = @"男";
            }else if (buttonIndex == 1){
                _sexTf.text = @"女";
            }
        
        }
    
    }else{
        if (buttonIndex == 0) {
            [self takePhoto];
        }else if (buttonIndex == 1){
            [self album];
        }
    }
}

#pragma mark 拍照
- (void)takePhoto {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.allowsEditing = YES;
    //媒体类型,默认情况下此数组包含kUTTypeImage，所以拍照时可以不用设置；但是当要录像的时候必须设置，可以设置为kUTTypeVideo（视频，但不带声音）或者kUTTypeMovie（视频并带有声音）
    //    imagePicker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie,(__bridge NSString *)kUTTypeImage];
    //视频最大录制时长(s)
    //    imagePicker.videoMaximumDuration = 15;
    [imagePicker topViewController].view.frame = CGRectMake(0, 0, 320, 300);
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark 从相册中选择
- (void)album {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    long long size = [SharedInstance fileSizeAtPath:[info objectForKey:UIImagePickerControllerMediaURL]];
    //    NSLog(@"size: %lld  chang:%@",size,[info objectForKey:@"_UIImagePickerControllerVideoEditingEnd"]);
    
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    _showImg.image = image;
//    [picker dismissViewControllerAnimated:YES completion:nil];
//
//    [CYWebClient Post:@"Usermodify" parametes:nil files:@{@"avatar":[NSArray arrayWithObject:image]} success:^(id responObject) {
//        ChaYuer *manager = MANAGER;
//        manager.avatar = [responObject objectForJSONKey:@"avatar"];
//        [ChaYuManager archiveCurrentUser:manager];
//        
//    } failure:^(id error) {
//        [SVProgressHUD showInfoWithStatus:@"请求失败"];
//    }];
    
}
#pragma mark -
#pragma mark UIAlertViewDelegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
}
- (IBAction)selectshengri_click:(id)sender {
    [self.view endEditing:YES];
    [_nicknameTf resignFirstResponder];
//    WINDOW.bounds = CGRectZero;
    //x,y 值无效，默认是居中的
    KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:WINDOW.bounds];
    picker.width = SCREEN_WIDTH - 40;
    picker.height = 300;
    
    //配置中心，详情见KSDatePikcerApperance
    
    picker.appearance.radius = 5;
    
    //设置回调
    picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
        if (buttonType == KSDatePickerButtonCommit) {
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            _shengriTf.text =[formatter stringFromDate:currentDate];
        }
    };
    // 显示
    [picker show];
}

- (IBAction)quxiao_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectSex_click:(id)sender {
    [self.view endEditing:YES];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
    sheet.tag = 1600;
    [sheet showInView:self.view];
}

- (IBAction)bangdingshouji_click:(id)sender {
    CYBindingPhoneViewController *vc = viewControllerInStoryBoard(@"CYBindingPhoneViewController", @"Log");
    if (_calTf.text.length) {
        vc.calnum = _calTf.text;
    }
    vc.backBlock = ^(NSString *phonenum){
        _calTf.text = phonenum;
        [_lijibangdingLbl setTitle:@"修改" forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)queding_click:(id)sender {
// Usermodify
    NSString *sexStr = [_sexTf.text isEqualToString:@"男"]?@"1":@"2";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_nicknameTf.text forKey:@"nickname"];
    [params setObject:sexStr forKey:@"sex"];
    [params setObject:_shengriTf.text forKey:@"birthday"];
    [params setObject:_nicknameTf.text forKey:@"nickname"];
    if (changeAddress) {
        if (addressInfo.count>0) {
            [params setObject:[addressInfo objectForKey:@"shengId"] forKey:@"province"];
            [params setObject:[addressInfo objectForKey:@"shiId"] forKey:@"city"];
            [params setObject:[addressInfo objectForKey:@"quId"] forKey:@"area"];
        }
    }else{
        if ( province.length>0) {
               [params setObject:province forKey:@"province"];
        }
        
        if (city.length >0) {
                    [params setObject:city forKey:@"city"];
        }
        
        if (area.length>0) {
            [params setObject:area forKey:@"area"];
        }

    }
  
  
    [CYWebClient basePost:@"Usermodify" parametes:params success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state == 400) {
            [self goback:nil];
        }
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

- (IBAction)selectquyu_click:(id)sender {
    CYXuanZeDiQuController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYXuanZeDiQuController"];
    vc.quyutype = CYQuYuTypeSheng;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
