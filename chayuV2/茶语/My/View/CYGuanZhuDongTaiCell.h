//
//  CYGuanZhuDongTaiCell.h
//  茶语
//
//  Created by Chayu on 16/7/18.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYGuanZhuDongTaiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;


@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet UILabel *saleLbl;


@property (weak, nonatomic) IBOutlet UIImageView *statusImg;


@end
