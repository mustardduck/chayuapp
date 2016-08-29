//
//  CYThemesContentView.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYThemesContentView.h"
#import "CYThemeItemCell.h"

@interface CYThemesContentView ()

@property (nonatomic, strong) NSMutableArray *themes;

@end

@implementation CYThemesContentView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        __weak typeof(self) weakSelf = self;
        self.themes = [NSMutableArray array];
        self.cellHeightCalc = ^CGFloat(NSIndexPath *idxPath) {
            NSDictionary *topic = [weakSelf.themes objectAtIndex:idxPath.row];
            return [CYThemeItemCell cellHeightWithInfo:topic];
        };
        self.header.lastUpdatedTimeKey = @"CYThemesContentViewHeader";
    }
    return self;
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.themes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYThemeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYThemeItemCell"];
    cell.itemInfo = [self.themes objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - self defined method
- (void)loadFirstData
{
    [super loadFirstData];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.gid) {
        [params setObject:self.gid forKey:@"catid"];
    }
    [params setObject:@(self.currentPage) forKey:@"p"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [CYWebClient Post:@"bbs_topic_list" parametes:params success:^(id responObject) {
        [self.header endRefreshing];
        [self.themes removeAllObjects];
        [self.themes addObjectsFromArray:responObject];
  
        
        if (self.themes.count<20) {
            self.footer = nil;
        }
        [self reloadData];
    } failure:^(id error) {
        [self.header endRefreshing];
    }];
}

- (void)loadMoreData
{
    [super loadMoreData];
    self.currentPage ++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.gid) {
        [params setObject:self.gid forKey:@"catid"];
    }
    [params setObject:@(self.currentPage) forKey:@"p"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [CYWebClient Post:@"bbs_topic_list" parametes:params success:^(id responObject) {
        [self.themes addObjectsFromArray:responObject];
        [self reloadData];
        if ([responObject count] == 20) {
            [self.footer endRefreshing];
        } else {
            [self.footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(id error) {
        self.currentPage --;
        [self.footer endRefreshing];
    }];
}

#pragma mark - getter & setter methods
- (NSArray *)dataList
{
    return self.themes;
}

- (void)setGid:(NSString *)gid
{
    if ([gid isEqualToString:_gid]) {
        if (self.contentOffset.y > 0) {
            [self setContentOffset:CGPointZero animated:YES];
        } else {
            [self loadFirstData];
        }
        return ;
    }
    _gid = gid;
    [self loadFirstData];
}

@end
