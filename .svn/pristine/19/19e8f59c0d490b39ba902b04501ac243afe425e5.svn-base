//
//  CYBBSTableView.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBBSTableView.h"

#import "CYBBSItemCell.h"

@interface CYBBSTableView ()
{
    
}

@property (nonatomic, strong) NSMutableArray<NSNumber *> *cellHeights;


@end

@implementation CYBBSTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.tableFooterView = [UIView new];
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        self.cellHeights = [NSMutableArray array];
        self.currentPage = 1;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        self.cellHeights = [NSMutableArray array];
        self.currentPage = 0;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    __weak typeof(self) fc = self;
    //添加下拉刷新
    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.cellHeights removeAllObjects];
        [fc loadFirstData];
    }];
    self.header.lastUpdatedTimeKey = @"CYBBSTableViewHeader";
    
    //添加加载更多
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [fc loadMoreData];
    }];
    [super willMoveToSuperview:newSuperview];
    self.dataSource = self;
    self.delegate = self;
    
    
}

#pragma mark - self defined methods
- (void)loadFirstData
{
    [self.cellHeights removeAllObjects];
}

- (void)loadMoreData
{
    
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemClicked) {
        self.itemClicked(indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row < self.cellHeights.count) {
//        return [self.cellHeights[indexPath.row] floatValue];
//    } else {
        CGFloat height = self.cellHeightCalc(indexPath);
        [self.cellHeights addObject:@(height)];
        return height;
//    }
}


@end
