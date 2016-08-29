//
//  CYHongBaoViewController.m
//  茶语
//
//  Created by Leen on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHongBaoViewController.h"
#import "CYHongBaoModel.h"
#import "CYHongBaoCell.h"
#import "CYCouponDetViewController.h"
@interface CYHongBaoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    UIView *emptyView;
    NSInteger status; //状态
}

@property (weak, nonatomic) IBOutlet UITableView *tbl_hongbao;

- (IBAction)topmenu_click:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lin_leading_cons;

@property (weak, nonatomic) IBOutlet UIView *topBg;


@end

@implementation CYHongBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_arr_data) {
        _arr_data = [[NSMutableArray alloc] init];
        page = 1;
    }
    
    [self.view addSubview:[self emptyView]];
    UIView *view = [self.view viewWithTag:1000002];
    emptyView = view;
    emptyView.hidden = YES;
    [self.view sendSubviewToBack:emptyView];
    self.view.backgroundColor = [UIColor getColorWithHexString:@"f9f9f9"];
//    self.title = @"我的抵扣券";
    status = 1;
    __weak __typeof(self) weakSelf = self;
    [_tbl_hongbao registerNib:[UINib nibWithNibName:@"CYHongBaoCell" bundle:nil] forCellReuseIdentifier:@"CYMyHongBaoCell"];
    
    _tbl_hongbao.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO];
    }];
    [_tbl_hongbao.header beginRefreshing];
    _tbl_hongbao.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];

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

#pragma mark -
#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _arr_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 61.f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CYMyHongBaoCell";
    
    NSInteger row = indexPath.section;
    
    CYHongBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.model = _arr_data[row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000000001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYHongBaoModel *model = _arr_data[indexPath.section];
    CYCouponDetViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYCouponDetViewController"];
    vc.couponId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadTableViewData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        page = 1;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"MyHongBao" parametes:@{@"p":@(page),@"pageSize":@"10",@"status":@(status)} success:^(id responObj) {
        if (loadMore) {
            [weakSelf.tbl_hongbao.footer endRefreshing];
        }else{
            [weakSelf.tbl_hongbao.header endRefreshing];
            [_arr_data removeAllObjects];
            [_tbl_hongbao reloadData];
        }
        NSArray *items = [responObj objectForKey:@"items"];
        if (![items isKindOfClass:[NSNull class]] && [items count] < 10) {
            [weakSelf.tbl_hongbao.footer endRefreshingWithNoMoreData];
        }else{
              [weakSelf.tbl_hongbao.footer resetNoMoreData];
        }
        [_arr_data addObjectsFromArray:[CYHongBaoModel objectArrayWithKeyValuesArray:[responObj objectForKey:@"items"]]];
        if (_arr_data.count == 0) {
            weakSelf.tbl_hongbao.hidden = YES;
            emptyView.hidden = NO;
        }else{
            weakSelf.tbl_hongbao.hidden = NO;
            emptyView.hidden = YES;
            
        }
        
        if (_arr_data.count<10) {
             weakSelf.tbl_hongbao.footer = nil;
        }else{
            weakSelf.tbl_hongbao.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadTableViewData:YES];
            }];
        }
        
        [weakSelf.tbl_hongbao reloadData];
        
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.tbl_hongbao.footer endRefreshing];
        }else{
            [weakSelf.tbl_hongbao.header endRefreshing];
        }
    }];
}



- (IBAction)topmenu_click:(id)sender {
    UIButton *selectButton = (UIButton *)sender;
    for (int i = 6325; i<6328; i++) {
        UIButton *button = (UIButton *)[_topBg viewWithTag:i];
        if (button.tag == selectButton.tag) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
    
    if (selectButton.tag == 6325) {
        status = 1;
    }else if (selectButton.tag == 6326){
        status = 3;
    }else{
        status = 2;
    }
    
    [_arr_data removeAllObjects];
    [_tbl_hongbao reloadData];
    
    [self loadTableViewData:NO];
    
    [UIView animateWithDuration:0.25 animations:^{
        _lin_leading_cons.constant = selectButton.x;
        [_topBg layoutIfNeeded];
    }];
    
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
