//
//  CYClassTableViewCell.h
//  茶语
//
//  Created by Chayu on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYClassTableViewCell : UITableViewCell
+(instancetype)cellWidthTableView:(UITableView*)tableView;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSArray *dataArr;;

@end
