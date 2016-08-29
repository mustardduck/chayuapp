//
//  CYClassicTableViewCell.h
//  茶语
//
//  Created by Chayu on 16/3/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYClassicTableViewCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,strong)NSIndexPath *cellIndePath;

@property (nonatomic,strong)NSArray *itemArr;

+ (CGFloat)cellHeightWithInfo:(id)info andisLast:(BOOL)isLast;

@property (nonatomic,assign)BOOL isLast;

@property (nonatomic, copy) void(^itemClick)(NSDictionary *,NSIndexPath *);

@property (nonatomic,assign)BOOL isAllClass;//全部分类

@property (nonatomic,copy)NSString *catId;


@end
