//
//  CYGiftListViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYGiftListViewController.h"
#import "CYGiftCollectionViewCell.h"
#import "CYSelectGiftViewController.h"
@interface CYGiftListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CYGiftCollectionViewCellDelegate>
{
    NSMutableArray *_dataArr;
    NSMutableArray *_selectArr;
    NSInteger page;
    NSInteger num;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)goback:(id)sender;
- (IBAction)submit_click:(id)sender;
@property (weak, nonatomic) IBOutlet CYBorderButton *submitBtn;

@end

@implementation CYGiftListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    num = 0;
    _dataArr = [[NSMutableArray alloc] init];
    [self.collectionView registerClass:[CYGiftCollectionViewCell class] forCellWithReuseIdentifier:giftIdentify];
    self.collectionView.collectionViewLayout = [self settingLayout];
    _selectArr = [[NSMutableArray alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

            [weakSelf loadCollecationData:NO];
        
    }];
    [_collectionView.header beginRefreshing];
    
    
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        [weakSelf loadCollecationData:YES];
        
    }];
    
//    //self.barStyle = NavBarStyleNoneMore;
    

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
    [_selectArr removeAllObjects];
    [_dataArr removeAllObjects];
    num = 0;
    [_submitBtn setTitle:@"提交（0）" forState:UIControlStateNormal];
    [self loadCollecationData:NO];
}


- (void)loadCollecationData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        [_dataArr removeAllObjects];
        page =1;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"Giveaway" parametes:@{@"p":@(page),@"pageSize":@"15"} success:^(id responObj) {
        if (loadMore) {
            [_dataArr addObjectsFromArray:[CYGiftModel objectArrayWithKeyValuesArray:responObj]];
            [_collectionView reloadData];
              [weakSelf.collectionView.footer endRefreshing];
        }else{
            [_dataArr removeAllObjects];
            [_dataArr addObjectsFromArray:[CYGiftModel objectArrayWithKeyValuesArray:responObj]];
            //
            //        // 结束刷新
            [weakSelf.collectionView.header endRefreshing];
        }
        
        if ([_dataArr count]<15) {
            weakSelf.collectionView.footer= nil;
        }
        
        [weakSelf.collectionView reloadData];
        
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.collectionView.footer endRefreshing];
        }else{
            [weakSelf.collectionView.header endRefreshing];
        }    }];
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
    CGSize itemSize = CGSizeMake(ItemW, ItemH+115);
    layout.itemSize = itemSize;
    return layout;
    
}


#pragma mark -
#pragma mark UICollectionViewDataSource method

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArr count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYGiftCollectionViewCell *cell = [CYGiftCollectionViewCell cellWithCollectionView:collectionView ItemAtIndexPath:indexPath];
    cell.delegate = self;
    CYGiftModel *merchModel = _dataArr[indexPath.item];
    cell.merchModel = merchModel;
    return cell;
}
#pragma mark -
#pragma mark CYGiftCollectionViewCellDelegate method
- (void)selectiftCell:(CYGiftCollectionViewCell *)cell WithModel:(CYGiftModel *)model
{
    num ++;
    if (num >=4) {
        [Itost showMsg:@"礼品最多选择三个！" inView:self.view];
        return;
    }
    
    
    NSString *title = [NSString stringWithFormat:@"提交（%d）",(int)num];
    [_submitBtn setTitle:title forState:UIControlStateNormal];
    
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:model forKey:@"gift"];
    [info setObject:indexPath forKey:@"index"];
    [info setObject:@(1) forKey:@"giftNum"];
    for (int i = 0; i<[_selectArr count]; i++) {
        NSDictionary *dic = _selectArr[i];
        NSIndexPath *index = dic[@"index"];
        if (index.item == indexPath.item) {
            NSInteger giftnum = [[dic objectForKey:@"giftNum"] integerValue];
            giftnum ++;
            [info setObject:@(giftnum) forKey:@"giftNum"];
            [_selectArr replaceObjectAtIndex:i withObject:info];
            return;
        }
    }
    
    if (model) {
       [_selectArr addObject:info];
    }
    
    
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit_click:(id)sender {
    CYSelectGiftViewController *vc = viewControllerInStoryBoard(@"CYSelectGiftViewController", @"TeaMall");
    vc.selectArr = _selectArr;
    vc.orderSn = _orderSign;
    [self.navigationController pushViewController:vc animated:YES];

}
@end
