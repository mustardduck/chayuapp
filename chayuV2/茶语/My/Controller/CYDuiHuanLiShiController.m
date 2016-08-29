//
//  CYDuiHuanLiShiController.m
//  茶语
//
//  Created by Chayu on 16/7/18.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYDuiHuanLiShiController.h"
#import "CYDuiHuanLiShiCell.h"
#import "CYWriteCommentViewController.h"
#import "CYTeaSampleDetailViewController.h"
#import "CYLogisticsViewController.h"
@interface CYDuiHuanLiShiController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    
    NSInteger status; //状态
    NSMutableArray *dataArr;
    UIButton *selectBtn;
}

- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *linView;

- (IBAction)topmenu_click:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lin_leading_cons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *topBg;

@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *emptyMsgLbl;

@end

@implementation CYDuiHuanLiShiController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换历史";
    page = 1;
    status = -1;
    dataArr = [NSMutableArray array];
    hiddenSepretor(_tableView);
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadTableViewData:(BOOL)hasMore{
    //    MyTeaSample
    if (hasMore) {
        page ++;
    }else{
        page =1 ;
    }
    
    NSDictionary *params = nil;
    if (status != -1) {
        params = @{@"p":@(page),@"pageSize":@"10",@"status":@(status)};
    }else{
        params = @{@"p":@(page),@"pageSize":@"10"};
    }
    
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"MyTeaSample" parametes:params success:^(id responObj) {
        if (hasMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
            [dataArr removeAllObjects];
            [weakSelf.tableView reloadData];
        }
        NSArray *arr = [responObj objectForJSONKey:@"items"];
        if ([arr count]<10) {
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
        
        [dataArr addObjectsFromArray:arr];
        
        if(dataArr.count)
        {
            [weakSelf.tableView reloadData];
            weakSelf.emptyView.hidden = YES;
        }
        else
        {
            weakSelf.emptyView.hidden = NO;
        }
        
        if (dataArr.count<10) {
            weakSelf.tableView.footer = nil;
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
        
        
    } failure:^(id err) {
        if (hasMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
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


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = MAIN_BGCOLOR;
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYDuiHuanLiShiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYDuiHuanLiShiCell"];
    NSDictionary *info = dataArr[indexPath.section];
    
    NSString *thumb =[info objectForJSONKey:@"thumb"];
    if (thumb.length) {
        [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
    }
    cell.titleLbl.text = [NSString stringWithFormat:@"[%@]%@",[info objectForKey:@"brand"],[info objectForKey:@"title"]];
    cell.cahbiNumLbl.text = [info objectForJSONKey:@"price"];
    cell.fenLbl.text = [NSString stringWithFormat:@"%@份",[info objectForKey:@"num"]];
    cell.timeLbl.text = [info objectForKey:@"created"];
    NSInteger statu = [[info objectForJSONKey:@"status"] integerValue];
    NSString *status_name = [info objectForJSONKey:@"status_name"];
    cell.stabtusLbl.text = status_name;
    cell.wuliuBtn.hidden = YES;
    cell.pingchaBtn.tag = 8000 +indexPath.section;
    [cell.pingchaBtn addTarget:self action:@selector(pingcha_click:) forControlEvents:UIControlEventTouchUpInside];
    switch (statu) {
        case 1:
        {
            cell.wuliuBtn.hidden = NO;
            cell.wuliuBtn.tag = 65000+indexPath.section;
            [cell.wuliuBtn addTarget:self action:@selector(wuliu_click:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 0:
        {
            
            break;
        }
        case 3:
        {
            
            break;
        }
        default:
            break;
    }
    return cell;
}

- (NSString *)dataWithSince:(NSTimeInterval )dataString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataString];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

-(void)wuliu_click:(UIButton *)sender{
    NSInteger selectIndex = sender.tag - 65000;
    NSDictionary *info = dataArr[selectIndex];
    CYLogisticsViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CYLogisticsViewController"];
    vc.orderSign = [[info objectForKey:@"id"] description];
    vc.ischayang = YES;
    vc.freight_type = [[info objectForKey:@"freight_type"] description];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pingcha_click:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag - 8000;
    CYWriteCommentViewController *vc = viewControllerInStoryBoard(@"CYWriteCommentViewController", @"Eva");
    NSDictionary *info = dataArr[selectIndex];
    vc.mItemid  = [info objectForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
    //    CYLogisticsTableViewCell
}


#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = dataArr[indexPath.row];
    CYTeaSampleDetailViewController *vc =viewControllerInStoryBoard(@"CYTeaSampleDetailViewController", @"Eva");
    vc.mSampleid = [info objectForKey:@"sampleid"];
    vc.teaId = [info objectForKey:@"id"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)topmenu_click:(id)sender {
    UIButton *selectButton = (UIButton *)sender;
    
    _emptyView.hidden = YES;
    
    if (selectBtn.tag == selectButton.tag) {
        return;
    }
    
    if(selectButton.tag == 6325)
    {
        _emptyMsgLbl.text = @"您暂无兑换历史";
    }
    else if (selectButton.tag == 6326)
    {
        _emptyMsgLbl.text = @"您暂无已发货的茶样";
    }
    else if (selectButton.tag == 6327)
    {
        _emptyMsgLbl.text = @"您暂无待发货的茶样";
    }
    
    selectButton.selected = YES;
    selectBtn.selected = NO;
    selectBtn = selectButton;
    
    page = 1;
    if (selectButton.tag == 6325) {
        status = -1;
    }else if (selectButton.tag == 6326){
        status = 1;
    }else{
        status = 0;
    }
    
    [self loadTableViewData:NO];
    
    [UIView animateWithDuration:0.25 animations:^{
        _lin_leading_cons.constant = selectButton.x;
        [_topBg layoutIfNeeded];
    }];
    
}
@end
