//
//  BaseTableViewAppear.h
//  PYFrameworks
//
//  Created by 李 峥 on 14/11/29.
//  Copyright (c) 2014年 李 峥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCell.h"

@protocol TableViewAppearDelegate;

@interface BaseTableViewAppear : NSObject <UITableViewDataSource,UITableViewDelegate>
{
    NSIndexPath *_selectedCellIndexPath;
    NSString *_iCellNibName;
    CGFloat _iCellHeight;
    UITableView *_tableView;
    BOOL _isTransparent;
    NSMutableArray *_iDataSourceArr;
    BOOL _iVariableCellHeight;
    UIImage *_iSelectCellImg;
    UIColor *_iSelectCellColor;
}

/** cell Nib name*/
@property (nonatomic, copy)     NSString *iCellNibName;
/** cell 高度*/
@property (nonatomic, assign)   CGFloat iCellHeight;
/** tableView*/
@property (nonatomic, strong)   UITableView *tableView;

/** 分组*/
@property (nonatomic, assign)   BOOL  grouped;
@property (nonatomic, assign)   CGFloat iHeaderHeight;
@property (nonatomic, assign)   CGFloat iFooterHeight;

/**
 *  Table数据源
 */
@property (nonatomic, strong) NSMutableArray *iDataSourceArr;

/**
 *  是否时不规则高度列表，默认NO
 */
@property (nonatomic, assign) BOOL iVariableCellHeight;

@property (nonatomic, strong, readonly) NSIndexPath *selectedCellIndexPath;

@property (nonatomic, weak) id<TableViewAppearDelegate> iDelegate;

/**
 *  cell 选中图片
 */
@property (nonatomic, strong) UIImage *iSelectCellImg;

/**
 *  cell 选中颜色
 */
@property (nonatomic, strong) UIColor *iSelectCellColor;

/**
 *  加载更多时，添加数据到当前列表后
 *
 *  @param moreDatasource <#moreDatasource description#>
 */
- (void)appendDataSource:(NSArray *)moreDatasource;

@end

/**
 *
 */
@protocol TableViewAppearDelegate <NSObject>

@optional
- (void)tableViewApperDidClicked:(id)data;
- (void)tableViewApperButtonDidClicked:(id)data;


@end