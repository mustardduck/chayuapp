//
//  CYPingPaiView.m
//  茶语
//
//  Created by Chayu on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPingPaiView.h"
#import "CYPingPaiCollectionItem.h"
#import "CYTeaCategoryInfo.h"

@interface CYPingPaiView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *selectArr;
    NSInteger selectIndexItem;
    NSInteger selectNum;//点击了几下
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation CYPingPaiView

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
    selectArr  = [NSMutableArray array];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    selectNum = 0;
    [_collectionView registerNib:[UINib nibWithNibName:@"CYPingPaiCollectionItem" bundle:nil] forCellWithReuseIdentifier:@"CYPingPaiCollectionItem"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYPingPaiItemHeader"];
    _collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)setPingPaiArr:(NSArray *)pingPaiArr
{

}


- (void)setHot_list:(NSArray *)hot_list
{
    _hot_list = hot_list;
    
}
- (void)setBrand_list:(NSMutableArray *)brand_list
{
    _brand_list = brand_list;
    [_collectionView reloadData];
}

#pragma mark - UICollect config
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _hot_list.count;
    }else{
        if (selectIndexItem == -1) {
            return _brand_list.count;
        }else{
            return [selectArr count];
        }
       
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

     CGFloat w = SCREEN_WIDTH / 3.;
     CGFloat h = 95.;
    if (indexPath.section == 0) {
        w = (SCREEN_WIDTH - 40)/4.;
    }else{
        
        h = 50.;
        if (selectIndexItem == -1) {
           w = SCREEN_WIDTH/5.;
        }else{
           w =  SCREEN_WIDTH/3.;
        }
    }
   
    return CGSizeMake(w, h);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (section == 0) {
      return UIEdgeInsetsMake(0, 20, 0, 20);
    }else{
      return UIEdgeInsetsMake(0, 0, 0, 0);
    }

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYPingPaiItemHeader" forIndexPath:indexPath];
        header.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
        for (UIView *view in header.subviews) {
            [view removeFromSuperview];
        }
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40,50)];
            if (indexPath.section == 0) {
                title.text = @"热门品牌";
            }else{
                title.text = @"品牌";
            }
            title.font = FONT(17.);
            title.textColor =[UIColor getColorWithHexString:@"333333"];
            [header addSubview:title];
        return header;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYPingPaiCollectionItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYPingPaiCollectionItem" forIndexPath:indexPath];
   
    if (indexPath.section == 0) {
        NSDictionary *info = [_hot_list objectAtIndex:indexPath.row];
        cell.titleLbl.hidden = YES;
        [cell.ico_img sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"logo"]] placeholderImage:SQUARE];
        cell.needBorder = NO;
        cell.ico_title.text = [info objectForKey:@"name"];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor =[UIColor whiteColor];
         cell.closeImg.hidden = YES;
        cell.titleLbl.textAlignment = NSTextAlignmentCenter;
    }else{
        UIView *view = cell;
        view.layer.borderColor = [UIColor getColorWithHexString:@"f9f9f9"].CGColor;
        view.layer.borderWidth = 0.5;
        cell.ico_img.hidden = YES;
        cell.ico_title.hidden = YES;
        cell.needBorder = NO;
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
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
         NSDictionary *info = [_hot_list objectAtIndex:indexPath.row];
        if (self.pingPaiSelectBlock) {
            self.pingPaiSelectBlock([info objectForKey:@"brandid"],[info objectForKey:@"name"]);
        }
    }
    
    if (indexPath.section>0) {
        if (indexPath.row == 0 && [selectArr count]==0) {
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
            self.height = 100 + ceilf(_hot_list.count/4.)*95 + ceilf(_brand_list.count/5.)*50;
            return;
        }
        
//        if (indexPath.row>0 && [selectArr count]) {//当点开字母 且 点击大于第0位
//            return;
//        }
//      
        selectIndexItem = indexPath.row;
        CYPingPaiInfo *info = [_brand_list objectAtIndex:selectIndexItem];
        CYTeaChildCategoryInfo *cInfo = [[CYTeaChildCategoryInfo alloc] init];
        cInfo.name = info.letter;
        [selectArr addObject:cInfo];
        [selectArr addObjectsFromArray:info.list];
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        self.height = 100 + ceilf(_hot_list.count/4.)*95 + ceilf(selectArr.count/3.)*50;
        if (selectNum >0) {
            CYTeaChildCategoryInfo *bangdanInfo = selectArr[indexPath.row];
            if (self.pingPaiSelectBlock) {
                self.pingPaiSelectBlock(bangdanInfo.id,bangdanInfo.name);
            }
        }
          selectNum +=1;
       
    }

}


@end
