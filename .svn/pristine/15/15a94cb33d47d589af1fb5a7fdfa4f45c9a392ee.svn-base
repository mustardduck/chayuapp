//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

@protocol MJPhotoBrowserDelegate;
@interface MJPhotoBrowser : UIViewController <UIScrollViewDelegate>
// 代理
@property (nonatomic, weak) id<MJPhotoBrowserDelegate> delegate;
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@property (nonatomic, retain) NSArray *dataArray;

@property (nonatomic, assign) BOOL isShowLogo;

@property (nonatomic, assign) BOOL isFromComment;
@property (nonatomic, strong) id icWorkingVC;
@property (nonatomic, assign) NSInteger commentSection;
// ((Comment *)_commentArray[commentSection]).accessoryList[commentRow]  详情页面的评论数组
@property (nonatomic, assign) NSInteger commentRow;
@property (nonatomic, strong) NSMutableArray *commentArray;

// 显示
- (void)show;
@end

@protocol MJPhotoBrowserDelegate <NSObject>
@optional
// 切换到某一页图片
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;
//点击图片
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didClickToPageAtIndex:(NSUInteger)index;
@end