//
//  CYAddressListViewController.m
//  TeaMall
//  地址列表
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYAddressListViewController.h"
#import "CYShippingAddressCell.h"
#import "CYAddressManagementCell.h"
#import "CYEditorAddressViewController.h"
@interface CYAddressListViewController ()<UITableViewDataSource,UITableViewDelegate,CYAddressManagementCellDelegate,UIAlertViewDelegate,CYShippingAddressCellDelegate>
{
    NSMutableArray *_dataArr;
    CYShippingAddressModel *selectModel;
    NSIndexPath *deleteIndex;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

- (IBAction)addNewAddress_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *emptyView;


@end

@implementation CYAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addressBtn.layer.cornerRadius = 3.0f;
    _dataArr = [[NSMutableArray alloc] init];
    [self loadTableViewData];
    //self.barStyle = NavBarStyleNoneMore;
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


- (void)loadTableViewData
{
        [CYWebClient Post:@"Address" parametes:nil success:^(id responObj) {
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray:[CYShippingAddressModel objectArrayWithKeyValuesArray:responObj]];
        if(_dataArr.count)
        {
            [_tableView reloadData];
            
            _emptyView.hidden = YES;
        }
        else
        {
            _emptyView.hidden = NO;
        }
            
        } failure:^(id err) {
            NSLog(@"%@",err);
        }];
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



#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_addressType == CYAddressTypeManager) {
        return 120.0f;
    }else{
       return 80.f;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CYShippingAddressModel *model = _dataArr[indexPath.row];
    if (_addressType == CYAddressTypeManager) {//编辑地址
        CYAddressManagementCell *cell = [CYAddressManagementCell cellWidthTableView:tableView];
        cell.delegate = self;
        cell.model = model;
        return cell;
    }else{ //选择地址
        CYShippingAddressCell *cell = [CYShippingAddressCell cellWidthTableView:tableView];
        cell.delegate = self;
        cell.model = model;
        return cell;
    }
   
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_addressType == CYAddressTypeChoose) {
        if (_back) {
            CYShippingAddressModel *model = _dataArr[indexPath.row];
            _back(model);
            [self goback:nil];
        }
       
    }
}

- (IBAction)addNewAddress_click:(id)sender {
    CYEditorAddressViewController *vc = viewControllerInStoryBoard(@"CYEditorAddressViewController", @"My");
    vc.addressType = CYEditorAddressTypeAdd;
     __weak typeof(self) weakSelf = self;
    vc.addessBack = ^(){
        [weakSelf loadTableViewData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark CYAddressManagementCellDelegate method
-(void)setAsDefaultCell:(CYAddressManagementCell *)cell andModel:(CYShippingAddressModel *)model
{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:model.addressId forKey:@"addressId"];
    [param setObject:model.name forKey:@"name"];
    [param setObject:model.mobile forKey:@"mobile"];
    [param setObject:model.province forKey:@"province"];
    [param setObject:model.city forKey:@"city"];
    [param setObject:model.areaid forKey:@"areaid"];
    [param setObject:model.areaAddress forKey:@"address"];
//    [param setObject:@"401000" forKey:@"postcode"];
    [param setObject:@"1" forKey:@"isDefault"];
    __weak typeof(self) weakSelf = self;
    [CYWebClient Post:@"AddAddress" parametes:param success:^(id responObj) {
 
        [weakSelf loadTableViewData];
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];

}

-(void)editorCell:(CYAddressManagementCell *)cell AndModel:(CYShippingAddressModel *)model
{
    CYEditorAddressViewController *vc = viewControllerInStoryBoard(@"CYEditorAddressViewController", @"My");
//    [self.storyboard instantiateViewControllerWithIdentifier:@"CYEditorAddressViewController"];
    vc.addressType = CYEditorAddressTypeEdit;
    vc.addressId = model.addressId;
    vc.shopModel = model;
    __weak typeof(self) weakSelf = self;
    vc.addessBack = ^(){
        [weakSelf loadTableViewData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    vc = nil;
}

-(void)deleteCell:(CYAddressManagementCell *)cell AndModel:(CYShippingAddressModel *)model
{
    selectModel = model;
    
    deleteIndex =[_tableView indexPathForCell:cell];
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要删除该地址吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alt show];
}

#pragma mark -
#pragma mark CYShippingAddressCellDelegate method
-(void)shipeditorCell:(CYShippingAddressCell *)cell AndModel:(CYShippingAddressModel *)model
{
    CYEditorAddressViewController *vc = viewControllerInStoryBoard(@"CYEditorAddressViewController", @"My");
//    [self.storyboard instantiateViewControllerWithIdentifier:@"CYEditorAddressViewController"];
    vc.addressType = CYEditorAddressTypeEdit;
    vc.addressId = model.addressId;
    vc.shopModel = model;
    __weak typeof(self) weakSelf = self;
    vc.addessBack = ^(){
        [weakSelf loadTableViewData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    vc = nil;
}

#pragma mark -
#pragma mark UIAlertViewDelegate method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1) {
        __weak typeof(self) weakSelf = self;
        [CYWebClient Post:@"deleteAddress" parametes:@{@"addressId":selectModel.addressId} success:^(id responObject) {
            [_dataArr removeObjectAtIndex:deleteIndex.row];
            [weakSelf.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:deleteIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        } failure:^(id error) {
            
        }];
    }
 
}
@end
