//
//  CYMyHuoDongCell.h
//  茶语
//
//  Created by Chayu on 16/7/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyHuoDongCell : UITableViewCell

@property(nonatomic,copy)void (^menuclickBlock)(NSInteger);


@property (weak, nonatomic) IBOutlet UIImageView *img1;

@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UILabel *lable3;
- (IBAction)menu_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *itemcollectionView;

@end
