//
//  CYLingChaViewController.m
//  茶语
//
//  Created by Chayu on 16/6/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYLingChaViewController.h"
#import "CYShippingAddressModel.h"
#import "CYTeaAddressCell.h"
#import "CYChaLiCell.h"
#import "CYAddressListViewController.h"
#import "CYYaoQingMaCell.h"
#import "CYLingQuChengGongViewController.h"
#import "KeychainItemWrapper.h"
#import "RPUUID.h"
@interface CYLingChaViewController ()<UITextFieldDelegate,CYChaLiCellDelegate>
{
    NSDictionary *deliDef;//收货信息
    NSMutableArray *condata;//茶样信息
    NSMutableArray *numArr;
    NSMutableArray *sampleidArr;
    NSString *addressId;
    CYShippingAddressModel *shipingModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)queren_click:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *tAllTeanumLbl;




@end

@implementation CYLingChaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    condata = [NSMutableArray array];
    numArr = [NSMutableArray array];
    sampleidArr = [NSMutableArray array];
    [sampleidArr addObject:@""];
    [numArr addObject:@"1"];
    _tAllTeanumLbl.text = _maxnumber;
    
    [self loadAddressMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAddressMessage
{
    __weak typeof(self) weakSelf = self;
    [CYWebClient Post:@"Address" parametes:nil success:^(id responObj) {
        if ([responObj count]) {
            shipingModel = [CYShippingAddressModel objectWithKeyValues:responObj[0]];
            NSString *readAddress = [NSString stringWithFormat:@"%@%@%@%@",shipingModel.provinceName,shipingModel.cityName,shipingModel.areaName,shipingModel.areaAddress];
            addressId = shipingModel.addressId;
            deliDef = @{@"address":readAddress,@"name":shipingModel.name,@"mobile":shipingModel.mobile};
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

-(void)creatRightItems
{
    
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
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 1;
    }else{
        return 1;
    }
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }else{
            return 65;
        }
    }else if(indexPath.section == 1){
        return 132.;
    }else{
        return 100;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressTitle"];
            return cell;
        }else{
            CYTeaAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaAddressCell"];
            cell.addressInfo = deliDef;
            return cell;
        }
        
    }else if(indexPath.section == 1){
        CYChaLiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYChaLiCell"];
        cell.info = _info;
        NSString *imgUrl = [_info objectForKey:@"cltp"];
        if (imgUrl) {
            [cell.showimg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:SQUARE];
        }
        cell.titleLbl.text = [_info objectForKey:@"clbt"];
        cell.chaliNumLbl.text = [NSString stringWithFormat:@"（你目前共有%@份茶礼）",[_info objectForKey:@"maxNumber"]];
        cell.delegate = self;
        return cell;
    }else{
        CYYaoQingMaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYYaoQingMaCell"];
        cell.tYaoQingMaLbl.delegate = self;
        return cell;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section >0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = CLEARCOLOR;
        return view;
    }else{
        return nil;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section >0) {
       return 10;
    
    }else{
        return 0.00000001;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}


#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            
            CYAddressListViewController *vc = viewControllerInStoryBoard(@"CYAddressListViewController", @"My");
            vc.addressType = CYAddressTypeChoose;
            vc.back = ^(CYShippingAddressModel *model){
                
                NSString *readAddress = [NSString stringWithFormat:@"%@%@%@%@",model.provinceName,model.cityName,model.areaName,model.areaAddress];
                addressId = model.addressId;
                CYTeaAddressCell *cell = (CYTeaAddressCell *)[tableView cellForRowAtIndexPath:indexPath];
                deliDef = @{@"address":readAddress,@"name":model.name,@"mobile":model.mobile};
                cell.addressInfo = deliDef;
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark -
#pragma mark CYChaLiCellDelegate method
- (void)changeTeaSamNum:(CYChaLiCell *)cell andCoinNum:(NSInteger)num
{
    _tAllTeanumLbl.text = [NSString stringWithFormat:@"%d",(int)num];
}

- (IBAction)queren_click:(id)sender {

    
    if (!addressId.length) {
        [Itost showMsg:@"请选择收货地址" inView:self.view];
        return;
    }
    CYYaoQingMaCell *cell =(CYYaoQingMaCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (addressId.length) {
           [param setObject:addressId forKey:@"addressid"];
    }
    [param setObject:_tAllTeanumLbl.text forKey:@"number"];
    if (cell.tYaoQingMaLbl.text.length) {
        [param setObject:cell.tYaoQingMaLbl.text forKey:@"code"];
    }
    [param setObject:[RPUUID UUID] forKey:@"imei"];
    [SVProgressHUD showInfoWithStatus:@"正在提交"];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [CYWebClient basePost:@"youli_saveOrder" parametes:param success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state == 400) {
            [SVProgressHUD dismiss];
            CYLingQuChengGongViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYLingQuChengGongViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSString *msg = [responObj objectForKey:@"msg"];
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
    

}

#pragma mark -
#pragma mark UITextFieldDelegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
