//
//  CYBuyerEditVC.m
//  茶语
//
//  Created by Leen on 16/6/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerEditVC.h"
#import "PYMultiLabel.h"
#import "UILabel+Utilities.h"
#import "BaseImageView.h"
#import "UICommon.h"
#import "PlaceholderTextView.h"
#import "BaseButton.h"
#import "CYBuyerPDCategoryVC.h"
#import "UIColor+Additions.h"
#import "CYBuyerPDCategorySubVC.h"

@interface CYBuyerEditVC ()<UIGestureRecognizerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UITextField * _nameTXT;
    UITextField * _phoneTXT;
    UITextField * _weixinTXT;
    UIButton * _areaBtn;
    UITextField * _addressTXT;
    UIButton * _categoryBtn;
    UIButton * _productBtn;
    
    UIImage * _IDFrontImg;
    UIImage * _IDBackImg;
    BOOL _IDFrontImgUploaded;
    BOOL _IDBackImgUploaded;

    UIImage * _productFirstImg;
    UIImage * _productSecondImg;
    BOOL _productFirstImgUploaded;
    BOOL _productSecondImgUploaded;
    
    UIImage * _personalImg;
    BOOL _personalImgUploaded;
    
    NSInteger _currentImgTag;
    
    PlaceholderTextView * _introTextView;
    
    UIButton * _agreementSelectBtn;
    BaseButton * _okBtn;
    
    UITextField * _currentField;
    
    BOOL _isFail;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTable;

- (IBAction)goback:(id)sender;


@end

@implementation CYBuyerEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isFail = YES;
    
    if(_isFail)
    {
        self.mainTable.tableHeaderView = [self createBuyerFailHeaderView];
    }
    else
    {
        self.mainTable.tableHeaderView = [self createBuyerHeaderView];
    }
    
    _currentImgTag = 100;
    
}

- (UIView *)createBuyerFailHeaderView
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headerView.backgroundColor = [UIColor pinkBGColor];
    
    PYMultiLabel * headerLbl = [[PYMultiLabel  alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
    headerLbl.backgroundColor = [UIColor clearColor];
    headerLbl.textAlignment = NSTextAlignmentCenter;
    headerLbl.text = @"抱歉，由于信息有误，您的申请未能审核通过。\n您可以修改之后重新提交申请。";
    headerLbl.textColor = [UIColor redTitleColor];
    headerLbl.numberOfLines = 2;
    headerLbl.font = FONT(14);
    [headerView addSubview:headerLbl];
    
    return headerView;
    
}

- (UIView *)createBuyerHeaderView
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 67)];
    headerView.backgroundColor = RGB(237, 238, 239);
    
    PYMultiLabel * headerLbl = [[PYMultiLabel  alloc] initWithFrame:CGRectMake(20, 0, headerView.width - 40, headerView.height)];
    headerLbl.backgroundColor = [UIColor clearColor];
    headerLbl.text = @"抱歉，你暂时还未售卖的权限，如果需要请联系您的联系方式，我们的工作人员稍后会与您联系。\n以下带*选项为必填项。";
    headerLbl.textColor = RGB(161, 162, 163);
    [headerLbl setFontColor:[UIColor redColor] string:@"*"];
    headerLbl.numberOfLines = 3;
    headerLbl.font = FONT(14);
    [headerView addSubview:headerLbl];
    
    return headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    _currentField = textField;
}

- (void)frontIDImgTapped
{
    _currentImgTag = 100;
    
    [self showActionsheet];
}

- (void)backIDImgTapped
{
    _currentImgTag = 101;
    
    [self showActionsheet];
}

- (void)productFirstImgTapped
{
    _currentImgTag = 102;
    
    [self showActionsheet];
}

- (void)productSecondImgTapped
{
    _currentImgTag = 103;
    
    [self showActionsheet];
}

- (void)personalImgTapped
{
    _currentImgTag = 104;
    
    [self showActionsheet];
}

- (void) showActionsheet
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"我的相册", nil];
    [sheet showInView:self.view];
    
}

- (void) touchUpInsideOn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    if(btn.tag == 1)//区域
    {
        
    }
    else if (btn.tag == 2)//主营类别
    {
        CYBuyerPDCategoryVC *tdc = viewControllerInStoryBoard(@"CYBuyerPDCategoryVC", @"Buyer");
        
        [self.navigationController pushViewController:tdc animated:YES];
    }
    else if (btn.tag == 3)//主营商品
    {
        CYBuyerPDCategorySubVC *tdc = viewControllerInStoryBoard(@"CYBuyerPDCategorySubVC", @"Buyer");
        
        [self.navigationController pushViewController:tdc animated:YES];

    }
    
}

- (void)selectBtnClicked:(id)sender
{
    ((UIButton *)sender).selected = !((UIButton *)sender).selected;
}

- (void)agreementBtnClicked
{
    
}

- (void)okBtnClicked
{
    if([self checkField])
    {
        
    }
}

- (BOOL) checkField
{
    if(!_nameTXT.text.length)
    {
        [Itost showMsg:@"请填写姓名" inView:self.view];
        
        [_nameTXT becomeFirstResponder];
        
        return NO;
    }
    else if ([UICommon isBlankString:_nameTXT.text])
    {
        [Itost showMsg:@"姓名不能为空格" inView:self.view];
        [_nameTXT becomeFirstResponder];
        
        return NO;
    }
    else if (!_phoneTXT.text.length)
    {
        [Itost showMsg:@"请填写手机号码" inView:self.view];
        [_phoneTXT becomeFirstResponder];
        
        return NO;
    }
    else if ([_areaBtn.titleLabel.text isEqualToString:@"请选择所在区域"])
    {
        [Itost showMsg:@"请选择所在区域" inView:self.view];
        return NO;
    }
    else if (!_addressTXT.text.length)
    {
        [Itost showMsg:@"请填写详细地址" inView:self.view];
        [_addressTXT becomeFirstResponder];
        
        return NO;
    }
    else if ([_categoryBtn.titleLabel.text isEqualToString:@"请选择主营类别"])
    {
        [Itost showMsg:@"请选择主营类别" inView:self.view];
        return NO;
    }
    else if ([_productBtn.titleLabel.text isEqualToString:@"请选择主营商品"])
    {
        [Itost showMsg:@"请选择主营商品" inView:self.view];
        return NO;
    }
    else if (!_IDFrontImgUploaded)
    {
        [Itost showMsg:@"请上传身份证正面" inView:self.view];
        return NO;
    }
    else if (!_IDBackImgUploaded)
    {
        [Itost showMsg:@"请上传身份证反面" inView:self.view];
        return NO;
    }
    else if (!_productFirstImgUploaded || !_productSecondImgUploaded)
    {
        [Itost showMsg:@"请上传2张商品图片" inView:self.view];
        return NO;
    }
    else if (!_personalImgUploaded)
    {
        [Itost showMsg:@"请上传形象照片" inView:self.view];
        return NO;
    }
    else if (!_introTextView.text.length)
    {
        [Itost showMsg:@"请填写个人简介" inView:self.view];
        return NO;
    }
    else if (!_agreementSelectBtn.selected)
    {
        [Itost showMsg:@"请阅读并勾选服务协议" inView:self.view];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark UIActionSheetDelegate method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [UICommon showTakePhoto:self view:self allowsEditing:NO];
    }else if (buttonIndex == 1){
        [UICommon showAlbum:self view:self];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if(_currentImgTag == 100)
    {
        _IDFrontImg = image;
        
        _IDFrontImgUploaded = YES;
    }
    else if (_currentImgTag == 101)
    {
        _IDBackImg = image;
        
        _IDBackImgUploaded = YES;
    }
    else if (_currentImgTag == 102)
    {
        _productFirstImg = image;
        
        _productFirstImgUploaded = YES;
    }
    else if (_currentImgTag == 103)
    {
        _productSecondImg = image;
        
        _productSecondImgUploaded = YES;
    }
    else if (_currentImgTag == 104)
    {
        _personalImg = image;
        
        _personalImgUploaded = YES;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.mainTable reloadData];
    
    
//    [CYWebClient Post:@"Usermodify" parametes:nil files:@{@"avatar":[NSArray arrayWithObject:image]} success:^(id responObject) {
//        ChaYuer *manager = MANAGER;
//        manager.avatar = [responObject objectForJSONKey:@"avatar"];
//        [ChaYuManager archiveCurrentUser:manager];
//        
//    } failure:^(id error) {
//        [SVProgressHUD showInfoWithStatus:@"请求失败"];
//    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [_currentField resignFirstResponder];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor grayBackgroundColor];
    
    UIView * subView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
    subView.backgroundColor = RGB(245, 245, 245);

    [view addSubview:subView];
    
    UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, subView.height)];
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.font = FONT(16);
    titleLbl.textColor = [UIColor blackColor];
    [subView addSubview:titleLbl];
    
    if(section == 0)
    {
        titleLbl.text = @"个人基本信息";
    }
    else
    {
        titleLbl.text = @"个人简介";

    }
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, view.height - 0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor grayTitleOrLineColor];
    [view addSubview:line];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 9;
    }
    else if (section == 1)
    {
        return 3;
    }
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"editCell"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"editCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    if(indexPath.section == 0)
    {
        NSString * nameStr = @"";
        switch (indexPath.row) {
            case 0:
            {
                nameStr = @" 姓名: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
                [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);
                
                [cell.contentView addSubview:nameLbl];
                
                _nameTXT = [[UITextField alloc] initWithFrame:CGRectMake(nameLbl.x + nameLbl.width, 0, SCREEN_WIDTH - 15 - nameLbl.x - nameLbl.width, 50)];
                _nameTXT.backgroundColor = [UIColor clearColor];
                _nameTXT.placeholder = @"请输入姓名";
                _nameTXT.clearButtonMode = UITextFieldViewModeWhileEditing;
                _nameTXT.font = FONT(14);
                _nameTXT.textColor = [UIColor blackColor];
                _nameTXT.delegate = self;
                [cell.contentView addSubview:_nameTXT];
                
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 49.5, SCREEN_WIDTH - 20, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                [cell.contentView addSubview:line];
                
                cell.height = 50;
                
                break;

            }
            case 1:
            {
                nameStr = @" 手机: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
                [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);

                [cell.contentView addSubview:nameLbl];
                
                _phoneTXT = [[UITextField alloc] initWithFrame:CGRectMake(nameLbl.x + nameLbl.width, 0, SCREEN_WIDTH - 15 - nameLbl.x - nameLbl.width, 50)];
                _phoneTXT.backgroundColor = [UIColor clearColor];
                _phoneTXT.placeholder = @"请输入手机号码";
                _phoneTXT.clearButtonMode = UITextFieldViewModeWhileEditing;
                _phoneTXT.font = FONT(14);
                _phoneTXT.textColor = [UIColor blackColor];
                _phoneTXT.keyboardType = UIKeyboardTypePhonePad;
                _phoneTXT.delegate = self;

                [cell.contentView addSubview:_phoneTXT];
                
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 49.5, SCREEN_WIDTH - 20, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                [cell.contentView addSubview:line];
                
                cell.height = 50;
                
                break;
                
            }
            case 2:
            {
                nameStr = @"微信号: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = nameStr;
  
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);

                [cell.contentView addSubview:nameLbl];
                
                _weixinTXT = [[UITextField alloc] initWithFrame:CGRectMake(nameLbl.x + nameLbl.width, 0, SCREEN_WIDTH - 15 - nameLbl.x - nameLbl.width, 50)];
                _weixinTXT.backgroundColor = [UIColor clearColor];
                _weixinTXT.clearButtonMode = UITextFieldViewModeWhileEditing;
                _weixinTXT.font = FONT(14);
                _weixinTXT.textColor = [UIColor blackColor];
                _weixinTXT.delegate = self;

                [cell.contentView addSubview:_weixinTXT];
                
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 49.5, SCREEN_WIDTH - 20, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                [cell.contentView addSubview:line];
                
                cell.height = 50;
                
                break;
                
            }
            case 3:
            {
                nameStr = @" 所在区域: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
                [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);

                [cell.contentView addSubview:nameLbl];
                
                
                _areaBtn= [[UIButton alloc] initWithFrame:CGRectMake(nameLbl.x + nameLbl.width, 0, SCREEN_WIDTH - 15 - nameLbl.x - nameLbl.width, 50)];
                _areaBtn.backgroundColor = [UIColor clearColor];
                _areaBtn.titleLabel.font = FONT(14);
                [_areaBtn setTitle:@"请选择所在区域" forState:UIControlStateNormal];
                [_areaBtn setTitleColor:RGB(161, 162, 163) forState:UIControlStateNormal];
                
                _areaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                _areaBtn.tag = 1;
                [_areaBtn addTarget:self action:@selector(touchUpInsideOn:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:_areaBtn];
                
                UIImageView * arrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 28, 17, 8, 16)];
                arrowIcon.image = [UIImage imageNamed:@"rightArrowIcon"];
                [cell.contentView addSubview:arrowIcon];
                
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 49.5, SCREEN_WIDTH - 20, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                [cell.contentView addSubview:line];
                
                cell.height = 50;
                
                break;
                
            }
            case 4:
            {
                nameStr = @" 详细地址: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
                [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);

                [cell.contentView addSubview:nameLbl];
                
                _addressTXT = [[UITextField alloc] initWithFrame:CGRectMake(nameLbl.x + nameLbl.width, 0, SCREEN_WIDTH - 15 - nameLbl.x - nameLbl.width, 50)];
                _addressTXT.backgroundColor = [UIColor clearColor];
                _addressTXT.placeholder = @"请输入详细地址";
                _addressTXT.clearButtonMode = UITextFieldViewModeWhileEditing;
                _addressTXT.font = FONT(14);
                _addressTXT.textColor = [UIColor blackColor];
                _addressTXT.delegate = self;

                [cell.contentView addSubview:_addressTXT];
                
                BOOL fail = YES;
                
                if(fail)
                {
                    UIView * failView = [[UIView alloc] initWithFrame:CGRectMake(20, 42, SCREEN_WIDTH - 40, 25)];
                    failView.backgroundColor = [UIColor pinkBGColor];
                    
                    [cell.contentView addSubview:failView];
                    
                    UIImageView * failIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 14, 14)];
                    failIcon.image = [UIImage imageNamed:@"failIcon"];
                    [failView addSubview:failIcon];
                    
                    UILabel * failLbl = [[UILabel alloc] initWithFrame:CGRectMake(failIcon.x + failIcon.width + 5, 0, failView.width - failIcon.x - failIcon.width - 10, failView.height)];
                    failLbl.backgroundColor = [UIColor clearColor];
                    failLbl.font = FONT(12);
                    failLbl.textColor = [UIColor redTitleColor];
                    failLbl.text = @"请填写详细的地址";
                    
                    [failView addSubview:failLbl];
                    
                    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, failView.y + failView.height + 14 - 0.5, SCREEN_WIDTH - 20, 0.5)];
                    line.backgroundColor = [UIColor grayTitleOrLineColor];
                    [cell.contentView addSubview:line];
                    
                    cell.height = failView.y + failView.height + 14;
                }
                else
                {
                    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 49.5, SCREEN_WIDTH - 20, 0.5)];
                    line.backgroundColor = [UIColor grayTitleOrLineColor];
                    [cell.contentView addSubview:line];
                    
                    cell.height = 50;
                }

                
                break;
                
            }
            case 5:
            {
                nameStr = @" 主营类别: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
                [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);

                [cell.contentView addSubview:nameLbl];
                
                
                _categoryBtn= [[UIButton alloc] initWithFrame:CGRectMake(nameLbl.x + nameLbl.width, 0, SCREEN_WIDTH - 15 - nameLbl.x - nameLbl.width, 50)];
                _categoryBtn.backgroundColor = [UIColor clearColor];
                _categoryBtn.titleLabel.font = FONT(14);
                [_categoryBtn setTitle:@"请选择主营类别" forState:UIControlStateNormal];
                [_categoryBtn setTitleColor:RGB(161, 162, 163) forState:UIControlStateNormal];
                
                _categoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                _categoryBtn.tag = 2;
                [_categoryBtn addTarget:self action:@selector(touchUpInsideOn:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:_categoryBtn];
                
                UIImageView * arrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 28, 17, 8, 16)];
                arrowIcon.image = [UIImage imageNamed:@"rightArrowIcon"];
                [cell.contentView addSubview:arrowIcon];
                
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 49.5, SCREEN_WIDTH - 20, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                [cell.contentView addSubview:line];
                
                cell.height = 50;
                
                break;
                
            }
            case 6:
            {
                nameStr = @" 主营商品: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
                [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);

                [cell.contentView addSubview:nameLbl];
                
                
                _productBtn= [[UIButton alloc] initWithFrame:CGRectMake(nameLbl.x + nameLbl.width, 0, SCREEN_WIDTH - 15 - nameLbl.x - nameLbl.width, 50)];
                _productBtn.backgroundColor = [UIColor clearColor];
                _productBtn.titleLabel.font = FONT(14);
                [_productBtn setTitle:@"最多填 5 项" forState:UIControlStateNormal];
                [_productBtn setTitleColor:RGB(161, 162, 163) forState:UIControlStateNormal];
                
                _productBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                _productBtn.tag = 3;
                [_productBtn addTarget:self action:@selector(touchUpInsideOn:) forControlEvents:UIControlEventTouchUpInside];

                [cell.contentView addSubview:_productBtn];
                
                UIImageView * arrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 28, 17, 8, 16)];
                arrowIcon.image = [UIImage imageNamed:@"rightArrowIcon"];
                [cell.contentView addSubview:arrowIcon];
                
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 49.5, SCREEN_WIDTH - 20, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                [cell.contentView addSubview:line];
                
                cell.height = 50;
                
                break;
                
            }
            case 7:
            {
                nameStr = @" 身份证正反面照片: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
                [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);
                
                [cell.contentView addSubview:nameLbl];
                
                BaseImageView * imgView = [[BaseImageView alloc] initWithFrame:CGRectMake(( SCREEN_WIDTH - 259) / 2, nameLbl.height - 5, 122, 77)];
                imgView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontIDImgTapped)];
                [imgView addGestureRecognizer:singleTap];
                
                [imgView setBorderWidth:0.5];
                [imgView setBorderColor:[UIColor grayTitleOrLineColor]];
                imgView.backgroundColor = RGB(248, 249, 250);
                [cell.contentView addSubview:imgView];
                
                
                BaseImageView * imgView2 = [[BaseImageView alloc] initWithFrame:CGRectMake(imgView.x + imgView.width + 15 , imgView.y, 122, 77)];
                imgView2.userInteractionEnabled = YES;
                singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backIDImgTapped)];
                [imgView2 addGestureRecognizer:singleTap];
                
                [imgView2 setBorderWidth:0.5];
                [imgView2 setBorderColor:[UIColor grayTitleOrLineColor]];
                imgView2.backgroundColor = RGB(248, 249, 250);
                [cell.contentView addSubview:imgView2];
                
                
                if(!_IDFrontImgUploaded)
                {
                    UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imgView.width, imgView.height)];
                    titleLbl.backgroundColor = [UIColor clearColor];
                    titleLbl.textAlignment = NSTextAlignmentCenter;
                    titleLbl.font = FONT(14);
                    titleLbl.textColor = [UIColor grayTitleOrLineColor];
                    titleLbl.text = @"上传正面";
                    [imgView addSubview:titleLbl];
                }
                else
                {
                    imgView.image = _IDFrontImg;
                }
                
                if(!_IDBackImgUploaded)
                {
                    UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imgView2.width, imgView2.height)];
                    titleLbl.backgroundColor = [UIColor clearColor];
                    titleLbl.textAlignment = NSTextAlignmentCenter;
                    titleLbl.font = FONT(14);
                    titleLbl.textColor = [UIColor grayDarkTitleColor];
                    titleLbl.text = @"上传背面";
                    [imgView2 addSubview:titleLbl];
                }
                else
                {
                    imgView2.image = _IDBackImg;
                }
                
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 139.5, SCREEN_WIDTH - 20, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                [cell.contentView addSubview:line];
                
                cell.height = 140;
                
                break;
                
            }
            case 8:
            {
                nameStr = @" 请上传两张具有代表性的商品图片: ";
                PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
                nameLbl.backgroundColor = [UIColor clearColor];
                nameLbl.textColor = [UIColor blackColor];
                nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
                [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
                nameLbl.width = nameLbl.boundingRectWithWidth;
                nameLbl.font = FONT(14);
                
                [cell.contentView addSubview:nameLbl];
                
                BaseImageView * imgView = [[BaseImageView alloc] initWithFrame:CGRectMake(( SCREEN_WIDTH - 175) / 2, nameLbl.height - 5, 80, 80)];
                imgView.userInteractionEnabled = YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(productFirstImgTapped)];
                [imgView addGestureRecognizer:singleTap];
                
                [imgView setBorderWidth:0.5];
                [imgView setBorderColor:[UIColor grayTitleOrLineColor]];
                imgView.backgroundColor = RGB(248, 249, 250);
                [cell.contentView addSubview:imgView];
                
                
                BaseImageView * imgView2 = [[BaseImageView alloc] initWithFrame:CGRectMake(imgView.x + imgView.width + 15 , imgView.y, 80, 80)];
                imgView2.userInteractionEnabled = YES;
                singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(productSecondImgTapped)];
                [imgView2 addGestureRecognizer:singleTap];
                
                [imgView2 setBorderWidth:0.5];
                [imgView2 setBorderColor:[UIColor grayTitleOrLineColor]];
                imgView2.backgroundColor = RGB(248, 249, 250);
                [cell.contentView addSubview:imgView2];
                
                
                if(!_productFirstImgUploaded)
                {
                    UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imgView.width, imgView.height)];
                    titleLbl.backgroundColor = [UIColor clearColor];
                    titleLbl.textAlignment = NSTextAlignmentCenter;
                    titleLbl.font = FONT(14);
                    titleLbl.textColor = [UIColor grayDarkTitleColor];
                    titleLbl.text = @"上传图片";
                    [imgView addSubview:titleLbl];
                }
                else
                {
                    imgView.image = _productFirstImg;
                }
                
                if(!_productSecondImgUploaded)
                {
                    UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imgView2.width, imgView2.height)];
                    titleLbl.backgroundColor = [UIColor clearColor];
                    titleLbl.textAlignment = NSTextAlignmentCenter;
                    titleLbl.font = FONT(14);
                    titleLbl.textColor = [UIColor grayDarkTitleColor];
                    titleLbl.text = @"上传图片";
                    [imgView2 addSubview:titleLbl];
                }
                else
                {
                    imgView2.image = _productSecondImg;
                }
                
                cell.height = 140;

                break;
                
            }
        }

    }
    else
    {
        NSString * nameStr = @"";

        if(indexPath.row == 0)
        {
            nameStr = @" 请上传形象照片: ";
            PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
            nameLbl.backgroundColor = [UIColor clearColor];
            nameLbl.textColor = [UIColor blackColor];
            nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
            [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
            nameLbl.width = nameLbl.boundingRectWithWidth;
            nameLbl.font = FONT(14);
            
            [cell.contentView addSubview:nameLbl];
            
            
            UILabel * desLbl = [[UILabel alloc] initWithFrame:CGRectMake(18, 36, SCREEN_WIDTH - 40, 14)];
            desLbl.backgroundColor = [UIColor clearColor];
            desLbl.textColor = [UIColor grayDarkTitleColor];
            desLbl.text = @"（请上传 3:2 的比例，大小控制在 2MB 以内)";
            desLbl.font = FONT(12);
            
            [cell.contentView addSubview:desLbl];
            
            CGFloat imgWidth = (SCREEN_WIDTH - 60 - 15) / 2;
            CGFloat imgHeight = imgWidth * 2 / 3;
            
            BaseImageView * imgView = [[BaseImageView alloc] initWithFrame:CGRectMake(30, desLbl.y + desLbl.height + 15, imgWidth, imgHeight)];
            imgView.image = [UIImage imageNamed:@"sampleImg"];
            
            [cell.contentView addSubview:imgView];
            
            
            BaseImageView * imgView2 = [[BaseImageView alloc] initWithFrame:CGRectMake(imgView.x + imgView.width + 15 , imgView.y, imgWidth, imgHeight)];
            imgView2.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalImgTapped)];
            [imgView2 addGestureRecognizer:singleTap];
            

            imgView2.backgroundColor = [UIColor grayDarkBackgroundColor];
            [cell.contentView addSubview:imgView2];
            
            UIImageView * icon = [[UIImageView alloc] initWithFrame: CGRectMake(imgWidth / 2 - 24, imgHeight * 22 / 100, 48, 37)];
            icon.image = [UIImage imageNamed:@"addPhotoBtn"];
            [imgView2 addSubview:icon];
            
//            UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imgView.width, imgView.height)];
//            titleLbl.backgroundColor = [UIColor clearColor];
//            titleLbl.textAlignment = NSTextAlignmentCenter;
//            titleLbl.font = FONT(18);
//            titleLbl.textColor = [UIColor whiteColor];
//            titleLbl.text = @"示例图片";
//            [imgView addSubview:titleLbl];
            
            if(!_personalImgUploaded)
            {
                UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, icon.y + icon.height + 5, imgView.width, 16)];
                titleLbl.backgroundColor = [UIColor clearColor];
                titleLbl.textAlignment = NSTextAlignmentCenter;
                titleLbl.font = FONT(14);
                titleLbl.textColor = [UIColor grayDarkTitleColor];
                titleLbl.text = @"点击上传";
                [imgView2 addSubview:titleLbl];
            }
            else
            {
                imgView2.image = _personalImg;
            }
            
            cell.height = 80 + imgHeight;
            
        }
        else if (indexPath.row == 1)
        {
            nameStr = @" 个人简介: ";
            PYMultiLabel * nameLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
            nameLbl.backgroundColor = [UIColor clearColor];
            nameLbl.textColor = [UIColor blackColor];
            nameLbl.text = [NSString stringWithFormat:@"*%@", nameStr];
            [nameLbl setFontColor:[UIColor redColor] range:NSMakeRange(0, 1)];
            nameLbl.width = nameLbl.boundingRectWithWidth;
            nameLbl.font = FONT(14);
            
            [cell.contentView addSubview:nameLbl];

            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = [UIColor grayTitleOrLineColor];
            [cell.contentView addSubview:line];
            
            _introTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(20, 14 + 50, SCREEN_WIDTH - 40, 110)];
            _introTextView.placeholder = @"请简要的介绍下自己，让别人对您有所了解。";
            _introTextView.placeholderColor = [UIColor grayDarkTitleColor];
            _introTextView.placeholderFont = FONT(14);
            _introTextView.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:_introTextView];
            
            line = [[UIView alloc]initWithFrame:CGRectMake(20, _introTextView.y + _introTextView.height - 0.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = [UIColor grayTitleOrLineColor];
            [cell.contentView addSubview:line];
            
            cell.height = line.y + 0.5;
        }
        else if (indexPath.row == 2)
        {
            PYMultiLabel * agreeLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(41, 0, 270, 45)];
            agreeLbl.backgroundColor = [UIColor clearColor];
            agreeLbl.text = @"已阅读并同意“茶语网茗星私享服务协议”";
            agreeLbl.textColor = [UIColor grayDarkTitleColor];
            [agreeLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(7, 11)];
            agreeLbl.font = FONT(14);
            [cell.contentView addSubview:agreeLbl];
            
            UIButton * agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH - 120, 45)];
            agreeBtn.backgroundColor = [UIColor clearColor];
            [agreeBtn addTarget:self action:@selector(agreementBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:agreeBtn];
            
            _agreementSelectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
            [_agreementSelectBtn setImage:[UIImage imageNamed:@"icon_correct_empty"] forState:UIControlStateNormal];
            [_agreementSelectBtn setImage:[UIImage imageNamed:@"icon_correct"] forState:UIControlStateSelected];
            [_agreementSelectBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [_agreementSelectBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
            [_agreementSelectBtn addTarget:self action:@selector(selectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            _agreementSelectBtn.backgroundColor = [UIColor clearColor];
            
            [cell.contentView addSubview:_agreementSelectBtn];
            
            
            _okBtn = [[BaseButton alloc] initWithFrame:CGRectMake(20, 60, SCREEN_WIDTH - 40, 45)];
            _okBtn.backgroundColor = [UIColor brownTitleColor];
            [_okBtn setTitle:@"确认提交" forState:UIControlStateNormal];
            [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _okBtn.titleLabel.font = FONT(14);
            [_okBtn setCornerRadius:3.3];
            
            [_okBtn addTarget:self action:@selector(okBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_okBtn];
            
            cell.height = _okBtn.y + _okBtn.height + 15;

        }
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat he = ((UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath]).height;
    
    return he;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (IBAction)goback:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
