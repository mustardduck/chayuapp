//
//  CYBBSTableView.h
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface CYBBSTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger itemCount;

@property (nonatomic, readonly) NSArray *dataList;

@property (nonatomic, copy) CGFloat (^cellHeightCalc)(NSIndexPath *idxPath);

@property (nonatomic, copy) void(^itemClicked)(NSIndexPath *idxPath);

- (void)loadFirstData;
- (void)loadMoreData;

@end
