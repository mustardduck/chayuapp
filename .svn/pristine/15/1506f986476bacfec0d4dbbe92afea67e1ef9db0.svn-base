//
//  CYBuyerPDCategoryCell.m
//  茶语
//
//  Created by Leen on 16/8/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDCategoryCell.h"

@implementation CYBuyerPDCategoryCell

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
    static NSString *cellName = @"CYBuyerPDCategoryCell";
    CYBuyerPDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerPDCategoryCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (IBAction)selectBtnClicked:(id)sender {
    
    if(self.selectBtnBlock)
    {
        self.selectBtnBlock();
    }
}

@end
