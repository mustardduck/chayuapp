//
//  CYSearchPublicCell.h
//  茶语
//
//  Created by Chayu on 16/3/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYSearchPublicCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,strong)NSDictionary *info;

@end
