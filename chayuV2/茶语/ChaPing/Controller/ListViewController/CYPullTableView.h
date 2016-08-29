//
//  CYPullTableView.h
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYPullTableViewDelegate;

@interface CYPullTableView : UITableView

@property (nonatomic, weak) IBOutlet id<CYPullTableViewDelegate> pullDelegate;
- (void)startPullRefresh;
- (void)stopPullRefresh;
- (void)hideLoadMore;
- (void)stopLoadMore;
- (void)showLoadMore;

@end

@protocol CYPullTableViewDelegate <NSObject>

@optional
- (void)tableViewPullDownRefresh:(CYPullTableView *)pullTableView;
- (void)tableViewPullUpLoadMore:(CYPullTableView *)loadMoreTableView;

@end