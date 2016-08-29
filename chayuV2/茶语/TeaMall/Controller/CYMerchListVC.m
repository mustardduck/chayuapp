//
//  CYMerchListVC.m
//  TeaMall
//
//  Created by Chayu on 15/10/22.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMerchListVC.h"
#import "CYMerchCollectionCell.h"
#import "CYFilterView.h"
#import "CYProductDetViewController.h"
#import "CYSpecificationView.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
@interface CYMerchListVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CYFilterViewDelegate,UISearchBarDelegate>
{
    CGFloat flag;//是否旋转了
    NSInteger page;
    UISearchBar *search;
    NSMutableDictionary *paramDict;
    
    OSMessage * _shareMsg;
}
@property (nonatomic,strong)NSMutableArray *categories;
@property (weak, nonatomic) IBOutlet UICollectionView *collecationView;
@property (weak, nonatomic) IBOutlet UIImageView *priceImg;

- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *filterImg;

@property (nonatomic,strong)CYFilterView *filterView;
	
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line_horizon_cons;



@end

@implementation CYMerchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _shareMsg = [[OSMessage alloc] init];
    page = 1;
    paramDict = [[NSMutableDictionary alloc] init];
    [self.collecationView registerClass:[CYMerchCollectionCell class] forCellWithReuseIdentifier:merchIdentify];
    self.collecationView.collectionViewLayout = [self settingLayout];
    //self.barStyle = NavBarStyleNoneMore;
    [paramDict setObject:@"zhpx_desc" forKey:@"order"];
    [paramDict setObject:@"" forKey:@"price"];
    [paramDict setObject:@"" forKey:@"catid"];
    [paramDict setObject:@"" forKey:@"seller"];
//    if (_searchTitle.length) {
//         [paramDict setValue:_searchTitle forKey:@"q"];
//    }else{
//        [paramDict setValue:@"" forKey:@"q"];
//    }
   
    if (_catid.length) {
        [paramDict setObject:_catid forKey:@"catid"];
    }
    
    
 
     __weak __typeof(self) weakSelf = self;
    _collecationView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf conditionsinquiry:NO];
    }];
    [_collecationView.header beginRefreshing];
    
    
    _collecationView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf conditionsinquiry:YES];
    }];
    
    flag = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

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




-(void)creatSearchView
{
    /**
     *  搜索框
     */
    search = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40)];
    search.width = screen_width-80;
    search.backgroundColor = [UIColor clearColor];
    search.placeholder = @"请输入您要搜索的商品";
    if (_searchTitle && _searchTitle.length) {
        search.text = _searchTitle;
        [search becomeFirstResponder];
    }
    search.delegate = self;
    self.navigationItem.titleView = search;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  关键字搜索
 */
-(void)loadCollecationData:(BOOL)loadMore
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_searchTitle forKey:@"q"];
    [param setObject:@"20" forKey:@"pageSize"];
    if (loadMore) {
        page ++;
    }else{
        [self.categories removeAllObjects];
        page =1;
    }
    [param setValue:@(page) forKey:@"p"];
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"GoodsSearch" parametes:param success:^(id responObj) {
        if (loadMore) {
            [weakSelf.categories addObjectsFromArray:[CYMerchCellModel objectArrayWithKeyValuesArray:responObj]];
            [weakSelf.collecationView.footer endRefreshing];
        }else{
            [weakSelf.categories removeAllObjects];
            [weakSelf.categories addObjectsFromArray:[CYMerchCellModel objectArrayWithKeyValuesArray:responObj]];
            [weakSelf.collecationView.header endRefreshing];
        }
        if ([weakSelf.categories count]<10) {
            weakSelf.collecationView.footer = nil;
        }else{
            weakSelf.collecationView.footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                if (![weakSelf.searchTitle length]) {
                    [weakSelf conditionsinquiry:YES];
                }else{
                    [weakSelf loadCollecationData:YES];
                }
            }];
        }
        
        
        [weakSelf.collecationView reloadData];
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.collecationView.footer endRefreshing];
        }else{
            [weakSelf.collecationView.header endRefreshing];
        }
    }];
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
    [CYWebClient Post:@"GoodsList" parametes:paramDict success:^(id responObj) {
        
        NSDictionary * shareInfo = [responObj objectForJSONKey:@"share"];
        if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
            _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
            _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
            _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
            _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
        }
        
        if (loadMore) {
            [weakSelf.categories addObjectsFromArray:[CYMerchCellModel objectArrayWithKeyValuesArray:responObj]];
            [weakSelf.collecationView.footer endRefreshing];
            
        }else{
            [weakSelf.categories removeAllObjects];
            [weakSelf.categories addObjectsFromArray:[CYMerchCellModel objectArrayWithKeyValuesArray:responObj]];
            [weakSelf.collecationView.header endRefreshing];
        }
        
        
        if ([responObj count]<20) {
            [weakSelf.collecationView.footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.collecationView.footer resetNoMoreData];
        }
        
        if ([weakSelf.categories count]<20) {
            weakSelf.collecationView.footer = nil;
        }
        
        [weakSelf.collecationView reloadData];
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.collecationView.footer endRefreshing];
        }else{
            [weakSelf.collecationView.header endRefreshing];
        }
    }];
}
- (CYFilterView *)filterView
{
    if (!_filterView) {
        _filterView = [[[NSBundle mainBundle] loadNibNamed:@"CYFilterView" owner:nil options:nil] firstObject];
        _filterView.frame = WINDOW.bounds;
        _filterView.y = 108.0f;
        _filterView.delegate = self;
        _filterView.height = SCREEN_HEIGHT -108;
        _filterView.hidden = YES;
    }
    return _filterView;
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
    [self.filterView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  顶部四个按钮点击事件
 */
- (IBAction)selectTopMenu_click:(UIButton *)sender {
      UIView *view = [self.view viewWithTag:1200];
    
    switch (sender.tag) {
        case 1500:
        {
            _priceImg.highlighted = NO;
            [paramDict setObject:@"zhpx_desc" forKey:@"order"];
            [paramDict setObject:@"" forKey:@"price"];
            [paramDict setObject:@"" forKey:@"catid"];
            [paramDict setObject:@"" forKey:@"seller"];
             [self conditionsinquiry:NO];
            break;
        }
        case 1501:
        {
            [paramDict setObject:@"salescount_desc" forKey:@"order"];
             [self conditionsinquiry:NO];
            break;
        }
        case 1502:
        {
            _priceImg.image = [UIImage imageNamed:@"arrow_both_down"];
             _priceImg.highlighted = !_priceImg.highlighted;
            if (_priceImg.highlighted) {
                  [paramDict setObject:@"pricesell_asc" forKey:@"order"];
            }else{
                 [paramDict setObject:@"pricesell_desc" forKey:@"order"];
            }
             [self conditionsinquiry:NO];
            break;
        }
        case 1503:
        {
            [self setImgTransform:!flag];
            flag = !flag;
          
        
            
            [WINDOW addSubview:self.filterView];
            if (_catid) {
              self.filterView.catId = _catid;
            }
            
            self.filterView.hidden = !self.filterView.hidden;
            break;
        }
            
        default:
            break;
    }
  
   
    for (int i =1500; i<1504; i++) {
      
        UIButton *btn = (UIButton *)[view viewWithTag:i];
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    _line_horizon_cons.constant = sender.x;
}
-(void)setImgTransform:(BOOL)trans
{
    if (trans) {
        [UIView animateWithDuration:0.25 animations:^{
            self.filterImg.transform = CGAffineTransformMakeRotation(-M_PI);
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.filterImg.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}
#pragma mark -
#pragma mark CYFilterViewDelegate method
-(void)hidden{
    self.filterView.hidden = !self.filterView.hidden;
    [self.filterView removeFromSuperview];
    [self setImgTransform:!flag];
    flag = !flag;
}
-(void)selectWithData:(NSDictionary *)info
{
    
    [paramDict setObject:@"zhpx_desc" forKey:@"order"];
//    if (_catid) {
//        [paramDict setObject:_catid forKey:@"catid"];
//    }
    
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
    _searchTitle = searchBar.text;
    [paramDict setObject:searchBar.text forKey:@"q"];
    [self conditionsinquiry:NO];
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
