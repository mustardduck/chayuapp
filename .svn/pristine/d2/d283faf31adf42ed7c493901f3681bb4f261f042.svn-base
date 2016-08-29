//
//  CYBuyerReturnGrayCell.m
//  茶语
//
//  Created by Leen on 16/7/12.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerReturnGrayCell.h"

@implementation CYBuyerReturnGrayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView{
    CYBuyerReturnGrayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYBuyerReturnGrayCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerReturnGrayCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
