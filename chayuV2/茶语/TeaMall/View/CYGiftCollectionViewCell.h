//
//  CYGiftCollectionViewCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYGiftModel.h"


@protocol CYGiftCollectionViewCellDelegate;

static NSString *giftIdentify = @"CYGiftCollectionViewCell";
@interface CYGiftCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) CYGiftModel *merchModel;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView ItemAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)id<CYGiftCollectionViewCellDelegate>delegate;
@end


@protocol CYGiftCollectionViewCellDelegate <NSObject>

- (void)selectiftCell:(CYGiftCollectionViewCell *)cell WithModel:(CYGiftModel *)model;

@end
