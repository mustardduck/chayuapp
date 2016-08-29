//
//  CYBaseListViewController.m
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseListViewController.h"

@interface CYBaseListViewController ()

@end

@implementation CYBaseListViewController

- (CYNoDataView *)mNoDataView
{
    if (_mNoDataView == nil) {
        _mNoDataView = [[[NSBundle mainBundle] loadNibNamed:@"CYNoDataView" owner:nil options:nil] objectAtIndex:0];
        
        [_mNoDataView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:_mNoDataView];
        
        if (self.iTable != nil) {
            NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:_mNoDataView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.iTable attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
            NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:_mNoDataView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.iTable attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
            NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:_mNoDataView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.iTable attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:_mNoDataView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iTable attribute:NSLayoutAttributeTop multiplier:1 constant:0];
            
            [self.view addConstraint:constraint1];
            [self.view addConstraint:constraint2];
            [self.view addConstraint:constraint3];
            [self.view addConstraint:constraint4];
            
            [self.view layoutIfNeeded];
        }
    }
    
    return _mNoDataView;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    NSString* cName = [NSString stringWithFormat:@"%@",  self.class, nil];
//    [MobClick beginLogPageView:cName];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    NSString* cName = [NSString stringWithFormat:@"%@", self.class, nil];
//    [MobClick endLogPageView:cName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = false;
    self.mNoDataView.hidden = YES;
    [self initTableViewAppear];
}

- (void)initTableViewAppear
{
    self.mTableAppear = [self tableViewAppear];
    _mTableAppear.iCellNibName          = [self cellNibName];
    _mTableAppear.iCellHeight           = [self cellHeight];
    _mTableAppear.tableView             = _iTable;
    _mTableAppear.iDelegate             = self;
    _mTableAppear.iSelectCellColor      = [self cellSelectColor];
    _mTableAppear.iSelectCellImg        = [self cellSelectImage];
    _mTableAppear.iVariableCellHeight   = [self variableCellHeight];
    
    _iTable.dataSource   = _mTableAppear;
    _iTable.delegate     = _mTableAppear;
    
//    hiddenSepretor(_iTable);
    
    if ([_iTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [_iTable setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_iTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [_iTable setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _iTable.pullDelegate         = self;
    
    [_iTable hideLoadMore];
    
    self.iTable.separatorColor = UIColorFromRGB(0xdddddd);
    self.iTable.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
}

- (NSInteger)requestCount
{
    return 10;
}

- (void)initListAction:(NSString *)strAction params:(NSDictionary *)params
{
    _mActionStr = strAction;
    _mParamDict = params;
    _mCurrPage = 1;
    [self refreshListData];
}

- (void)refreshListData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:self.mParamDict];
    [param setObject:@([self requestCount]) forKey:@"pageSize"];
    [param setObject:@(_mCurrPage) forKey:@"pageNo"];
    
    [CYWebClient Post:self.mActionStr parametes:param success:^(id responObject) {

    [self showListData:responObject refresh:YES];
    
    } failure:^(id error) {
        [self.iTable stopPullRefresh];
    }];
}

- (void)tableViewPullDownRefresh:(CYPullTableView *)pullTableView
{
    _mCurrPage = 1;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:self.mParamDict];
    [param setObject:@([self requestCount]) forKey:@"pageSize"];
    [param setObject:@(_mCurrPage) forKey:@"pageNo"];
    
    
    
    [CYWebClient Post:self.mActionStr parametes:param success:^(id responObject) {
        
//          [self.iTable stopPullRefresh];
        [self showListData:responObject refresh:YES];
        
      
//        NSArray *listArr = nil;
//        //    id list = [listData objectForKey:@"list"];
//        if ([responObject isKindOfClass:[NSDictionary class]]) {
//            listArr = [responObject objectForKey:@"list"];
//        }else{
//            listArr = responObject;
//        }
//        
//        if ([listArr count] < [self requestCount]) {
//            [self.iTable showLoadMore];
//        }
        
   
   
    } failure:^(id error) {
        [self.iTable stopPullRefresh];
    }];
}

- (void)tableViewPullUpLoadMore:(CYPullTableView *)loadMoreTableView
{
    _mCurrPage += 1;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:self.mParamDict];
    [param setObject:@([self requestCount]) forKey:@"pageSize"];
    [param setObject:@(_mCurrPage) forKey:@"pageNo"];
    
    [CYWebClient Post:self.mActionStr parametes:param success:^(id responObject) {
//              [self.iTable stopLoadMore];
        [self showListData:responObject refresh:NO];

//        NSArray *listArr = nil;
//        //    id list = [listData objectForKey:@"list"];
//        if ([responObject isKindOfClass:[NSDictionary class]]) {
//            listArr = [responObject objectForKey:@"list"];
//        }else{
//            listArr = responObject;
//        }
//        
//        if ([listArr count] < [self requestCount]) {
//            [self.iTable showLoadMore];
//        }
        
       
        
    } failure:^(id error) {
        [self.iTable stopPullRefresh];
    }];

}

- (void)showListData:(id)listData refresh:(BOOL)bRefresh{
    
    NSArray *listArr = nil;
//    id list = [listData objectForKey:@"list"];
    if ([listData isKindOfClass:[NSDictionary class]]) {
        listArr = [listData objectForKey:@"list"];
    }else{
        listArr = listData;
    }
    if (bRefresh) {
        _mTableAppear.iDataSourceArr   = [NSMutableArray arrayWithArray:listArr];
        if (listData == nil || [listData count] == 0) {
            self.mNoDataView.hidden = NO;
        }else
        {
            self.mNoDataView.hidden = YES;
        }
        
        [_iTable stopPullRefresh];

    }else{
        if ([listArr count] >= [self requestCount]) {
            [_iTable stopLoadMore];
        }
        
        if ([listArr count] > 0)
        {
            [_mTableAppear appendDataSource:listArr];
        }
    }
    
    if ([listArr count] < [self requestCount]) {
       [_iTable.footer endRefreshingWithNoMoreData];
    }else{
        [_iTable.footer  resetNoMoreData];
    }
    
    [_iTable reloadData];
}

#pragma mark -
#pragma mark - 点击
- (void)tableViewApperDidClicked:(id)data
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation CYBaseViewController (TableAppear)

/**
 *  需自定义数据源时重写该方法
 *
 *  @return @see BaseTableViewAppear
 */
- (BaseTableViewAppear *)tableViewAppear
{
    return [[BaseTableViewAppear alloc] init];
}

/**
 *  需自定义cell高度时重写该方法
 *
 *  @return cell高度
 */
- (CGFloat)cellHeight
{
    return 44.0;
}

- (BOOL)variableCellHeight
{
    return NO;
}

/**
 *  需自定义cell时重写该方法
 *
 *  @return cellNibName
 */
- (NSString *)cellNibName
{
    return @"BaseCell";
}

- (UIColor *)cellSelectColor
{
    return [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1.0];
}

- (UIImage *)cellSelectImage
{
    return nil;
}

@end
