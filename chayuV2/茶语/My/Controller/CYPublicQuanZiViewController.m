//
//  CYPublicQuanZiViewController.m
//  茶语
//
//  Created by taotao on 16/8/7.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPublicQuanZiViewController.h"
#import "CYQuanZiListCell.h"
#import "CYQuanZiDetailController.h"
@interface CYPublicQuanZiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
        NSInteger page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation CYPublicQuanZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray array];
    page = 1;
    
    switch (_quanzitye) {
        case CYQuanZiTypeChuangGuanLi:
        {
            self.titleLbl.text = @"我管理的圈子";
            break;
        }
        case CYQuanZiTypeChuangJian:
        {
            self.titleLbl.text = @"我创建的圈子";
            break;
        }
        case CYQuanZiTypeChuangGuanZhu:
        {
             self.titleLbl.text = @"我关注的圈子";
            break;
        }
            
        default:
            break;
    }
    hiddenSepretor(_tableView);
    
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadquanzilistData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadquanzilistData:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadquanzilistData:(BOOL)hasMore
{
    if (hasMore) {
        page ++;
    }else{
        page =1 ;
    }
    __weak __typeof(self) weakSelf = self;
    
    NSString *urlPath = @"";
    switch (_quanzitye) {
        case CYQuanZiTypeChuangGuanLi:
        {
            urlPath = @"2.0.user.group.get_manager";
            break;
        }
        case CYQuanZiTypeChuangJian:
        {
             urlPath = @"2.0.user.group.get_create";
            break;
        }
        case CYQuanZiTypeChuangGuanZhu:
        {
             urlPath = @"MyQuanzi";
            break;
        }
            
        default:
            break;
    }
    
    [CYWebClient Post:urlPath parametes:@{@"p":@(page),@"pageSize":@"10"} success:^(id responObj) {
        if (hasMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
            [dataArr removeAllObjects];
            [weakSelf.tableView reloadData];
        }
        NSArray *arr = [responObj objectForKey:@"items"];
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

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYQuanZiListCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYQuanZiListCell"];
    NSDictionary *info = nil;
        info = dataArr[indexPath.row];
        cell.titleLbl.text = [info objectForKey:@"name"];
        cell.guanzhuLbl.text = [NSString stringWithFormat:@"关注：%@",[info objectForKey:@"attentionnum"]];
        cell.tieziLbl.text = [NSString stringWithFormat:@"帖子：%@",[info objectForKey:@"topics"]];
        NSString *logoStr = [info objectForKey:@"logo"];
        if (logoStr.length) {
            [cell.showimg sd_setImageWithURL:[NSURL URLWithString:logoStr] placeholderImage:SQUARE];
        }
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = dataArr[indexPath.row];
    CYQuanZiDetailController *vc = viewControllerInStoryBoard(@"CYQuanZiDetailController", @"BBS");
    vc.gid = [[info objectForKey:@"gid"] description];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
