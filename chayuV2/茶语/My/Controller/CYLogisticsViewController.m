//
//  CYLogisticsViewController.m
//  TeaMall
//
//  Created by Chayu on 16/1/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYLogisticsViewController.h"
#import "CYLogisticsTableViewCell.h"
#import "CYLogisticsHeaderView.h"
@interface CYLogisticsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CYLogisticsModel *model;
    NSMutableArray *dataArr;
}

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)CYLogisticsHeaderView *headerView;

- (IBAction)goback:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CYLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray array];
    //self.barStyle = NavBarStyleNoneMore;
    [self loadViewsData];
  
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


-(void)loadViewsData
{
     __weak typeof(self) weakSelf = self;
    NSString *hostUrl = @"2.0_freight.detail";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (!_ischayang) {
        hostUrl = @"checkLogistics";
         [params setObject:_orderSign forKey:@"orderSn"];
    }else{
        [params setObject:_orderSign forKey:@"parentid"];
        [params setObject:_freight_type forKey:@"type"];
    }
    [CYWebClient Post:hostUrl parametes:params success:^(id responObject) {
        model = [CYLogisticsModel objectWithKeyValues:responObject];
        if (!_ischayang) {
          [dataArr addObjectsFromArray:model.logisticsList];
        }else{
         [dataArr addObjectsFromArray:model.log];
        }
        
        weakSelf.headerView.height = 95;
        weakSelf.headerView.ischayang = weakSelf.ischayang;
        weakSelf.headerView.model = model;
        weakSelf.tableView.tableHeaderView = weakSelf.headerView;
        [weakSelf.tableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (CYLogisticsHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CYLogisticsHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,95);
    }
    return _headerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYLogisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYLogisticsTableViewCell"];
    if (indexPath.row == 0) {
        cell.isFirst = YES;
    }else{
        cell.isFirst = NO;
    }
    
    if (indexPath.row == [dataArr count]-1) {
        cell.isLast = YES;
    }else{
        cell.isLast = NO;
    }
    
    cell.info = dataArr[indexPath.row];
    
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,42)];
    
    UIView *lin = [[UIView alloc] initWithFrame:CGRectMake(10, 41, SCREEN_WIDTH-20, 1)];
    lin.backgroundColor = [UIColor getColorWithHexString:@"c9cacb"];
    [header addSubview:lin];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 50, 17)];
    lable.textColor = TITLECOLOR;
    lable.text = @"物流跟踪";
    [lable sizeToFit];
    lable.x = 10;
    lable.y = 12;
    [header addSubview:lable];
    
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
