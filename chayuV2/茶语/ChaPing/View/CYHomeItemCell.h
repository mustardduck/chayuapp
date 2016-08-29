////
////  CYHomeItemCell.h
////  茶语
////
////  Created by iXcoder on 16/2/21.
////  Copyright © 2016年 Chayu. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
//#pragma mark - Home base Cell
//@interface CYHomeItemCell : UITableViewCell
//
//@property (nonatomic, strong) id itemInfo;
//
//+ (CGFloat)cellHeightWithInfo:(id)info;
//
//@end
//
//#pragma mark - Home Banner Cell
//@interface CYHomeBannerCell : CYHomeItemCell
//
//@property (nonatomic, copy) void(^bannerClick)(NSDictionary *bannerInfo);
//@property (nonatomic, copy) void(^shortCutClick)(NSUInteger idx);
//
//@end
//
//#pragma mark - Home Section Cell
//@interface CYHomeSectionCell : CYHomeItemCell
//
//@property (nonatomic, strong) NSString *secTitle;
//@property (nonatomic, copy) void(^homeSectionMoreClick)();
//
//@property (nonatomic, assign) BOOL discardMoreBtn;
//
//@end
//
//#pragma mark - Home Tea Kind Cell 茶评茶类
//@interface CYHomeTeaKindCell : CYHomeItemCell
//
//@property (nonatomic, copy) void(^teaKindItemClick)(NSDictionary *itemInfo);
//
//@end
//
//#pragma mark - Home Top Cell 今日头条&精选文章
//@interface CYHomeTopCell : CYHomeItemCell
//
//@end
//
//#pragma mark - Home Tea Recommend Cell 市集好茶
//@interface CYHomeTeaRecommmendCell : CYHomeItemCell
//
//@property (nonatomic, copy) void(^teaDetailClick)(NSDictionary *teaInfo);
//
//@end
//
//#pragma mark - Home Topic Cell 圈子话题
//@interface CYHomeTopicCell : CYHomeItemCell
//
//@property (nonatomic, assign) BOOL isLast;
//
//@end
//
//
//#pragma mark - Home Topic Cell 圈子话题 顶部三个圈子
//@interface CYHomeTopicTopCell : CYHomeItemCell
//
//@property (nonatomic, copy) void(^topicClassClick)(NSDictionary *teaInfo);
//
//@end
//
//
//#pragma mark - Home Tea Evaluate Cell茶评榜&综合评分榜
//@interface CYHomeTeaEvaluateCell : CYHomeItemCell
//
//@end
//
//
//
//
//
//
//
