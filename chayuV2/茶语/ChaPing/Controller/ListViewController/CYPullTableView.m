//
//  CYPullTableView.m
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPullTableView.h"
#import "MJRefresh.h"

@implementation CYPullTableView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        __weak CYPullTableView *fc = self;
        //添加下拉刷新
        self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [fc.pullDelegate tableViewPullDownRefresh:fc];
        }];
        
        //添加加载更多
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            [fc.pullDelegate tableViewPullUpLoadMore:fc];
        }];
    }
    
    return self;
}

- (void)startPullRefresh
{
    [self.header beginRefreshing];
}

- (void)stopPullRefresh
{
    [self.header endRefreshing];
}

- (void)hideLoadMore
{
    [self.footer setHidden:YES];
}

- (void)stopLoadMore
{
    [self.footer endRefreshing];
}

- (void)showLoadMore
{
    [self.footer resetNoMoreData];
}


@end
