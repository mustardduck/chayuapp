//
//  CYMasterListViewController.m
//  TeaMall
//
//  Created by Chayu on 15/10/22.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMasterListViewController.h"
#import "CYMasterCell.h"
//#import "CYHomeCell.h"
#import "CYMasterDetailViewController.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
#import "CYBuyerAllCategoryView.h"
#import "CYBuyerAllLetterView.h"
@interface CYMasterListViewController ()<UITableViewDataSource,UITableViewDelegate,CYBuyerAllCategoryViewDelegate, CYBuyerAllLetterViewDelegate>
{
    BOOL topmenushow;
    NSInteger gid; //大师 9， 名家10
    NSInteger page;
    NSArray *searchTitle;
    NSMutableArray *allData;
    NSString *selectWord;
    
    OSMessage * _shareMsg;
    
    NSString * _catid;
    NSString * _letter;
    NSMutableArray *fenleiArr;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic, strong) CYBuyerAllCategoryView * categoryView;
@property (nonatomic, strong) CYBuyerAllLetterView * letterView;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;

@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *emptyView;


@end

@implementation CYMasterListViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
    hiddenSepretor(_tableView);
    fenleiArr = [NSMutableArray array];
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.letterView];
    
    _shareMsg = [[OSMessage alloc] init];
    _catid = @"";
    _letter = @"";
    page = 1;
    selectWord = @"#";
    allData = [[NSMutableArray alloc] init];
    if (_type == CYSellerTypeHandmade) {
        gid = 10;
    }else{
        gid = 9;
    }
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];
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


- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
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


- (void) selectLetter:(NSString *)letter
{
    NSLog(@"letter: %@", letter);
    
    //    _view_empty.hidden = YES;
    
    _nameBtn.selected = NO;
    
    [_nameBtn setTitle:letter forState:UIControlStateNormal];
    
    if([letter isEqualToString:@"全部"])
    {
        letter = @"";
    }
    
    _letter = letter;
    [self loadTableViewData:NO];
    //    [_mainTable.header beginRefreshing];
    
}

- (void)selectSubCategory:(NSDictionary *)info
{
    NSLog(@"selectSubCategory");
    
    //    _view_empty.hidden = YES;
    
    _categoryBtn.selected = NO;
    
    NSString * title = [info objectForKey:@"selectedName"];
    
    _catid = [info objectForKey:@"selectedCateId"];
    
    [_categoryBtn setTitle:title forState:UIControlStateNormal];
    
    [self loadTableViewData:NO];
    //    [_mainTable.header beginRefreshing];
    
}




-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    topmenushow = NO;
    [MobClick beginLogPageView:self.title];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

/**
 *  加载页面数据
 */
-(void)loadTableViewData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        page =1;
        [self.dataArr removeAllObjects];
        [_tableView reloadData];
    }
    
    __weak __typeof(self) weakSelf = self;
    [CYWebClient basePost:@"SellerList" parametes:@{@"gid":@(gid),@"p":@(page),@"pageSize":@"10",@"catid":_catid,@"letter":_letter} success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        NSArray *data = [responObj objectForKey:@"data"];
        //        NSArray *categort_list = [responObj objectForKey:@"categort_list"];
        //        if (categort_list.count>0) {
        //            [fenleiArr removeAllObjects];
        //            [fenleiArr addObject:categort_list];
        //            self.categoryView.cateArr = fenleiArr;
        //            self.categoryView.isShiji = YES;
        //        }
        if (state == 400) {
            NSDictionary * shareInfo = [responObj objectForJSONKey:@"share"];
            if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
                _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
                _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
                _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
                _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
            }
            if (loadMore) {
                [weakSelf.tableView.footer endRefreshing];
            }else{
                [weakSelf.tableView.header endRefreshing];
            }
            NSArray *arr = data;
            if ([arr count]<10) {
                weakSelf.tableView.footer = nil;
                
            }else{
                _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf loadTableViewData:YES];
                }];
            }
            
            [weakSelf.dataArr addObjectsFromArray:[CYMasterCellModel objectArrayWithKeyValuesArray:arr]];
            [weakSelf.tableView reloadData];
            
            if (weakSelf.dataArr.count == 0) {
                _emptyView.hidden = NO;
            }else{
                _emptyView.hidden = YES;
            }
        }
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
    }];
    
    
}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height =MASTERCELL_HEIGHT*(SCREEN_WIDTH/320.);
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMasterCell *cell = [CYMasterCell cellWidthTableView:tableView];
    CYMasterCellModel *model = nil;
    model = self.dataArr[indexPath.row];
    cell.masterModel = model;
    if (gid == 9) {
        cell.isMaster = YES;
    }else{
        cell.isMaster = NO;
    }
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CYMasterCellModel *model = _dataArr[indexPath.row];;
    
    
    CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
    if (gid == 9) {
        vc.isMaster = YES;
    }else{
        vc.isMaster = NO;
    }
    
    vc.uid = model.sellerUid;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)gotousercenter_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)sousuo_click:(id)sender {
    CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)navbar_clicked:(id)sender
{
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
    
}

@end
