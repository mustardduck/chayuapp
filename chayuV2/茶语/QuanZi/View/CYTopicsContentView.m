//
//  CYTopicsContentView.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTopicsContentView.h"

#import "CYTopicItemCell.h"

@interface CYTopicsContentView ()

@property (nonatomic, strong) NSMutableArray *topics;

@end

@implementation CYTopicsContentView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.topics = [NSMutableArray array];
//        __weak typeof(self) weakSelf = self;
        self.cellHeightCalc = ^CGFloat(NSIndexPath *idxPath) {
            return 90.f;
//            NSDictionary *topic = [weakSelf.topics objectAtIndex:idxPath.row];
//            return [CYTopicItemCell cellHeightWithInfo:topic];
        };
        self.header.lastUpdatedTimeKey = @"CYTopicsContentViewHeader";
    }
    return self;
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYTopicItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTopicItemCell"];
    cell.itemInfo = [self.topics objectAtIndex:indexPath.row];
    cell.needAttention = ^(NSDictionary *topicInfo) {
//        dispatch_async(dispatch_get_main_queue(), ^{
            [self attentionTopic:topicInfo];
//        });
    };
    return cell;
}

#pragma mark - UITableViewDelegate methods

#pragma mark - self defined method
- (void)loadFirstData
{
    [super loadFirstData];
    self.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.catId) {
        [params setObject:self.catId forKey:@"catid"];
    }
    [params setObject:@(self.currentPage) forKey:@"p"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [CYWebClient Post:@"bbs_group_list" parametes:params success:^(id responObject) {
        [self.header endRefreshing];
        [self.topics removeAllObjects];
        [self.topics addObjectsFromArray:responObject];
        [self reloadData];
        if (self.topics.count<20) {
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
    self.currentPage ++ ;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.catId) {
        [params setObject:self.catId forKey:@"catid"];
    }
    [params setObject:@(self.currentPage) forKey:@"p"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [CYWebClient Post:@"bbs_group_list" parametes:params success:^(id responObject) {
        [self.topics addObjectsFromArray:responObject];
        [self reloadData];
        BOOL hasMore = [responObject count] == 20;
        if (hasMore) {
            [self.footer endRefreshing];
        } else {
            [self.footer endRefreshingWithNoMoreData];
        }
    } failure:^(id error) {
        self.currentPage --;
        [self.footer endRefreshing];
    }];
}

- (void)attentionTopic:(NSDictionary *)topicInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *gid = [topicInfo objectForKey:@"gid"];
    if (gid) {
        [params setObject:gid forKey:@"gid"];
    }
    
    [CYWebClient Post:@"bbs_group_attention" parametes:params success:^(id responObject) {
//        [SVProgressHUD showInfoWithStatus:@""];
        NSNumber *count = [responObject objectForKey:@"attentionnum"];
        NSUInteger idx = [self.topics indexOfObject:topicInfo];
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:topicInfo];
        BOOL isattention = [[topicInfo objectForKey:@"isattention"] boolValue];
        isattention = !isattention;
        [info setObject:count forKey:@"attentionnum"];
        [info setObject:@(isattention) forKey:@"isattention"];
        if (idx<=[self.topics count]) {
            [self.topics replaceObjectAtIndex:idx withObject:info];
            [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
    
    } failure:^(id error) {
        
    }];
}

#pragma mark - getter & setter methods
- (void)setCatId:(NSString *)catId
{
    if ([catId isEqualToString:_catId]) {
        if (self.contentOffset.y > 0) {
            [self setContentOffset:CGPointZero animated:YES];
        } else {
            [self loadFirstData];
        }
        return ;
    }
    _catId = catId;
    [self loadFirstData];
}

- (NSArray *)dataList
{
    return self.topics;
}

@end
