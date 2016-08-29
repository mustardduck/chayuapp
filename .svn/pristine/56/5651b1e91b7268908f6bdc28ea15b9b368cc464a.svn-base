//
//  CYCollectGoodCell.m
//  茶语
//
//  Created by Leen on 16/6/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCollectGoodCell.h"
#import "CYMerchCellModel.h"

@implementation CYCollectGoodCell

- (void)parseData:(id)data
{
    CYMerchCellModel *info = [CYMerchCellModel objectWithKeyValues:data];
    
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:SQUARE];
    
    _mTitleLabel.text = info.name;
    _mPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", [info.price_sell floatValue]];
    _mSellCountLbl.text = [NSString stringWithFormat:@"已售%@", info.sales_count];
    
    self.mClickData = info;
}

+ (instancetype)cellWidthTableView:(UITableView *)tableView
{
    static NSString *cellName = @"CYCollectGoodCell";
    CYCollectGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYCollectGoodCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (IBAction)selectBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectCollectGoodCell:)]) {
        [self.delegate selectCollectGoodCell:self];
    }
}

@end
