//
//  CYShiJiCell.m
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeShiJiCell.h"
#import "HJCarouselViewCell.h"
#import "HJCarouselViewLayout.h"
@interface CYHomeShiJiCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScro;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)gengduo_click:(id)sender;


@end

@implementation CYHomeShiJiCell

static NSString * const shijireuseIdentifier = @"shijireuseIdentifier";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
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

- (void)parseData:(id)data
{
    if ([self.mClickData count]>0) {
        return;
    }
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCarouselViewCell class]) bundle:nil] forCellWithReuseIdentifier:shijireuseIdentifier];
    
    HJCarouselViewLayout *layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
    layout.visibleCount = [self.mClickData count];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH-40, 285.*SCREENBILI);
    self.collectionView.collectionViewLayout = layout;
    self.mClickData = data;
    [self.collectionView reloadData];
    NSLog(@"shiji %@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
}



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
    HJCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shijireuseIdentifier forIndexPath:indexPath];
    
    CYHomeMarkertInfo *info = self.mClickData[indexPath.row];
    CYHomeShiJiView *shijiView = [[[NSBundle mainBundle] loadNibNamed:@"CYHomeShiJiView" owner:nil options:nil] firstObject];
    shijiView.frame = cell.contentView.bounds;
    //    shijiView.x = 20;
    //    shijiView.width = cell.contentView.width -20;
    shijiView.markerInfo = info;
    [cell.contentView addSubview:shijiView];
    
    return cell;
}





-(void)selectTea:(UITapGestureRecognizer *)sender
{
    UIView *view = sender.view;
    if (self.gotosomeViewBlock) {
        self.gotosomeViewBlock(self.mClickData[view.tag -100]);
    }
}


- (IBAction)gengduo_click:(id)sender {
    if (self.gengduoBlock) {
        self.gengduoBlock();
    }
}
@end
