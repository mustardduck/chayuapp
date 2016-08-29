//
//  CYWenZhangHeJiViewController.m
//  茶语
//
//  Created by Chayu on 16/8/17.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWenZhangHeJiViewController.h"
#import "CYWenZhangHeJiCell.h"
#import "CYActiveHeader.h"
#import "CYWenZhangDetailsController.h"
@interface CYWenZhangHeJiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
    NSInteger page;
    OSMessage * _shareMsg;
}
- (IBAction)goback:(id)sender;
@property (nonatomic,strong)CYActiveHeader *headerView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CYWenZhangHeJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray array];
    _shareMsg = [[OSMessage alloc] init];
    hiddenSepretor(_tableView);
    page =1;
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadListData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadListData:YES];
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick beginLogPageView:@"文章合集"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"文章合集"];
}

- (CYActiveHeader *)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CYActiveHeader" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH,305);
    }
    return _headerView;
}


- (void)headerChanged:(NSNotification *)sender
{
    _tableView.tableHeaderView = self.headerView;
}

-(void)loadListData:(BOOL)loadMore
{
    
    if (loadMore) {
        page ++;
    }else{
        page =1;
    }
    
    __weak __typeof(self) weakSelf = self;
    [CYWebClient basePost:@"2.0_article.collection" parametes:@{@"p":@(page),@"pageSize":@"10",@"id":_hejiId} success:^(id responObject) {
        
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        NSArray *data = [responObject objectForKey:@"data"];
        if (state == 400) {
            NSArray *arr = data;
            if (!loadMore) {
                [dataArr removeAllObjects];
                [_tableView reloadData];
            }
            if (loadMore) {
                [weakSelf.tableView.footer endRefreshing];
            }else{
                [weakSelf.tableView.header endRefreshing];
            }
            
            if ([arr count]<10) {
                weakSelf.tableView.footer = nil;
            }else{
                _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf loadListData:YES];
                }];
            }
            NSDictionary * shareInfo = [responObject objectForJSONKey:@"share"];
            if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
                _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
                _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
                _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
                _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
            }
            
            NSDictionary *collection = [responObject objectForKey:@"collection"];
            if ([collection isKindOfClass:[NSDictionary class]] && [collection count]>0) {
                NSString *showUrl = [collection objectForKey:@"thumb"];
                [weakSelf.headerView.showImg sd_setImageWithURL:[NSURL URLWithString:showUrl] placeholderImage:WIDEIMG];
                weakSelf.headerView.titleLbl.text = @"推荐文章";
                weakSelf.headerView.desc = [collection objectForKey:@"description"];
                weakSelf.tableView.tableHeaderView = self.headerView;
            }
            
            if (arr.count) {
                [dataArr addObjectsFromArray:arr];
                [_tableView reloadData];
            }
            
            if ([data count]<10) {
                weakSelf.tableView.footer = nil;
            }
            
            if (dataArr.count<10) {
                weakSelf.tableView.footer = nil;
            }
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
        
        
        
    } failure:^(id error) {
        [weakSelf.tableView.header endRefreshing];
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

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

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
    CGFloat height = 250 *SCREENBILI + 87;
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = MAIN_BGCOLOR;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        view.backgroundColor = MAIN_BGCOLOR;
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 0.0000001;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYWenZhangHeJiCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"CYWenZhangHeJiCell"];
    NSDictionary *info = dataArr[indexPath.section];
    cell.contentLbl.text = [info objectForKey:@"intro"];
    NSString *thumb = [info objectForKey:@"thumb"];
    if (thumb && thumb.length >0) {
        [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"750×500"]];
    }
    cell.zanLbl.text = [[info objectForKey:@"suports"] description];
    cell.liulanLbl.text = [[info objectForKey:@"clicks"] description];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = dataArr[indexPath.section];
    CYWenZhangDetailsController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYWenZhangDetailsController"];
    vc.wenzhangId = [info objectForJSONKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
