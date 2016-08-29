//
//  CYBuyerAllListVC.m
//  茶语
//
//  Created by Leen on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerAllListVC.h"
#import "CYBuyAllCell.h"
#import "CYBuyerAllCategoryView.h"
#import "CYBuyerAllLetterView.h"
#import "UILabel+Utilities.h"
#import "CALayer+CALayer_CALayer_XibConfiguration.h"
#import "UIColor+Additions.h"
#import "UILabel+Utilities.h"
#import "CYBuyerAllListCellModel.h"
#import "CYBuyerDetailVC.h"
#import "CYShareModel.h"
#import "UICommon.h"

@interface CYBuyerAllListVC ()<UITableViewDelegate, UITableViewDataSource,CYBuyerAllCategoryViewDelegate, CYBuyerAllLetterViewDelegate>
{
    NSMutableArray * _dataArr;
    
    NSInteger page;
    
    NSString * _catid;
    NSString * _letter;
    CYShareModel  * _shareModel;
    
}
@property (weak, nonatomic) IBOutlet UIView *view_empty;

@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;

@property (weak, nonatomic) IBOutlet UIButton *nameBtn;

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (nonatomic, strong) CYBuyerAllCategoryView * categoryView;
@property (nonatomic, strong) CYBuyerAllLetterView * letterView;

@end

@implementation CYBuyerAllListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArr = [NSMutableArray array];
    _catid = @"";
    _letter = @"";
    
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.letterView];

    [self loadData];
}

- (void) loadData
{
    __weak __typeof(self) weakSelf = self;
    
    _mainTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO];
    }];
    [_mainTable.header beginRefreshing];
    _mainTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];
}

-(void)loadTableViewData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        page =1;
    }
    __weak __typeof(self) weakSelf = self;
    
    [CYWebClient Post:@"mingxing_list" parametes:@{@"p":@(page),@"pageSize":@(PAGESIZE),@"catid":_catid,@"letter":_letter} success:^(id responObj) {
        if (loadMore) {
            [weakSelf.mainTable.footer endRefreshing];
        }else{
            [_dataArr removeAllObjects];
            [weakSelf.mainTable.header endRefreshing];
        }
        NSArray *list =[responObj objectForKey:@"list"];
        if (![list isKindOfClass:[NSNull class]] && [list count] < PAGESIZE)
        {
            [weakSelf.mainTable.footer endRefreshingWithNoMoreData];
        }
        else
        {
            [weakSelf.mainTable.footer resetNoMoreData];
        }
        
        [_dataArr addObjectsFromArray:[CYBuyerAllListCellModel objectArrayWithKeyValuesArray:list]];
        [weakSelf.mainTable reloadData];
        
        _shareModel = [CYShareModel objectWithKeyValues:responObj];
        
        if ([_dataArr count] < PAGESIZE) {
            weakSelf.mainTable.footer = nil;
        }
        
        _view_empty.hidden = (_dataArr.count != 0);
        
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.mainTable.footer endRefreshing];
        }else{
            [weakSelf.mainTable.header endRefreshing];
        }
    }];
}

- (IBAction)goback:(id)sender {
    [self.categoryView removeFromSuperview];
    [self.letterView removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)touchUpInsideOn:(id)sender {
    
    UIButton * btn = (UIButton *)sender;
    
    if(btn == _categoryBtn)
    {
        _categoryView.hidden = !_categoryView.hidden;
        
        _letterView.hidden = YES;
        
        _categoryBtn.selected = !_categoryBtn.selected;
        _nameBtn.selected = NO;
    }
    else if (btn == _nameBtn)
    {
        _categoryView.hidden = YES;
        
        _letterView.hidden = !_letterView.hidden;
        
        _nameBtn.selected = !_nameBtn.selected;
        _categoryBtn.selected = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyAllCell * cell = (CYBuyAllCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerDetailVC * vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
    vc.seller_uid = ((CYBuyerAllListCellModel *) _dataArr[indexPath.row]).uid;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyAllCell * cell = [CYBuyAllCell cellForTableView:tableView];
    cell.allListCellmodel = _dataArr[indexPath.row];

    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CYBuyerAllCategoryView *)categoryView
{
    if (!_categoryView) {
        _categoryView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerAllCategoryView" owner:nil options:nil] firstObject];
        _categoryView.frame = WINDOW.bounds;
        CGFloat he = 90 * (SCREEN_WIDTH / 375);
        _categoryView.y = he + 60.0;
        _categoryView.delegate = self;
        _categoryView.height = SCREEN_HEIGHT - _categoryView.y;
        _categoryView.hidden = YES;
    }
    return _categoryView;
}

- (CYBuyerAllLetterView *)letterView
{
    if (!_letterView) {
        _letterView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerAllLetterView" owner:nil options:nil] firstObject];
        _letterView.frame = WINDOW.bounds;
        CGFloat he = 90 * (SCREEN_WIDTH / 375);
        _letterView.y = he + 60.0;
        _letterView.delegate = self;
        _letterView.height = SCREEN_HEIGHT - _letterView.y;
        _letterView.hidden = YES;
    }
    return _letterView;
}

- (void) selectLetter:(NSString *)letter
{
    NSLog(@"letter: %@", letter);
    
    _view_empty.hidden = YES;
    
    _nameBtn.selected = NO;
    
    [_nameBtn setTitle:letter forState:UIControlStateNormal];
    
    if([letter isEqualToString:@"全部"])
    {
        letter = @"";
    }
    
    _letter = letter;

    [_mainTable.header beginRefreshing];

}

- (void)selectSubCategory:(NSDictionary *)info
{
    NSLog(@"selectSubCategory");
    
    _view_empty.hidden = YES;

    _categoryBtn.selected = NO;
    
    NSString * title = [info objectForKey:@"selectedName"];
    
    _catid = [info objectForKey:@"selectedCateId"];
    
    [_categoryBtn setTitle:title forState:UIControlStateNormal];
    
    [_mainTable.header beginRefreshing];

}

- (IBAction)navbar_clicked:(id)sender
{
    NSInteger tag = ((UIButton *)sender).tag;
    
    [UICommon navBarClicked:self.navigationController tag:tag shareModel:_shareModel];
}


@end
