//
//  CYBuyerCell.h
//  茶语
//
//  Created by Leen on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBuyerMainCellModel.h"

@interface CYBuyerCell : UITableViewCell

+ (instancetype) cellForTableView:(UITableView *)tableView;
@property (nonatomic, strong) CYBuyerMainCellModel * model;

@end
