//
//  CYSelectGiftCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/25.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYGiftModel.h"
@interface CYSelectGiftCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)CYGiftModel *model;


@end
