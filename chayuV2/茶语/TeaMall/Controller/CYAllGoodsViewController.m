//
//  CYAllGoodsViewController.m
//  茶语
//
//  Created by Chayu on 16/5/9.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYAllGoodsViewController.h"
#import "CYMerchCollectionCell.h"
#import "CYFilterView.h"
#import "CYProductDetViewController.h"
#import "CYSpecificationView.h"
#import "CYTopMenuView.h"
#import "CYFenLeiListView.h"
#import "CYTeaCategoryInfo.h"
#import "CYShiJiFenLeiView.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
@interface CYAllGoodsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CYFilterViewDelegate,UISearchBarDelegate>
{
    NSInteger page;
    UISearchBar *search;
    NSMutableDictionary *paramDict;
    NSString *zonghePaixu;
    NSMutableArray *category_list;
    NSMutableArray *seller_list;
    NSMutableArray *price_list;
    NSMutableArray *order_list;
    
    OSMessage * _shareMsg;
}

@property (nonatomic,strong)NSMutableArray *categories;
@property (weak, nonatomic) IBOutlet UICollectionView *collecationView;

- (IBAction)goback:(id)sender;

@property (nonatomic,strong)CYTopMenuView *topView;


@property (strong,nonatomic)CYFenLeiListView *jiageView;

@property (nonatomic, strong)CYFenLeiListView *shangjiaView;


@property (nonatomic, strong)CYFenLeiListView *paixuView;

@property (nonatomic,strong)CYShiJiFenLeiView *fenleiView;

@end

@implementation CYAllGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    category_list = [NSMutableArray array];
    _shareMsg = [[OSMessage alloc] init];
    
    seller_list = [NSMutableArray array];
    price_list = [NSMutableArray array];
    order_list = [NSMutableArray array];
    page = 1;
    [self.view addSubview:self.topView];
    paramDict = [[NSMutableDictionary alloc] init];
    [self.collecationView registerClass:[CYMerchCollectionCell class] forCellWithReuseIdentifier:merchIdentify];
    self.collecationView.collectionViewLayout = [self settingLayout];
    //self.barStyle = NavBarStyleNoneMore;
    [paramDict setObject:@"shard" forKey:@"order"];
    [paramDict setObject:@"" forKey:@"price"];
    [paramDict setObject:@"" forKey:@"catid"];
    if (_catId.length >0) {
        [paramDict setObject:_catId forKey:@"catid"];
    }
    
    [paramDict setObject:@"" forKey:@"seller"];
    __weak __typeof(self) weakSelf = self;
    _collecationView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf conditionsinquiry:NO];
    }];
    [_collecationView.header beginRefreshing];
    
    
    _collecationView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf conditionsinquiry:YES];
    }];
    
    
    NSArray *menuArr = @[@{@"name":@"分类"},@{@"name":@"商家"},@{@"name":@"价格"},@{@"name":@"排序"}];
    [self.topView initwithMen:menuArr];
    [self GoodsListgetSearchBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}

-(void)GoodsListgetSearchBanner
{

    [self.view addSubview:self.fenleiView];
    [self.view addSubview:self.shangjiaView];
    [self.view addSubview:self.jiageView];
    [self.view addSubview:self.paixuView];
    
    __weak __typeof(self) weakSelf = self;
    weakSelf.topView.buttonSelectIndex = ^(NSInteger selindex){
        switch (selindex) {
            case 0:
            {
                weakSelf.fenleiView.hidden = !weakSelf.fenleiView.hidden;
                weakSelf.shangjiaView.hidden = YES;
                weakSelf.paixuView.hidden = YES;
                weakSelf.jiageView.hidden = YES;
                break;
            }
            case 1:
            {
                weakSelf.shangjiaView.hidden = !weakSelf.shangjiaView.hidden;
                weakSelf.jiageView.hidden = YES;
                weakSelf.paixuView.hidden = YES;
                weakSelf.fenleiView.hidden = YES;
                break;
            }
            case 2:
            {
                weakSelf.jiageView.hidden = !weakSelf.jiageView.hidden;
                weakSelf.shangjiaView.hidden = YES;
                weakSelf.paixuView.hidden = YES;
                 weakSelf.fenleiView.hidden = YES;
                break;
            }
            case 3:
            {
                weakSelf.paixuView.hidden = !weakSelf.paixuView.hidden;
                weakSelf.jiageView.hidden = YES;
                weakSelf.shangjiaView.hidden = YES;
                 weakSelf.fenleiView.hidden = YES;
                break;
            }
                
            default:
                break;
        }
    };

    [CYWebClient Post:@"2.0_GoodsList.getSearchBanner" parametes:nil success:^(id responObj) {
        NSArray *catArr =[CYTeaCategoryInfo objectArrayWithKeyValuesArray:[responObj objectForKey:@"category_list"]];
        [category_list addObjectsFromArray:catArr];
        [seller_list addObjectsFromArray:[responObj objectForKey:@"seller_list"]];
        [price_list addObjectsFromArray:[responObj objectForKey:@"price_list"]];
        [order_list addObjectsFromArray:[responObj objectForKey:@"order_list"]];
        weakSelf.jiageView.dataArr = price_list;
        weakSelf.shangjiaView.dataArr = seller_list;
        weakSelf.paixuView.dataArr = order_list;
        weakSelf.fenleiView.dataArr = category_list;
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
    
    weakSelf.fenleiView.shijiCateBlock = ^(CYTeaChildCategoryInfo *info){
    
          weakSelf.fenleiView.hidden = YES;
        weakSelf.topView.selectIndexButtonTag = 0;
        
        if (!info) {
            [paramDict setObject:@"0" forKey:@"catid"];
            
        }else{
            [paramDict setObject:info.catid forKey:@"catid"];
        }
        [weakSelf conditionsinquiry:NO];

    };
    
    weakSelf.jiageView.shijiCateBlock = ^(NSDictionary *info){
        weakSelf.jiageView.hidden = YES;
         weakSelf.topView.selectIndexButtonTag = 1;
        [paramDict setObject:[info objectForKey:@"data"] forKey:@"price"];
         [weakSelf conditionsinquiry:NO];
    };
    weakSelf.paixuView.shijiCateBlock = ^(NSDictionary *info){
        weakSelf.paixuView.hidden = YES;
         weakSelf.topView.selectIndexButtonTag = 3;
        [paramDict setObject:[info objectForKey:@"data"] forKey:@"order"];
         [weakSelf conditionsinquiry:NO];
    };
    weakSelf.shangjiaView.shijiCateBlock = ^(NSDictionary *info){
        weakSelf.shangjiaView.hidden = YES;
         weakSelf.topView.selectIndexButtonTag = 2;
         [paramDict setObject:[info objectForKey:@"data"] forKey:@"gid"];
      
        [weakSelf conditionsinquiry:NO];
    };
    

    
    
    
    
}

- (CYTopMenuView *)topView
{
    if (!_topView) {
        _topView =[[CYTopMenuView alloc] initWithFrame:CGRectMake(0,90*SCREENBILI, SCREEN_WIDTH,60)];
    }
    return _topView;
}


- (CYFenLeiListView *)jiageView
{
    if (!_jiageView) {
        _jiageView = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiListView" owner:nil options:nil] firstObject];
        _jiageView.frame = CGRectMake(0,90*SCREENBILI+60,SCREEN_WIDTH,SCREEN_HEIGHT-90*SCREENBILI-60);
        _jiageView.hidden = YES;
        _jiageView.isTitle = YES;
    }
    return _jiageView;
}

- (CYFenLeiListView *)paixuView
{
    if (!_paixuView) {
        _paixuView = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiListView" owner:nil options:nil] firstObject];
        _paixuView.frame = CGRectMake(0,90*SCREENBILI+60,SCREEN_WIDTH,SCREEN_HEIGHT-90*SCREENBILI-60);
        _paixuView.hidden = YES;
        _paixuView.isTitle = YES;
        
    }
    return _paixuView;
}

- (CYFenLeiListView *)shangjiaView
{
    if (!_shangjiaView) {
        _shangjiaView = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiListView" owner:nil options:nil] firstObject];
        _shangjiaView.frame = CGRectMake(0,90*SCREENBILI+60,SCREEN_WIDTH,SCREEN_HEIGHT-90*SCREENBILI-60);
        _shangjiaView.hidden = YES;
        _shangjiaView.isTitle = YES;
        
    }
    return _shangjiaView;
}

- (CYShiJiFenLeiView *)fenleiView
{
    if (!_fenleiView) {
        _fenleiView = [[[NSBundle mainBundle] loadNibNamed:@"CYShiJiFenLeiView" owner:nil options:nil] firstObject];
        _fenleiView.frame = CGRectMake(0,90*SCREENBILI+60,SCREEN_WIDTH,SCREEN_HEIGHT-90*SCREENBILI-60);
        _fenleiView.hidden = YES;
        
    }
    return _fenleiView;
}
/**
 *  条件查询
 */
-(void)conditionsinquiry:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        
        page = 1;
    }
    [paramDict setValue:@(page) forKey:@"p"];
    [paramDict setValue:@"20" forKey:@"pageSize"];
    __weak __typeof(self) weakSelf = self;
    [CYWebClient basePost:@"GoodsList" parametes:paramDict success:^(id responObj)
     {
         
         NSInteger state = [[responObj objectForKey:@"state"] integerValue];
         NSArray *data = [responObj objectForKey:@"data"];
         if (state == 400) {
             NSDictionary * shareInfo = [responObj objectForJSONKey:@"share"];
             if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
                 _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
                 _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
                 _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
                 _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
             }
             
            if (loadMore) {
                [weakSelf.categories addObjectsFromArray:[CYMerchCellModel objectArrayWithKeyValuesArray:data]];
                [weakSelf.collecationView reloadData];
                [weakSelf.collecationView.footer endRefreshing];
                
            }else{
                [weakSelf.categories removeAllObjects];
                [weakSelf.categories addObjectsFromArray:[CYMerchCellModel objectArrayWithKeyValuesArray:data]];
                [weakSelf.collecationView reloadData];
                [weakSelf.collecationView.header endRefreshing];
            }
            if ([data count]<20) {
                  [weakSelf.collecationView.footer endRefreshingWithNoMoreData];
            }else{
                 [weakSelf.collecationView.footer resetNoMoreData];
            }

            if ([weakSelf.categories count]<20) {
                weakSelf.collecationView.footer = nil;
            }
         }
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.collecationView.footer endRefreshing];
        }else{
            [weakSelf.collecationView.header endRefreshing];
        }
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark 设置布局
- (UICollectionViewFlowLayout *)settingLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置间距
    CGFloat spacing = 5;
    layout.minimumLineSpacing = spacing;
    layout.minimumInteritemSpacing = spacing;
    layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, 0, spacing); // 上部内边距
    
    CGFloat ItemW = (SCREEN_WIDTH - spacing) / 2 - spacing;
    CGFloat ItemH = ItemW;
    CGSize itemSize = CGSizeMake(ItemW, ItemH+90);
    layout.itemSize = itemSize;
    return layout;
    
}

-(NSMutableArray *)categories
{
    if(!_categories){
        self.categories = [[NSMutableArray alloc]init];
    }
    return _categories;
}

#pragma mark -
#pragma mark UICollectionViewDataSource method

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categories.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYMerchCollectionCell *cell = [CYMerchCollectionCell cellWithCollectionView:collectionView ItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.backgroundColor = MAIN_BGCOLOR;
    CYMerchCellModel *merchModel = self.categories[indexPath.item];
    cell.merchModel = merchModel;
    return cell;
}


#pragma mark -
#pragma mark UICollectionViewDelegate method
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYMerchCellModel *info = self.categories[indexPath.item];
    CYProductDetViewController *vc= viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    vc.goodId = info.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark CYFilterViewDelegate method
-(void)hidden{

}
-(void)selectWithData:(NSDictionary *)info
{
    
    [paramDict setObject:@"shard" forKey:@"order"];
    //    if (_catid) {
    //        [paramDict setObject:_catid forKey:@"catid"];
    //    }
    
//    [paramDict setObject:@"" forKey:@"catid"];
    
    NSString *catidStr = [info objectForKey:@"catid"];
    if (catidStr) {
        [paramDict setObject:catidStr forKey:@"catid"];
    }
    [paramDict setObject:[info objectForKey:@"price"] forKey:@"price"];
    [paramDict setObject:[info objectForKey:@"seller"] forKey:@"seller"];
    [self hidden];
    [self conditionsinquiry:NO];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [search resignFirstResponder];
 
    [paramDict setObject:searchBar.text forKey:@"q"];
    [self conditionsinquiry:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
