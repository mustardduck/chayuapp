//
//  CYTopicListController.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTopicListController.h"
#import "CYThemeItemCell.h"
#import "CYPostCardViewController.h"
#import "AppDelegate.h"
@interface CYTopicListController ()<UITableViewDataSource, UITableViewDelegate>
{
    __block int page;
}

@property (nonatomic, weak) IBOutlet UITableView *ctntView;
@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, strong) NSMutableArray *cellHeights;

@property (nonatomic, weak) IBOutlet UIButton *scrollTopBtn;
- (IBAction)onShowScrollTopAction:(id)sender;

@end

@implementation CYTopicListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.title.length == 0) {
        self.title = @"圈子详情";
    }
    
    
    self.ctntView.tableFooterView = [UIView new];
    
    self.topics = [NSMutableArray array];
    self.ctntView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadFirstPageData];
    }];
    self.ctntView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    

    [self creatRightItem];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"圈子详情"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"圈子详情"];
    NSIndexPath *idxPath = [self.ctntView indexPathForSelectedRow];
    if (idxPath) {
        [self.ctntView deselectRowAtIndexPath:idxPath animated:YES];
    } else if (self.topics.count == 0) {
        [self.ctntView.header beginRefreshing];
    }
}

-(void)creatRightItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.titleLabel.font = FONT(16.0);
    [button setTitle:@"发帖" forState:UIControlStateNormal];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [button addTarget:self action:@selector(post_click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)post_click:(UIButton *)sender
{
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYPostCardViewController *vc =viewControllerInStoryBoard(@"CYPostCardViewController", @"BBS");
    vc.gid = _gid;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *idxPath = [self.ctntView indexPathForSelectedRow];
    if (!idxPath) {
        return ;
    }
    NSDictionary *topicInfo = [self.topics objectAtIndex:idxPath.row];
    NSString *gid = [topicInfo objectForKey:@"tid"];
    UIViewController *destVC = segue.destinationViewController;
    [destVC setValue:gid forKey:@"tid"];
}

#pragma mark - self defined method
- (IBAction)onShowScrollTopAction:(id)sender
{
    [self.ctntView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];
}

- (void)loadFirstPageData
{
    page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.gid) {
        [params setObject:self.gid forKey:@"gid"];
    }
    [params setObject:@(page) forKey:@"p"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [CYWebClient Post:@"bbs_group_detail" parametes:params success:^(id responObject) {
        [self.topics removeAllObjects];
        [self.topics addObjectsFromArray:responObject];
        [self.ctntView reloadData];
        
        BOOL hasMore = [responObject count] == 20;
        if (hasMore) {
            self.ctntView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self loadMoreData];
            }];
        } else {
            self.ctntView.footer = nil;
            
        }
        
        [self.ctntView.header endRefreshing];
    } failure:^(id error) {
        [self.ctntView.header endRefreshing];
    }];
}

- (void)loadMoreData
{
    page ++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.gid) {
        [params setObject:self.gid forKey:@"gid"];
    }
    [params setObject:@(page) forKey:@"p"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [CYWebClient Post:@"bbs_group_detail" parametes:params success:^(id responObject) {
        [self.topics addObjectsFromArray:responObject];
        [self.ctntView reloadData];
        BOOL hasMore = [responObject count] == 20;
        if (hasMore) {
            self.ctntView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self loadMoreData];
            }];
        } else {
             self.ctntView.footer = nil;
         
        }
    } failure:^(id error) {
        [self.ctntView.footer endRefreshing];
    }];
}


#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYThemeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYThemeItemCell"];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.cellHeights.count) {
        return [self.cellHeights[indexPath.row] floatValue];
    } else {
        NSDictionary *itemInfo = [self.topics objectAtIndex:indexPath.row];
        CGFloat height = [CYThemeItemCell cellHeightWithInfo:itemInfo];
        [self.cellHeights addObject:@(height)];
        return height;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYThemeItemCell *replyCell = (CYThemeItemCell *)cell;
    replyCell.itemInfo = [self.topics objectAtIndex:indexPath.row];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
#define SHOW_BTN_OFFSET 1000
#define SHOW_BTN_OFFSET_ABS 100
    CGFloat yOffset = scrollView.contentOffset.y;
    self.scrollTopBtn.hidden = yOffset < SHOW_BTN_OFFSET - SHOW_BTN_OFFSET_ABS;
    if (!self.scrollTopBtn.hidden) {
        self.scrollTopBtn.alpha = MIN(1., yOffset - SHOW_BTN_OFFSET_ABS + 100) / 100 * 1.;
    }
}

@end
