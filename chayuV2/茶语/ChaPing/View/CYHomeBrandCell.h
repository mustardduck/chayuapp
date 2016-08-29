//
//  CYHomeBrandCell.h
//  茶语
//
//  Created by 李峥 on 16/3/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"

@interface CYHomeBrandCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *mNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mScodeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mNumWidthCons;

@property(nonatomic,strong)NSDictionary *info;

@end

