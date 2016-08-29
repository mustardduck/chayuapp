//
//  CYClassViewController.m
//  茶语
//
//  Created by Chayu on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYClassViewController.h"
#import "CYClassView.h"
#import "CYMerchListVC.h"
#import "CYMasterDetailViewController.h"
#import "CYTeaMallCollectionViewController.h"
#import "CYProductDetViewController.h"
#import "CYFenLeiCollectionCell.h"
#import "CYFenLeiTopView.h"
#import "CYTeaCategoryInfo.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
#import "CYWenZhangDetailsController.h"
#import "CYPublicAvtiveViewController.h"
#import "CYPublicHuoDongViewController.h"
#import "CYAllGoodsViewController.h"
@interface CYClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *dataArr;
    NSMutableArray *hot_tag_list;
    NSInteger page;
}

- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CYClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray array];
    hot_tag_list = [NSMutableArray array];
    page = 1;
    self.title = @"全部分类";
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"CYFenLeiCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CYFenLeiCollectionCell"];
//    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYFenLeiTopView"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CYFenLeiTopView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYFenLeiTopView"];
    [_collectionView registerClass:[UICollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"quanbufenleiHeader"];
    [_collectionView registerClass:[UICollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionheader"];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
   [self loadAllFenleiData];
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadAllFenleiData
{

    [CYWebClient Post:@"2.0_shiji.CatArr" parametes:nil success:^(id responObj) {
        NSArray *catArr =[CYTeaCategoryInfo objectArrayWithKeyValuesArray:[responObj objectForKey:@"category_list"]];
        [dataArr addObjectsFromArray:catArr];
        [hot_tag_list addObjectsFromArray:[responObj objectForKey:@"hot_tag_list"]];
        [_collectionView reloadData];
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}


-(void)loadquanziListData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
        if (page>3) {
            page =1;
        }
    }else{
        page = 1;
    };
    __weak __typeof(self) weakSelf = self;
    NSString *servpath =@"2.0_CatArr.refreshHotTag";
    [CYWebClient Post:servpath parametes:@{@"p":@(page)} success:^(id responObject) {
        NSArray *list = [responObject objectForKey:@"list"];
        if ([list isKindOfClass:[NSArray class]]) {
            [hot_tag_list removeAllObjects];
            [hot_tag_list addObjectsFromArray:list];
            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    } failure:^(id error) {
        
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


//- (IBAction)confirm_click:(id)sender {
//    CYMerchListVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYMerchListVC"];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - UICollect config
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [dataArr count] +2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section>1) {
        CYTeaCategoryInfo *subInfo = dataArr[section-2];
        return subInfo.child.count;
    }else{
        return 0;
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section > 1) {
        CGFloat w = (SCREEN_WIDTH - 40)/4.;
        CGFloat h = 80.;
        return CGSizeMake(w, h);
    }else{
        return CGSizeMake(0, 0);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section >1) {
            return UIEdgeInsetsMake(10, 20, 5, 20);
    }else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        CGFloat headerheigt = [CYFenLeiTopView fenleiTopViewHeightWithData:hot_tag_list];
        headerheigt =headerheigt + 60;
        return CGSizeMake(SCREEN_WIDTH, headerheigt);
    }else if (section == 1){
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 60);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 30);
    }
   

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            CYFenLeiTopView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYFenLeiTopView" forIndexPath:indexPath];
            if (header.biaoqianArr.count!=hot_tag_list.count) {
                header.biaoqianArr = hot_tag_list;
            }
            
            header.huanyipiBlock = ^(){
                [self loadquanziListData:YES];
            };
            header.selectblock = ^(NSDictionary *selectInfo){
                NSLog(@"selectInfo = %@",selectInfo);
                NSInteger typeid = [[selectInfo objectForJSONKey:@"typeid"] integerValue];
                NSString *resource_id =[selectInfo objectForJSONKey:@"resource_id"];
                switch (typeid) {
                    case 1:
                    {
                        CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
                        vc.wenzhangId = resource_id;
                        //vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                        break;
                    }
                    case 2:
                    {
                        CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                        vc.goodId = resource_id;
                        //vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                        break;
                    }
                    case 3:
                    {
                        CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
                        //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYMasterDetailViewController"];
                        vc.uid = resource_id;
                        //vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                        break;
                    }
                    case 4:
                    case 101:
                    {
                        NSInteger juhe_type = [[selectInfo objectForKey:@"juhe_type"] integerValue];
                        //            NSInteger juhetype = [model.juheType integerValue];
                        CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
                        if (juhe_type == 1) {//聚合 商品
                            vc.type = CYCollectionTypeCommodity;
                        }else{//聚合 人物
                            vc.type = CYCollectionTypeCharacter;
                        }
                        vc.juhe_id = resource_id;
                        //vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                        
                        
                        break;
                    }
                    case 100:
                    {
                        
                        if (!MANAGER.isLoged) {
                            [APP_DELEGATE showLogView];
                            return;
                        }
//                        CYPublicAvtiveViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYPublicAvtiveViewController"];
//                        vc.requestUrl = model.data;
//                        vc.titleStr = model.title;
//                        vc.isRedPack = model.isRedPack;
//                        //vc.hidesBottomBarWhenPushed = YES;
//                        [self.navigationController pushViewController:vc animated:YES];
                        break;
                    }
                    case 102:
                    {
                        
//                        CYPublicHuoDongViewController *vc = viewControllerInStoryBoard(@"CYPublicHuoDongViewController", @"Huodong");
//                        vc.titleStr = model.title;
//                        vc.requstUrl = model.data;
//                        //vc.hidesBottomBarWhenPushed = YES;
//                        [self.navigationController pushViewController:vc animated:YES];
                        break;
                    }
                        
                        
                    default:
                        
                        break;
                }

            };
            return header;
        }else if (indexPath.section ==1){
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"quanbufenleiHeader" forIndexPath:indexPath];
            header.backgroundColor =[UIColor getColorWithHexString:@"eeeeee"];
            for (UIView *view in header.subviews) {
                [view removeFromSuperview];
            }
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150,60)];
            lable.text = @"全部分类";
            lable.font = FONT(16.0);
            lable.textColor = btnTitle_COLOR;
            [header addSubview:lable];
            return header;
        }else {
            CYTeaCategoryInfo *subInfo = dataArr[indexPath.section-2];
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionheader" forIndexPath:indexPath];
            for (UIView *view in header.subviews) {
                [view removeFromSuperview];
            }
        
            UIView *lineVie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lineVie.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
            [header addSubview:lineVie];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150,30)];
            lable.tag = indexPath.section + 6000;
            lable.text = subInfo.name;
            lable.font = FONT(16.0);
            lable.textColor = CONTENTCOLOR;
            [header addSubview:lable];
            return header;
        }
        

    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>1) {
        CYFenLeiCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYFenLeiCollectionCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CYFenLeiCollectionCell" owner:nil options:nil] firstObject];
        }
        
        CYTeaCategoryInfo *subInfo = dataArr[indexPath.section-2];
        CYTeaChildCategoryInfo *childInfo = subInfo.child[indexPath.row];
        cell.titleLbl.text = childInfo.name;
        NSString *thumb = childInfo.thumb;
        if (thumb.length>0) {
            [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
        }
        return cell;
    }else{
        return nil;
    }

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>1) {
        CYTeaCategoryInfo *subInfo = dataArr[indexPath.section-2];
        CYTeaChildCategoryInfo *childInfo = subInfo.child[indexPath.row];
        CYAllGoodsViewController *vc = viewControllerInStoryBoard(@"CYAllGoodsViewController", @"TeaMall");
        vc.catId = childInfo.catid;
        [self.navigationController pushViewController:vc animated:YES];
    }

    
}
//
//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    cell.backgroundColor = [UIColor whiteColor];
//}


#pragma mark -
#pragma mark CYClassViewDelegate method
- (void)selectClassType:(NSDictionary *)info andIsLast:(BOOL)islast
{
    if (!islast) {
        NSString *type = [info objectForKey:@"type"];
        if (type) {
            NSInteger status = [type integerValue];
            switch (status) {
                case 1:
                {
                    
                    break;
                }
                case 2:
                case 5:
                {
                    CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
                    vc.goodId = [info objectForKey:@"data"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3:
                {
                    CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
                    //    [self.storyboard instantiateViewControllerWithIdentifier:@"CYMasterDetailViewController"];
                    vc.uid = [info objectForKey:@"data"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 4:
                {
                    NSInteger juhetype = [[info objectForKey:@"juheType"] integerValue];
                    CYTeaMallCollectionViewController *vc= viewControllerInStoryBoard(@"CYTeaMallCollectionViewController", @"TeaMall");
                    
                    if (juhetype == 1) {//聚合 商品
                        vc.type = CYCollectionTypeCommodity;
                    }else{//聚合 人物
                        vc.type = CYCollectionTypeCharacter;
                    }
                    vc.juhe_id = [info objectForKey:@"data"];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                    break;
                }
                case 100:
                {
                    
                    break;
                }
                    
                default:
                    
                    break;
            }
        }else{
            CYMerchListVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYMerchListVC"];
            vc.catid = [info objectForKey:@"data"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
   
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


@end
