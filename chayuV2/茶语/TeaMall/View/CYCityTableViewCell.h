//
//  CYCityTableViewCell.h
//  茶语
//
//  Created by Chayu on 16/3/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYCityTableViewCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,copy)NSString *titleStr;

@end
