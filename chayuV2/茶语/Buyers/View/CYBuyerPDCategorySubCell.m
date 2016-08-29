//
//  CYBuyerPDCategorySubCell.m
//  茶语
//
//  Created by Leen on 16/6/17.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDCategorySubCell.h"

@implementation CYBuyerPDCategorySubCell

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
    static NSString *cellName = @"CYBuyerPDCategorySubCell";
    CYBuyerPDCategorySubCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerPDCategorySubCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (IBAction)selectBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectPDCategorySubCell:)]) {
        [self.delegate selectPDCategorySubCell:self];
    }
}

@end
