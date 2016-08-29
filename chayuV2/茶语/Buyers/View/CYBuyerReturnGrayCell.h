//
//  CYBuyerReturnGrayCell.h
//  茶语
//
//  Created by Leen on 16/7/12.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYBuyerReturnGrayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImgHeightCons;
@property (weak, nonatomic) IBOutlet UILabel *bgTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *bgFirstLbl;
@property (weak, nonatomic) IBOutlet UILabel *bgSecondLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLblHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondLblHeightCons;

+(instancetype)cellWidthTableView:(UITableView*)tableView;


@end
