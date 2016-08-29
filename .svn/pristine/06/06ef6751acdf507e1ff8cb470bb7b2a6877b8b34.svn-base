//
//  CYBuyerShipAreaSubCell.m
//  茶语
//
//  Created by Leen on 16/7/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerShipAreaSubCell.h"

@implementation CYBuyerShipAreaSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWidthTableView:(UITableView *)tableView
{
    static NSString *cellName = @"CYBuyerShipAreaSubCell";
    CYBuyerShipAreaSubCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerShipAreaSubCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (IBAction)selectBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectShipAreaSubCell:)]) {
        [self.delegate selectShipAreaSubCell:self];
    }
}

@end
