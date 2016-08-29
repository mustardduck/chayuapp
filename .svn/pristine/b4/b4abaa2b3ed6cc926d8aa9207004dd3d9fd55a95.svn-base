//
//  CYBuyerCateItemCell.h
//  茶语
//
//  Created by Leen on 16/5/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYBuyerCateItemCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,strong)NSIndexPath *cellIndePath;

@property (nonatomic,strong)NSArray *itemArr;

+ (CGFloat)cellHeightWithInfo:(NSInteger)arrCount andisLast:(BOOL)isLast;

@property (nonatomic,assign)BOOL isLast;

@property (nonatomic, copy) void(^itemClick)(NSDictionary *,NSIndexPath *);

@property (nonatomic,assign)BOOL isAllClass;//全部分类

@property (nonatomic,copy)NSString *catId;

@property (nonatomic,assign)BOOL isAddLastBtn;//最后一个为增加按钮

@end
