//
//  CYMerchCollectionCell.h
//  TeaMall
//
//  Created by Chayu on 15/10/22.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYMerchCellModel.h"
#import "CYBuyerPDCellModel.h"

static NSString *merchIdentify = @"CYMerchCollectionCell";
@interface CYMerchCollectionCell : UICollectionViewCell


@property (nonatomic, strong) CYMerchCellModel *merchModel;
@property (nonatomic, strong) CYBuyerPDCellModel *PDCellModel;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView ItemAtIndexPath:(NSIndexPath *)indexPath;

@end
