//
//  CYHongBaoCell.h
//  茶语
//
//  Created by Leen on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYHongBaoModel.h"

@interface CYHongBaoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_time;
@property (weak, nonatomic) IBOutlet UILabel *lb_note;
@property (weak, nonatomic) IBOutlet UILabel *lb_money;

@property (weak, nonatomic) CYHongBaoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *statusImg;



@end
