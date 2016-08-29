//
//  CYBuyerOrderDetailProductCell.m
//  茶语
//
//  Created by Leen on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerOrderDetailProductCell.h"

@implementation CYBuyerOrderDetailProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView
{
    static NSString *addressManagementidentify = @"CYBuyerOrderDetailProductCell";
    CYBuyerOrderDetailProductCell *cell = [tableView dequeueReusableCellWithIdentifier:addressManagementidentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerOrderDetailProductCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
