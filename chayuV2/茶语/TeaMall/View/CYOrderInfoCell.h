//
//  CYOrderInfoCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYOrderInfoCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSDictionary *orderinfo;

@end
