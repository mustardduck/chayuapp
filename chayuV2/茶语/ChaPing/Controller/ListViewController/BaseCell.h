//
//  BaseCell.h
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

@property (nonatomic, strong) id mClickData;

/**
 *  给Cell赋值
 *
 *  @param data id
 */
- (void)parseData:(id)data;

/**
 *  获取xib
 *
 *  @param nibName xib名称
 *
 *  @return BaseCell的子类
 */
+ (BaseCell *)loadFromNibName:(NSString *)nibName;

/**
 *  动态获取cell高度
 *
 *  @param data cell数据源
 *
 *  @return cell 高度
 */
+ (CGFloat)calcCellHeight:(id)data;
@end
