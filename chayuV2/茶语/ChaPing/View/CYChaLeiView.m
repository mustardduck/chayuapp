//
//  CYChaLeiView.m
//  茶语
//
//  Created by Chayu on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYChaLeiView.h"
#import "CYEvaCollectionView.h"
#import "CYEvaHeaderCollectionView.h"

@interface CYChaLeiView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger selectIndex;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *mCateList;

@end


@implementation CYChaLeiView

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
    selectIndex = -1;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"CYEvaCollectionView" bundle:nil] forCellWithReuseIdentifier:@"CYEvaCollectionView"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CYEvaHeaderCollectionView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYEvaHeaderCollectionView"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"EvaFooterCollection"];
}


- (void)setChaliData:(NSArray *)chaliData
{
    _chaliData = chaliData;
    self.mCateList = [NSMutableArray arrayWithArray:_chaliData];
    [_collectionView reloadData];
}


#pragma mark - UICollect config
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.mCateList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    CYTeaCategoryInfo *info = [self.mCateList objectAtIndex:section];
    if (info.hasOpen) {
       return info.children.count;
    }else{
        return 0;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = SCREEN_WIDTH / 3.;
    return CGSizeMake(w, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH,1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        CYEvaHeaderCollectionView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYEvaHeaderCollectionView" forIndexPath:indexPath];
        CYTeaCategoryInfo *info = [self.mCateList objectAtIndex:indexPath.section];
        header.mTitleLabel.text = info.name;
        if (info.hasOpen) {
            header.rightimg.image = [UIImage imageNamed:@"daohang_up_row"];
            header.linView.hidden = NO;
        }else{
            header.rightimg.image = [UIImage imageNamed:@"daohang_down_row"];
            header.linView.hidden = YES;
        }
        
        if (indexPath.section == 0) {
            header.rightimg.hidden = YES;
        }else{
            header.rightimg.hidden = NO;
        }

        [header.iconImg sd_setImageWithURL:[NSURL URLWithString:info.ico] placeholderImage:SQUARE];
        header.mTitleLabel.textColor = [UIColor getColorWithHexString:@"333333"];
        header.selectBtn.tag = 300+indexPath.section;
        [header.selectBtn addTarget:self action:@selector(select_header:) forControlEvents:UIControlEventTouchUpInside];
        return header;
    }else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"EvaFooterCollection" forIndexPath:indexPath];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,1)];
        line.backgroundColor = [UIColor getColorWithHexString:@"efefef"];
        [footer addSubview:line];
        return footer;
        
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYEvaCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYEvaCollectionView" forIndexPath:indexPath];
    CYTeaCategoryInfo *info = [self.mCateList objectAtIndex:indexPath.section];
    CYTeaChildCategoryInfo *cInfo = [info.children objectAtIndex:indexPath.row];
    cell.mSnameLabel.text = cInfo.name;
    if (!cInfo.is_new) {
        cell.statusImg.hidden = YES;
    }else{
        cell.statusImg.hidden = NO;
    }
    cell.needBorder = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYTeaCategoryInfo *info = [self.mCateList objectAtIndex:indexPath.section];
    CYTeaChildCategoryInfo *cInfo = [info.children objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectItem:andTeaCategoryInfo:)]) {
        [self.delegate selectItem:cInfo andTeaCategoryInfo:info];
    }
}

-(void)select_header:(UIButton *)sender
{
    
    
    NSInteger selectTag = sender.tag - 300;
    
    if (selectTag == 0) {
        CYTeaCategoryInfo *info = [self.mCateList objectAtIndex:selectTag];
//        if (info.children.count>0) {
//                 CYTeaChildCategoryInfo *cInfo = [info.children objectAtIndex:0];
//        }
   
        if ([self.delegate respondsToSelector:@selector(selectItem:andTeaCategoryInfo:)]) {
            [self.delegate selectItem:nil andTeaCategoryInfo:info];
            return;
        }
    }
    
    if (selectIndex!=-1) {
        CYTeaCategoryInfo *info = [self.mCateList objectAtIndex:selectTag];
        NSArray *chidData = info.children;
        CYTeaCategoryInfo *selectinfo = [self.mCateList objectAtIndex:selectIndex];
        NSArray *selectchidData = selectinfo.children;
        if (selectIndex == selectTag) {
            info.hasOpen = !info.hasOpen;
            selectinfo.hasOpen = info.hasOpen;
            if (info.hasOpen) {
                self.height +=(ceilf(chidData.count/3.)*50);
            }else{
                self.height -=(ceilf(chidData.count/3.)*50);
            }
        }else{
            info.hasOpen = YES;
            if (selectinfo.hasOpen) {
                self.height -=(ceilf(selectchidData.count/3.)*50);
            }
            self.height +=(ceilf(chidData.count/3.)*50);
            selectinfo.hasOpen = NO;
        }
        [self.mCateList replaceObjectAtIndex:selectTag withObject:info];
        [self.mCateList replaceObjectAtIndex:selectIndex withObject:selectinfo];
        [self.collectionView reloadData];
    }else{
        CYTeaCategoryInfo *info = [self.mCateList objectAtIndex:selectTag];
        NSArray *chidData = info.children;
          self.height +=(ceilf(chidData.count/3.)*50);
        info.hasOpen = YES;
        [self.mCateList replaceObjectAtIndex:selectTag withObject:info];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:selectTag]];
    }
    selectIndex = selectTag;
}

@end