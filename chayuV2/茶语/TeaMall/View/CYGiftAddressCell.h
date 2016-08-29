//
//  CYGiftAddressCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYShippingAddressModel.h"
@interface CYGiftAddressCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)CYShippingAddressModel *addAessInfo;

@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

@end
