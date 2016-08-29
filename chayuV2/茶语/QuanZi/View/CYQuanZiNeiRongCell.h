//
//  CYQuanZiNeiRongCell.h
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYQuanZiNeiRongCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *pinglunLbl;

@property (weak, nonatomic) IBOutlet UILabel *liulanLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_img_cons;
@end
