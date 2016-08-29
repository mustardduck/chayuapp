//
//  CYArticleListViewController.m
//  茶语
//
//  Created by 李峥 on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYArticleListViewController.h"
#import "CYArticleDetailViewController.h"
#import "CYBBSTitleView.h"

typedef NS_ENUM(NSInteger, SortType) {
    SortType_new = 1,
    SortType_hot = 2,
};

@interface CYArticleListViewController ()

@property (weak, nonatomic) IBOutlet UIView *mToolsView;
@property (nonatomic, strong) NSArray *mCatList;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@property (nonatomic, strong) NSDictionary *mSelectCatData;
@property (nonatomic ,strong) UIButton *lastSelectedBtn;

@property (nonatomic, assign) SortType mSort;

@end

@implementation CYArticleListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (NSArray *)mCatList
{
    if (_mCatList == nil) {
        _mCatList = @[@{@"name":@"乐茶",@"catid":@"2"},
                      @{@"name":@"赏器",@"catid":@"1"},
                      @{@"name":@"茶旅",@"catid":@"5"},
                      @{@"name":@"文化",@"catid":@"3"},
                      @{@"name":@"专题",@"catid":@"24"},
                      @{@"name":@"新闻",@"catid":@"20"}];
    }
    
    return _mCatList;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"文章列表"];
       [self reloadData];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"文章列表"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.mSort = 1;

    AppDelegate *applegate = APP_DELEGATE;
    applegate.searchType = CYSearchTypeArticle;
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"最新", @"最热"]];
    segment.frame = CGRectMake(0, 0, 135, 30);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.],NSFontAttributeName,nil];
    [segment setTitleTextAttributes:dic forState:UIControlStateSelected];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:MAIN_COLOR,NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.],NSFontAttributeName,nil];
    [segment setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    segment.tintColor = MAIN_COLOR;
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    
    
    [self initCatView];
//    [self reloadData];
}

- (void)segmentValueChanged:(UISegmentedControl *)segment
{
    self.mSort = segment.selectedSegmentIndex + 1;
    [self reloadData];
 
}

- (void)initCatView
{
    if (self.mCatList.count > 0) {
        self.mSelectCatData = [self.mCatList firstObject];
    }else
    {
        return;
    }
    
    CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width/5;
    
    for (NSInteger i = 0; i < self.mCatList.count; i++) {
        NSDictionary *dict = [self.mCatList objectAtIndex:i];
        
        UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sortBtn.frame = CGRectMake(i*btnWidth, 0, btnWidth, CGRectGetHeight(self.mScrollView.frame));
        [sortBtn setTitle:[dict objectForKey:@"name"] forState:UIControlStateNormal];
        [sortBtn setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [sortBtn setTitleColor:RGB(137, 62, 32) forState:UIControlStateSelected];
        sortBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        sortBtn.tag = 100+i;
        [sortBtn addTarget:self action:@selector(clickSort:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            sortBtn.selected = YES;
            self.lastSelectedBtn = sortBtn;
        }
        [self.mScrollView addSubview:sortBtn];
    }
    
    [self.mScrollView setContentSize:CGSizeMake(btnWidth * self.mCatList.count, 0)];
}

- (void)clickSort:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (self.lastSelectedBtn == btn) {
        return;
    }
    self.lastSelectedBtn.selected = NO;
    btn.selected = YES;
    self.lastSelectedBtn = btn;
    
    NSDictionary *dict = [self.mCatList objectAtIndex:[sender tag] - 100];
    
    self.mSelectCatData = dict;
    
    [self reloadData];
}

- (void)reloadData
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:@(_mSort) forKey:@"type"];
    [param setObject:[self.mSelectCatData objectForKey:@"catid"] forKey:@"catid"];

    [self initListAction:@"ArticleList" params:param];
}

- (NSString *)cellNibName
{
    return @"CYArticleListCell";
}

- (CGFloat)cellHeight
{
    return 95;
}

- (void)tableViewApperDidClicked:(id)data
{
    CYArticleDetailViewController *vc = [[CYArticleDetailViewController alloc] initWithNibName:@"CYArticleDetailViewController" bundle:nil];
    vc.mArticleInfo = data;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
