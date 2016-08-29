//
//  CYBuyerEvaCell.m
//  茶语
//
//  Created by Leen on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerEvaCell.h"

@implementation CYBuyerEvaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView index:(NSInteger)index
{
    static NSString *addressManagementidentify = @"CYBuyerEvaCell";
    CYBuyerEvaCell *cell = [tableView dequeueReusableCellWithIdentifier:addressManagementidentify];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CYBuyerEvaCell" owner:nil options:nil][index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
