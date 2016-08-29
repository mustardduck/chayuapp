//
//  CYBaseListViewController.h
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"
#import "BaseTableViewAppear.h"
#import "CYPullTableView.h"
#import "CYNoDataView.h"

@interface CYBaseListViewController : CYBaseViewController <CYPullTableViewDelegate,TableViewAppearDelegate>
{
    BaseTableViewAppear *_mTableAppear;
    CYPullTableView *_iTable;
}

@property (nonatomic, strong) BaseTableViewAppear *mTableAppear;

@property (nonatomic, strong, readonly) NSString      *mActionStr;
@property (nonatomic, strong, readonly) NSDictionary  *mParamDict;
@property (nonatomic, assign, readonly) NSInteger     mCurrPage;

@property (nonatomic, strong) IBOutlet CYPullTableView *iTable;

@property (nonatomic, strong) IBOutlet CYNoDataView *mNoDataView;

- (void)initListAction:(NSString *)strAction params:(NSDictionary *)params;

/**
 *  拉取网络数据
 */
- (void)refreshListData;

/**
 *  每页加载条数
 *
 *  @return
 */
- (NSInteger)requestCount;

- (void)showListData:(id)listData refresh:(BOOL)bRefresh;

@end


@interface CYBaseListViewController (TableAppear)

/**
 *  需自定义数据源时重写该方法
 *
 *  @return @see BaseTableViewAppear
 */
- (BaseTableViewAppear *)tableViewAppear;

/**
 *  需自定义cell高度时重写该方法
 *
 *  @return cell高度
 */
- (CGFloat)cellHeight;

/**
 *  cell 动态高度
 *
 *  @return
 */
- (BOOL)variableCellHeight;

/**
 *  需自定义cell时重写该方法
 *
 *  @return cellNibName
 */
- (NSString *)cellNibName;

/**
 *  自定义cell选择颜色
 *
 *  @return UIColor
 */
- (UIColor *)cellSelectColor;

/**
 *  自定义cell选择图片 默认为空，与 cellSelectColor 选择一种使用
 *
 *  @return UIColor
 */
- (UIImage *)cellSelectImage;


@end
