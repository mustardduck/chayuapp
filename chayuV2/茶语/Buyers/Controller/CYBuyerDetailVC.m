//
//  CYBuyerDetailVC.m
//  茶语
//
//  Created by Leen on 16/6/15.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerDetailVC.h"
#import "CYMerchCollectionCell.h"
#import "CYBuyerDetailReusableView.h"
#import "CYBuyerDetailInfo.h"
#import "CYBuyerPDCellModel.h"
#import "CYProductDetViewController.h"
#import "UICommon.h"
#import "CYShareModel.h"

@interface CYBuyerDetailVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate, CYBuyerDetailReusableViewDelegate>
{
    CGFloat flag;//是否旋转了
    NSInteger page;
    UISearchBar *search;
    NSMutableDictionary *paramDict;
    NSString *zonghePaixu;
    
    CGFloat _sectionHeaderHeight;
    NSString * _order;
}

@property (nonatomic,strong)NSMutableArray *categories;
@property (weak, nonatomic) IBOutlet UICollectionView *collecationView;
@property (nonatomic,strong)CYBuyerDetailInfo *detailInfo;
@property (nonatomic,strong)CYBuyerDetailReusableView *header;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

- (IBAction)goback:(id)sender;

//- (IBAction)tiaojianshaixuan_click:(id)sender;

@end

@implementation CYBuyerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_collecationView registerNib:[UINib nibWithNibName:@"CYBuyerDetailReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYBuyerDetailReusableView"];
    
    CGFloat wapThumbHe = SCREEN_WIDTH * 187 / 375;
    
    CGFloat he = 457 - 187 + wapThumbHe;
    
    _sectionHeaderHeight = he;
    
    _order = @"all";
    
    [self loadData];
    
    page = 1;
    paramDict = [[NSMutableDictionary alloc] init];
    [self.collecationView registerClass:[CYMerchCollectionCell class] forCellWithReuseIdentifier:merchIdentify];
    self.collecationView.collectionViewLayout = [self settingLayout];
    //    self.barStyle = NavBarStyleNoneMore;
    
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
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

-(void)loadData
{
    [CYWebClient Post:@"mingxing_detail" parametes:@{@"seller_uid":_seller_uid} success:^(id responObject) {
        
        self.detailInfo = [CYBuyerDetailInfo objectWithKeyValues:responObject];
        
        _titleLbl.text = _detailInfo.realname;
        
        [_collecationView.header endRefreshing];
        
    } failure:^(id error) {
        [_collecationView.header endRefreshing];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"茗星详情"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"茗星详情"];
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
    [paramDict setObject:_order forKey:@"order"];
    [paramDict setObject:_seller_uid forKey:@"seller_uid"];
    [paramDict setValue:@(page) forKey:@"p"];
    [paramDict setValue:@"20" forKey:@"pageSize"];
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"sixiang_list" parametes:paramDict success:^(id responObj) {
        if (loadMore) {
            [weakSelf.categories addObjectsFromArray:[CYBuyerPDCellModel objectArrayWithKeyValuesArray:responObj]];
            [weakSelf.collecationView reloadData];
            [weakSelf.collecationView.footer endRefreshing];
            
        }else{
            [weakSelf.categories removeAllObjects];
            [weakSelf.categories addObjectsFromArray:[CYBuyerPDCellModel objectArrayWithKeyValuesArray:responObj]];
            [weakSelf.collecationView reloadData];
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
        
        
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.collecationView.footer endRefreshing];
        }else{
            [weakSelf.collecationView.header endRefreshing];
        }
    }];
}

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

- (void)dropBtnClicked:(UIButton *)sender
{
    UIButton * btn = (UIButton *)sender;
    
    CGFloat wapThumbHe = SCREEN_WIDTH * 187 / 375;
    
    CGFloat he = 457 - 187 + wapThumbHe;
    
    _sectionHeaderHeight = btn.selected ?  he + _header.webHeightCons.constant : he;
    
    [_collecationView reloadData];
}

- (void)shareBtnClicked
{
    
    CYShareModel * model = [[CYShareModel alloc] init];
    model.shareUrl = _detailInfo.shareUrl;
    model.shareImg = _detailInfo.shareImg;
    model.shareTitle = _detailInfo.shareTitle;
    model.shareDesc = _detailInfo.shareDesc;
    if (model.shareUrl.length>0) {
        [UICommon shareGoods:model];
    }
    
}

- (void)followBtnClicked
{
    
}

- (void)allBtnClicked
{
    _order = @"all";
    
    [self conditionsinquiry:NO];
    
}

- (void)popularBtnClicked
{
    _order = @"mhot";
    
    [self conditionsinquiry:NO];
    
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
    CYBuyerPDCellModel *merchModel = self.categories[indexPath.item];
    cell.PDCellModel = merchModel;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, _sectionHeaderHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        _header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYBuyerDetailReusableView" forIndexPath:indexPath];
        _header.delegate = self;
        
        _header.detailInfo = _detailInfo;
        
        __weak __typeof(self) weakSelf = self;
        
        _header.seeFullBlock = ^()
        {
            NSMutableArray * imgArr = [NSMutableArray array];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            [dic setObject:weakSelf.detailInfo.wap_thumb forKey:@"PictureUrl"];
            [imgArr addObject:dic];
            
            [UICommon seeFullScreenImage:weakSelf.navigationController imageUrlArr:imgArr currentPage:0];
        };
        
        return _header;
    }
    return nil;
}

#pragma mark -
#pragma mark UICollectionViewDelegate method
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerPDCellModel *info = self.categories[indexPath.item];
    CYProductDetViewController *vc= viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    vc.goodId = info.goods_id;
    //    vc.goodId = @"10013";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
