//
//  CYSelectGiftViewController.m
//  TeaMall
//  确认礼品
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYSelectGiftViewController.h"
#import "CYGiftListViewController.h"
#import "CYGiftAddressCell.h"
#import "CYSelectGiftCell.h"
#import "CYSelectGiftSuccessViewController.h"
@interface CYSelectGiftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_addressArr;
    NSMutableArray *_giftArr;
    CYShippingAddressModel *selectModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)submit_click:(id)sender;

- (IBAction)confirmgift_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *tijiaoBtn;

@end

@implementation CYSelectGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addressArr = [[NSMutableArray alloc] init];
    _giftArr = [[NSMutableArray alloc] init];
    [_giftArr removeAllObjects];
    [_giftArr addObjectsFromArray:_selectArr];
    hiddenSepretor(self.tableView);
//    [self loadTableViewData];
//    //self.barStyle = NavBarStyleNoneMore;
  
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
        [_addressArr addObjectsFromArray:[CYShippingAddressModel objectArrayWithKeyValuesArray:responObj]];
        selectModel = _addressArr[0];
        [_tableView reloadData];
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
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
-(void)viewDidLayoutSubviews
{
    setSepretor(self.tableView);
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section ==0) {
//        NSInteger num = [_addressArr count]>1?1:[_addressArr count];
//        return num;
//    }else{
         return [_giftArr count];
//    }
   
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return 60.0;
//    }else{
        return 90.f;
//    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39,SCREEN_WIDTH,0.5)];
    line.backgroundColor = LINECOLOR;
    [headerView addSubview:line];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 15, 15)];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(25,0,80, 20)];
    lable.font = FONT(14.0f);
    lable.textColor = TITLECOLOR;
//    if (section==0) {
//        img.image = [UIImage imageNamed:@"icons_location"];
//        lable.text = @"收货信息";
//    }else{
        lable.text = @"礼品信息";
        img.image =[UIImage imageNamed:@"icon_gift"];
//    }
    [lable sizeToFit];
    [img sizeToFit];
    img.y = headerView.center.y - img.height/2;
    img.x = 10;
    [headerView addSubview:img];
    lable.x = img.x +img.width +5;
    lable.y = img.y;
    [headerView addSubview:lable];
    return headerView;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 10;
//    }else{
//      return 0.0000001;
//    }
//    
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return nil;
//    }else{
//        UIView *footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//        footerView.backgroundColor = CLEARCOLOR;
//        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//        topLine.backgroundColor = LINECOLOR;
//        [footerView addSubview:topLine];
//        
//        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 9,SCREEN_WIDTH, 0.5)];
//        bottomLine.backgroundColor = LINECOLOR;
//        [footerView addSubview:bottomLine];
//        return footerView;
//    }
//
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.section == 0) {
//        CYGiftAddressCell *cell = [CYGiftAddressCell cellWidthTableView:tableView];
//        cell.addAessInfo = _addressArr[indexPath.row];
//        return cell;
//    }else{
        CYSelectGiftCell *cell = [CYSelectGiftCell cellWidthTableView:tableView];
        CYGiftModel *model = [[_giftArr objectAtIndex:indexPath.row] objectForJSONKey:@"gift"];
        model.giftNum = [[_giftArr objectAtIndex:indexPath.row] objectForJSONKey:@"giftNum"];
        cell.model = model;
        return cell;
//    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        setCellSepretor();
//    }else{
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
        }
//    }
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        selectModel = [_addressArr objectAtIndex:indexPath.row];
//        for (int i =0; i<[_addressArr count]; i++) {
//            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
//             CYGiftAddressCell *cell = [tableView cellForRowAtIndexPath:index];
//            if (index.row == indexPath.row) {
//                cell.selectImg.highlighted = YES;
//                }else{
//                cell.selectImg.highlighted =NO;
//            }
//        }
//    }
}


- (IBAction)submit_click:(id)sender {

    if ([_giftArr count]==0) {
        [Itost showMsg:@"请选择礼品" inView:self.view];
        return;
    }
    NSMutableString *giftStr = [NSMutableString string];
    NSMutableString *numStr = [NSMutableString string];
    for (int i=0; i<[_giftArr count]; i++) {
        NSDictionary *info = _giftArr[i];
        CYGiftModel *model = [info objectForJSONKey:@"gift"];
        [giftStr appendFormat:@"%@,",model.giftId];
        [numStr appendFormat:@"%@,",info[@"giftNum"]];
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[giftStr substringToIndex:giftStr.length-1] forKey:@"giftId"];
    [param setObject:[numStr substringToIndex:numStr.length-1] forKey:@"number"];
//    [param setObject:selectModel.addressId forKey:@"addressId"];
    [param setObject:_orderSn forKey:@"orderSn"];
    _selectBtn.userInteractionEnabled = NO;
    [CYWebClient basePost:@"SaveGift" parametes:param success:^(id responObj) {
        NSInteger state  =[[responObj objectForKey:@"state"] integerValue];
        if (state == 400) {
            CYSelectGiftSuccessViewController *vc  = viewControllerInStoryBoard(@"CYSelectGiftSuccessViewController", @"TeaMall");
            vc.orderSign = _orderSn;
            [self.navigationController pushViewController:vc animated:YES];
        }
          _selectBtn.userInteractionEnabled = YES;
       
    } failure:^(id err) {
         _selectBtn.userInteractionEnabled = YES;
        
    }];
    
}

- (IBAction)confirmgift_click:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
