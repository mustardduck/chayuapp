//
//  CYBuyerPDOnSaleCell.m
//  茶语
//
//  Created by Leen on 16/6/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDOnSaleCell.h"

@implementation CYBuyerPDOnSaleCell

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
    static NSString *addressManagementidentify = @"CYBuyerPDOnSaleCell";
    CYBuyerPDOnSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:addressManagementidentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerPDOnSaleCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
