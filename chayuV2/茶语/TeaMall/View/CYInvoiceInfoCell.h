//
//  CYInvoiceInfoCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYInvoiceInfoCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

/**
 *  发票信息
 */
@property (nonatomic,strong)NSDictionary *invoiceInfo;

@end
