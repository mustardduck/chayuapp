//
//  CYTeaMallActiveViewController.m
//  茶语
//
//  Created by Chayu on 16/2/26.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaMallActiveViewController.h"
#import "CYHomeCell.h"
#import "CYTeaMallCollectionViewController.h"
#import "CYActiveHeader.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
@interface CYTeaMallActiveViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    NSInteger page;
//    NSDictionary *info;
    OSMessage * _shareMsg;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)goback:(id)sender;

@end

@implementation CYTeaMallActiveViewController


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

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    _dataArr = [NSMutableArray array];
    _shareMsg = [[OSMessage alloc] init];
    
    hiddenSepretor(_tableView);
//    __weak __typeof(self) weakSelf = self;
//    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadtableViewData:NO];
//        
//    }];
//  
//    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadtableViewData:YES];
//    }];
//    [_tableView.header beginRefreshing];
    [self loadtableViewData:NO];
}

-(void)loadtableViewData:(BOOL)loadMore
{
//    if (loadMore) {
//        page ++;
//    }else{
//        page = 1;
// 
//    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"TeaMall_activity" parametes:nil success:^(id responObj) {
//        if (!loadMore) {
////            [weakSelf.tableView.header endRefreshing];
//        }else{
//            [weakSelf.tableView.footer endRefreshing];
//            [_dataArr removeAllObjects];
//        }
//        if ([responObj count]<10) {
//            weakSelf.tableView.footer = nil;
//        }else{
//            weakSelf.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                [weakSelf loadtableViewData:YES];
//            }];
//        }
        
        NSDictionary * shareInfo = [responObj objectForJSONKey:@"share"];
        if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
            _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
            _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
            _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
            _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
        }
     
        [_dataArr addObjectsFromArray:[CYMasterListModel objectArrayWithKeyValuesArray:responObj]];
        [weakSelf.tableView reloadData];
    } failure:^(id err) {
        if (!loadMore) {
            [weakSelf.tableView.header endRefreshing];
        }else{
            [weakSelf.tableView.footer endRefreshing];
        }
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
    return CellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYHomeCell *cell = [CYHomeCell cellWidthTableView:tableView];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMasterListModel *model = _dataArr[indexPath.row];
    CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
    NSInteger juhetype = [model.juheType integerValue];
    if (juhetype == 1) {//聚合 商品
        vc.type = CYCollectionTypeCommodity;
    }else{//聚合 人物
        vc.type = CYCollectionTypeCharacter;
    }
    vc.juhe_id = model.resource_id;
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}




- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)gotousercenter_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)sousuo_click:(id)sender {
    CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)navbar_clicked:(id)sender
{
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
    
}

@end
