//
//  CYBuyerTodaySumCell.m
//  茶语
//
//  Created by Leen on 16/8/26.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerTodaySumCell.h"

@interface CYBuyerTodaySumCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;

@end

@implementation CYBuyerTodaySumCell

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
    static NSString *addressManagementidentify = @"CYBuyerTodaySumCell";
    CYBuyerTodaySumCell *cell = [tableView dequeueReusableCellWithIdentifier:addressManagementidentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerTodaySumCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
