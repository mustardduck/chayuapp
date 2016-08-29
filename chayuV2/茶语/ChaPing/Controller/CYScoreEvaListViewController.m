//
//  CYScoreEvaListViewController.m
//  茶语
//
//  Created by Leen on 16/3/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYScoreEvaListViewController.h"
#import "CYHomeItemCell.h"
#import "CYScoreModel.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYArticleDetailViewController.h"
#import "CYTopicDetailController.h"
#import "CYWenZhangDetailsController.h"
@interface CYScoreEvaListViewController ()

@end

@implementation CYScoreEvaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSMutableDictionary *params = [NSMutableDictionary new];
    if (_type.length > 0) {
        [params setObject:_type forKey:@"type"];
    }
    
    if (_bid.length > 0) {
        [params setObject:_bid forKey:@"bid"];
    }
    
    [self initListAction:_brandName params:params];
    
    hiddenSepretor(self.iTable);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"茶评评分"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"茶评评分"];
}


- (NSInteger)requestCount
{
    return 40;
}

- (NSString *)cellNibName
{
    return @"CYBrandCell";
}

- (CGFloat)cellHeight
{
    return 48;
}

- (void)showListData:(id)listData refresh:(BOOL)bRefresh
{
    id list = [listData objectForKey:@"list"];
    NSArray *listArr= nil;
    if ([listData isKindOfClass:[NSDictionary class]] && [list isKindOfClass:[NSArray class]]) {
        listArr = list;
    }else
    {
        listArr = listData;
    }

    if ([self.brandName isEqualToString:@"top_wkjp"]) {
        listArr = [CYScoreArticleInfo objectArrayWithKeyValuesArray:listArr];
    }else if ([self.brandName isEqualToString:@"top_group"])
    {
        listArr = [CYScoreTopicInfo objectArrayWithKeyValuesArray:listArr];
    }else if ([self.brandName isEqualToString:@"top_taobao"]){
        listArr = [CYScoreTBInfo objectArrayWithKeyValuesArray:listArr];
    }else
    {
        listArr = [CYScoreModel objectArrayWithKeyValuesArray:listArr];
    }
    

    
    if (bRefresh) {
        _mTableAppear.iDataSourceArr   = [NSMutableArray arrayWithArray:listArr];
        if (listArr == nil || [listArr count] == 0) {
            self.mNoDataView.hidden = NO;
        }else
        {
            self.mNoDataView.hidden = YES;
        }
        [_iTable stopPullRefresh];
    }else{
        
         [_iTable stopLoadMore];
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
    
    if (_mTableAppear.iDataSourceArr.count <[self requestCount]) {
        _iTable.footer = nil;
    }

    
    [_iTable reloadData];
}

- (void)tableViewApperDidClicked:(id)data
{
//    return;
    if ([data isKindOfClass:[CYScoreArticleInfo class]]) {
        CYScoreArticleInfo *info = data;
        
        CYArticleInfo *articleInfo = [CYArticleInfo new];
        articleInfo.itemid = info.articleid;
        articleInfo.title = info.title;
        
        CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
        vc.wenzhangId = info.articleid;;
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([data isKindOfClass:[CYScoreTopicInfo class]])
    {
        CYScoreTopicInfo *info = data;

        CYTopicDetailController *tdc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
//        tdc.hidesBottomBarWhenPushed = YES;
        tdc.tid = info.tid;
        [self.navigationController pushViewController:tdc animated:YES];
    }else if ([data isKindOfClass:[CYScoreModel class]])
    {
        
        CYScoreModel *info = data;
        if ([self.title isEqualToString:@"茶语兑换榜"]) {
//            CYTeaSampleDetailViewController *vc = [[CYTeaSampleDetailViewController alloc] initWithNibName:@"CYTeaSampleDetailViewController" bundle:nil];
//            vc.mSampleid = info.sampleid;
//            [self.navigationController pushViewController:vc animated:YES];
        }else{
            CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
            vc.mTeaId = info.teaid;
            [self.navigationController pushViewController:vc animated:YES];
        }

        
    }else if ([data isKindOfClass:[CYScoreTBInfo class]])
    {
        if ([self.title hasPrefix:@"淘宝"]) {
            return;
        }
        CYScoreTBInfo *info = data;
        CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
        vc.mTeaId = info.tid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
