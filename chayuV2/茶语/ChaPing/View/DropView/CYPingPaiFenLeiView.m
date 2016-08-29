//
//  CYPingPaiFenLeiView.m
//  茶语
//
//  Created by Chayu on 16/7/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPingPaiFenLeiView.h"
#import "CYPingPaiCollectionItem.h"
#import "CYTeaCategoryInfo.h"
@interface CYPingPaiFenLeiView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *selectArr;
    NSInteger selectIndexItem;
    NSInteger selectNum;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CYPingPaiFenLeiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib
{
    [super awakeFromNib];
    selectIndexItem = -1;
    selectNum = 0;
    selectArr  = [NSMutableArray array];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"CYPingPaiCollectionItem" bundle:nil] forCellWithReuseIdentifier:@"CYPingPaiCollectionItem"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYPingPaiItemHeader"];
    _collectionView.backgroundColor = [UIColor whiteColor];
}


-(void)setBrand_list:(NSMutableArray *)brand_list
{
    _brand_list = brand_list;

    
    [_collectionView reloadData];
}



#pragma mark - UICollect config
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    if (selectIndexItem == -1) {
        return _brand_list.count;
    }else{
        return [selectArr count];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat w = SCREEN_WIDTH / 3.;
    CGFloat h = 95.;
    h = 50.;
    if (selectIndexItem == -1) {
        w = SCREEN_WIDTH/5.;
    }else{
        w =  SCREEN_WIDTH/3.;
    }
    
    return CGSizeMake(w, h);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYPingPaiCollectionItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYPingPaiCollectionItem" forIndexPath:indexPath];

        cell.ico_img.hidden = YES;
        cell.ico_title.hidden = YES;
        UIView *view = cell;
        view.layer.borderColor = [UIColor getColorWithHexString:@"f9f9f9"].CGColor;
        view.layer.borderWidth = 0.5;
        if (selectIndexItem == -1) {
            CYPingPaiInfo *info = [_brand_list objectAtIndex:indexPath.row];
            cell.titleLbl.text = info.letter;
            cell.closeImg.hidden = YES;
            cell.titleLbl.x = 10;
            cell.titleLbl.textAlignment = NSTextAlignmentCenter;
        }else{
            CYTeaChildCategoryInfo *cInfo = [selectArr objectAtIndex:indexPath.row];
            cell.titleLbl.text = cInfo.name;
            if (indexPath.row == 0) {
                cell.closeImg.hidden = NO;
                cell.titleLbl.textAlignment = NSTextAlignmentLeft;
                cell.titleLbl.x = 20;
            }else{
                cell.closeImg.hidden = YES;
                cell.titleLbl.x = 10;
                cell.titleLbl.textAlignment = NSTextAlignmentCenter;
            }
            
        }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([selectArr count] ==0 && indexPath.row == 0) {
        if (self.pingPaiSelectBlock) {
            self.pingPaiSelectBlock(@"0",@"全部");
        }
        return;
    }
    
    if ([selectArr count] && indexPath.row ==0) {//当点开字母且第点击第一个；
        [selectArr removeAllObjects];
        selectNum = 0;
        selectIndexItem = -1;
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        return;
    }
    
    
    if (selectNum >0) {
        CYTeaChildCategoryInfo *bangdanInfo = selectArr[indexPath.row];
        if (self.pingPaiSelectBlock) {
            self.pingPaiSelectBlock(bangdanInfo.id,bangdanInfo.name);
        }
        return;
    }
    
    selectIndexItem = indexPath.row;
    CYPingPaiInfo *info = [_brand_list objectAtIndex:selectIndexItem];
    CYTeaChildCategoryInfo *cInfo = [[CYTeaChildCategoryInfo alloc] init];
    cInfo.name = info.letter;
    [selectArr addObject:cInfo];
    [selectArr addObjectsFromArray:info.list];
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    selectNum +=1;
    
}



@end
