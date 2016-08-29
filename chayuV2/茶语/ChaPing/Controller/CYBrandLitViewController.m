//
//  CYBrandLitViewController.m
//  茶语
//
//  Created by Chayu on 16/7/8.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBrandLitViewController.h"
#import "CYTopMenuView.h"
#import "CYHomeBrandCell.h"
#import "CYFenLeiListView.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
@interface CYBrandLitViewController ()<UITableViewDelegate,UITableViewDataSource>
{
  
    NSMutableArray *_dataArr;
    NSInteger page;
    NSMutableDictionary *params;

    OSMessage * _shareMsg;
}

- (IBAction)goback:(id)sender;

@property (nonatomic,strong)CYTopMenuView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)CYFenLeiListView *fenleiView;
@property (nonatomic,strong)CYFenLeiListView *orderView;
@property (nonatomic,strong)CYFenLeiListView *cateView;
@property (nonatomic,strong)CYFenLeiListView *nianfenView;
@end

@implementation CYBrandLitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _shareMsg = [[OSMessage alloc] init];
    
    page = 1;
    hiddenSepretor(_tableView);
    __weak __typeof(self) weakSelf = self;
    _dataArr = [NSMutableArray array];
    params = [NSMutableDictionary dictionary];
    [params setObject:@(1) forKey:@"p"];
    [params setObject:@"40" forKey:@"pagSize"];
    [params setObject:@"" forKey:@"bid"];
    [params setObject:@"" forKey:@"order"];
    [params setObject:@"" forKey:@"year"];
    if (_yearId.length>0) {
           [params setObject:_yearId forKey:@"bid"];
    }
    
    if (_orderId.length >0) {
         [params setObject:_orderId forKey:@"order"];
        
    }

    if (_year.length) {
         [params setObject:_year forKey:@"year"];
         [params setObject:@"2" forKey:@"order"];
    }
    [self creatFenLeiInfo];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

-(void)loadTableViewData:(BOOL)loadMore
{
     __weak __typeof(self) weakSelf = self;
    //获取榜单列表
    [CYWebClient basePost:@"2.0_top_Category" parametes:params success:^(id responObject) {
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        NSArray *data = [responObject objectForKey:@"data"];
        if (state == 400) {
            NSDictionary * shareInfo = [responObject objectForJSONKey:@"share"];
            if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
                _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
                _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
                _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
                _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
            }
            
            if (!loadMore) {
                [_dataArr removeAllObjects];
                [weakSelf.tableView reloadData];
            }
            if (loadMore) {
                [weakSelf.tableView.footer endRefreshing];
            }else{
                [weakSelf.tableView.header endRefreshing];
            }
            
            if ([data count]<40) {
                [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.tableView.footer resetNoMoreData];
            }
            
            if ([_dataArr count]<40) {
                weakSelf.tableView.footer = nil;
            }else{
                weakSelf.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf loadTableViewData:YES];
                }];
            }
            [_dataArr addObjectsFromArray:data];
            [weakSelf.tableView reloadData];
        }
  
        
    } failure:^(id error) {
        
    }];
    
   
    
}


- (CYTopMenuView *)topView
{
    if (!_topView) {
        _topView =[[CYTopMenuView alloc] initWithFrame:CGRectMake(0,90*SCREENBILI, SCREEN_WIDTH,60)];
    }
    return _topView;
}

- (CYFenLeiListView *)orderView
{
    if (!_orderView) {
        _orderView = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiListView" owner:nil options:nil] firstObject];
        _orderView.frame = CGRectMake(0,self.topView.height+self.topView.y,SCREEN_WIDTH,SCREEN_HEIGHT-(self.topView.height +self.topView.y));
        _orderView.hidden = YES;
    }
    return _orderView;
}

- (CYFenLeiListView *)cateView
{
    if (!_cateView) {
        _cateView = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiListView" owner:nil options:nil] firstObject];
        _cateView.frame = CGRectMake(0,self.topView.height+self.topView.y,SCREEN_WIDTH,SCREEN_HEIGHT-(self.topView.height +self.topView.y));
        _cateView.hidden = YES;
    }
    return _cateView;
}

- (CYFenLeiListView *)nianfenView
{
    if (!_nianfenView) {
        _nianfenView = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiListView" owner:nil options:nil] firstObject];
        _nianfenView.frame = CGRectMake(0,self.topView.height+self.topView.y,SCREEN_WIDTH,SCREEN_HEIGHT-(self.topView.height +self.topView.y));
         _nianfenView.hidden = YES;
    }
    return _nianfenView;
}


-(void)creatFenLeiInfo
{
    
     __weak __typeof(self) weakSelf = self;
    __block  NSInteger selectTop = -1;
    NSMutableArray *orderArr = [NSMutableArray array];
    NSMutableArray *teaCateArr = [NSMutableArray array];
    NSMutableArray *yearArr = [NSMutableArray array];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.cateView];
    [self.view addSubview:self.orderView];
    [self.view addSubview:self.nianfenView];
    weakSelf.nianfenView.selectCateBlock = ^(NSString *nameid,NSString *name){
        weakSelf.topView.selectTitle = name;
        weakSelf.topView.selectIndexButtonTag = selectTop;
        weakSelf.nianfenView.hidden = YES;
        [params setObject:nameid forKey:@"year"];
        [self loadTableViewData:NO];
    };
    weakSelf.orderView.selectCateBlock = ^(NSString *nameid,NSString *name){
        weakSelf.topView.selectTitle = name;
         weakSelf.orderView.hidden = YES;
        [params setObject:nameid forKey:@"order"];
        weakSelf.topView.selectIndexButtonTag = selectTop;
         [self loadTableViewData:NO];
    };
    weakSelf.cateView.selectCateBlock = ^(NSString *nameid,NSString *name){
        weakSelf.topView.selectTitle = name;
        weakSelf.cateView.hidden = YES;
        [params setObject:nameid forKey:@"bid"];
        weakSelf.topView.selectIndexButtonTag = selectTop;
         [self loadTableViewData:NO];
    };
    NSString *sectitle = @"茶类";
    if (_yearname.length >0) {
        sectitle = _yearname;
    }
    NSString *nianfenStr = @"年份";
    if (_year.length >0) {
        nianfenStr = _year;
    }
    NSArray *menuArr = @[@{@"name":_typeName},@{@"name":sectitle},@{@"name":nianfenStr}];
    [self creatkongNavBar];
    [self.topView initwithMen:menuArr];
    weakSelf.topView.buttonSelectIndex = ^(NSInteger selindex){
        switch (selindex) {
            case 0:
            {
                weakSelf.cateView.hidden = YES;
                weakSelf.nianfenView.hidden = YES;
                weakSelf.orderView.hidden = !weakSelf.orderView.hidden;
                break;
            }
            case 1:
            {
                weakSelf.orderView.hidden = YES;
                weakSelf.nianfenView.hidden = YES;
                weakSelf.cateView.hidden = !weakSelf.cateView.hidden;
                break;
            }
            case 2:
            {
                weakSelf.orderView.hidden = YES;
                weakSelf.cateView.hidden = YES;
                weakSelf.nianfenView.hidden = !weakSelf.nianfenView.hidden;
                break;
            }
                
            default:
                break;
        }
        selectTop  = selindex;
    };
    
    //获取分类 类型
    [CYWebClient Post:@"2.0_top_Category_queryCriteria" parametes:nil success:^(id responObject) {
        [orderArr addObjectsFromArray:[responObject objectForKey:@"order"]];
        [teaCateArr addObjectsFromArray:[responObject objectForKey:@"teaCate"]];
        [yearArr addObjectsFromArray:[responObject objectForKey:@"year"]];
        weakSelf.orderView.dataArr = orderArr;
        weakSelf.cateView.dataArr = teaCateArr;
        weakSelf.nianfenView.dataArr = yearArr;
        
    } failure:^(id error) {
        
    }];
    
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

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bandidentify = @"CYHomeBrandCell";
    CYHomeBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:bandidentify];
    NSDictionary *info = _dataArr[indexPath.row];
    
    cell.mNumberLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    cell.mTitleLabel.text = [NSString stringWithFormat:@"[%@]%@",[info objectForKey:@"brand"],[info objectForKey:@"title"]];
    cell.mScodeLabel.text = [info objectForKey:@"review_score"];
    cell.info = info;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = _dataArr[indexPath.row];
    CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
    vc.mTeaId = [info objectForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)gotousercenter_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)navbar_clicked:(id)sender
{
    [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
    
}

- (IBAction)sousuo_click:(id)sender {
    CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
    [self.navigationController pushViewController:vc animated:YES];
}
@end
