//
//  CYQuanZiCell.m
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeQuanZiCell.h"
#import "CYHomeQuanZiView.h"
#import "HJCarouselViewCell.h"
#import "HJCarouselViewLayout.h"
@interface CYHomeQuanZiCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UIScrollView *contentScro;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)gengduo_click:(id)sender;
@end

@implementation CYHomeQuanZiCell

static NSString * const quanzireuseIdentifier = @"quanzireuseIdentifier";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)parseData:(id)data
{
    
    if ([self.mClickData count]>0) {
        return;
    }
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCarouselViewCell class]) bundle:nil] forCellWithReuseIdentifier:quanzireuseIdentifier];
    HJCarouselViewLayout *layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.visibleCount = [self.mClickData count];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH-40, 234.*SCREENBILI);
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    [self.collectionView layoutIfNeeded];
    self.mClickData = data;
    [self.collectionView reloadData];
    NSLog(@"quanzi %@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
    
}


- (NSIndexPath *)curIndexPath {
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *curIndexPath = nil;
    NSInteger curzIndex = 0;
    for (NSIndexPath *path in indexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:path];
        if (!curIndexPath) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
            continue;
        }
        if (attributes.zIndex > curzIndex) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
        }
    }
    return curIndexPath;
}




//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSIndexPath *curIndexPath = [self curIndexPath];
//    if (indexPath.row == curIndexPath.row) {
//        return YES;
//    }
//    
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//    
//    //    HJCarouselViewLayout *layout = (HJCarouselViewLayout *)collectionView.collectionViewLayout;
//    //    CGFloat cellHeight = layout.itemSize.height;
//    //    CGRect visibleRect = CGRectZero;
//    //    if (indexPath.row > curIndexPath.row) {
//    //        visibleRect = CGRectMake(0, cellHeight * indexPath.row + cellHeight / 2, CGRectGetWidth(collectionView.frame), cellHeight / 2);
//    //    } else {
//    //        visibleRect = CGRectMake(0, cellHeight * indexPath.row, CGRectGetWidth(collectionView.frame), CGRectGetHeight(collectionView.frame));
//    //    }
//    //    [self.collectionView scrollRectToVisible:visibleRect animated:YES];
//    
//    return NO;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 20;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 20;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0,20, 0, 20);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld", indexPath.row);
    if (self.gotosomeViewBlock) {
        self.gotosomeViewBlock(self.mClickData[indexPath.row]);
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.mClickData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:quanzireuseIdentifier forIndexPath:indexPath];
    CYHomeQuanInfo  *info = self.mClickData[indexPath.row];
    CYHomeQuanZiView *quanziView = [[[NSBundle mainBundle] loadNibNamed:@"CYHomeQuanZiView" owner:self options:nil] firstObject];
    quanziView.frame = cell.contentView.bounds;
    //    quanziView.x = 20;
    //    quanziView.width = cell.contentView.width -20;
    
    quanziView.newsInfo = info;
    [cell.contentView addSubview:quanziView];
    
    return cell;
}



- (IBAction)gengduo_click:(id)sender {
    if (self.gengduoBlock) {
        self.gengduoBlock();
    }
}
@end
