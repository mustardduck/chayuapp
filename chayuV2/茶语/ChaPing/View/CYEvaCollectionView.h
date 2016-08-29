//
//  CYEvaCollectionView.h
//  茶语
//
//  Created by 李峥 on 16/3/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYEvaCollectionView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *mSnameLabel;

@property (nonatomic, assign) BOOL needBorder;

@property (weak, nonatomic) IBOutlet UIImageView *statusImg;



@end
