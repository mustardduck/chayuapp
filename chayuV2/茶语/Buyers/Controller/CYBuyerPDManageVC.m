//
//  CYBuyerPDManageVC.m
//  茶语
//
//  Created by Leen on 16/6/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDManageVC.h"
#import "CYBuyerPDOnSaleCell.h"
#import "CYBuyerPDOffSaleCell.h"
#import "CYBuyerPDEditVC.h"
#import "CYBuyerMainCellModel.h"
#import "CYBuyerPDCellModel.h"

@interface CYBuyerPDManageVC ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL topmenushow;
    NSInteger gid; //大师 9， 名家10
    NSInteger page;
    NSMutableArray *allData;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *masternumLbl;
@property (weak, nonatomic) IBOutlet UILabel *famousNumLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linview_horizon_cons;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic,strong)NSMutableArray *dataArr;
- (IBAction)goback:(id)sender;
- (IBAction)top_menu:(id)sender;

- (IBAction)masterOrFamous_click:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *addPDView;


@end

@implementation CYBuyerPDManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    page = 1;
    allData = [[NSMutableArray alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIButton *button = nil;
        if (_type == CYBuyerPDTypeOffSale) {
            gid = 10;
            button = (UIButton *)[_topView viewWithTag:1301];
        }else{
            button = (UIButton *)[_topView viewWithTag:1300];
            gid = 9;
        }
        [self masterOrFamous_click:button];
    });
    
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO];
        
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];

}
- (IBAction)addPDBtnClicked:(id)sender {
    
    CYBuyerPDEditVC * vc = viewControllerInStoryBoard(@"CYBuyerPDEditVC", @"Buyer");
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    topmenushow = NO;
    
    [MobClick beginLogPageView:self.title];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}

/**
 *  加载页面数据
 */
-(void)loadTableViewData:(BOOL)loadMore
{
    NSInteger pageSize = 8;
    if (loadMore) {
        page ++;
    }else{
        page =1;
        [self.dataArr removeAllObjects];
        [_tableView reloadData];
    }
    
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"SellerList" parametes:@{@"gid":@(gid),@"p":@(page),@"pageSize":@(pageSize)} success:^(id responObj) {
        if (loadMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
        NSArray *arr = responObj;
        if ([arr count]<8) {
            
            weakSelf.tableView.contentInset = UIEdgeInsetsZero;
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
     
        }
        
        [weakSelf.dataArr addObjectsFromArray:[CYBuyerPDCellModel objectArrayWithKeyValuesArray:arr]];
        [weakSelf.tableView reloadData];
        
        if (weakSelf.dataArr.count != 0) {// todo
//            [weakSelf.view addSubview:[self emptyView]];
            _addPDView.hidden = NO;
        }else{
            UIView *view = [weakSelf.view viewWithTag:1000002];
            if (view) {
                [view removeFromSuperview];
            }
            
        }
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)top_menu:(id)sender {
    //    [self showTopMenuView:!topmenushow];
    topmenushow = !topmenushow;
}

- (IBAction)masterOrFamous_click:(UIButton *)sender {
    _linview_horizon_cons.constant = sender.x;
    _tableView.hidden  = NO;
    if (sender.tag == 1300) {//大师
        gid = 9;
    }else{
        gid = 10;
    }
    [allData removeAllObjects];
    [self loadTableViewData:NO];
    UIView *view = [self.view viewWithTag:1250];//顶部view tag值1250
    for (int i =1300;i<1302; i++) {
        UIButton *btn = (UIButton *)[view viewWithTag:i];
        if (sender.tag == btn.tag) {
            btn.selected = YES;
            
        }else{
            btn.selected = NO;
        }
    }
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height =MASTERCELL_HEIGHT*(SCREEN_WIDTH/320.);
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerPDOnSaleCell *cell = [CYBuyerPDOnSaleCell cellWidthTableView:tableView];
    CYBuyerPDCellModel *model = self.dataArr[indexPath.row];

    CYBuyerMainCellModel * mainModel = [[CYBuyerMainCellModel alloc] init];
    mainModel.thumb = model.thumb;
    mainModel.selleravatar = model.avatar;
    mainModel.sellername = model.realname;
    mainModel.title = model.name;
    mainModel.enjoy_count = model.enjoy;
    mainModel.comment_count = model.comment_count;
    mainModel.price_sell = model.price_sell;
    
    cell.model = mainModel;
    
    return cell;
}


@end
