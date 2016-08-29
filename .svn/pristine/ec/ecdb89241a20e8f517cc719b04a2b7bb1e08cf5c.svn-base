//
//  CYCollectTeaSampleCell.m
//  茶语
//
//  Created by Leen on 16/5/31.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCollectTeaSampleCell.h"

@implementation CYCollectTeaSampleCell

- (void)parseData:(id)data
{
    CYTeaSampleInfo *info = [CYTeaSampleInfo objectWithKeyValues:data];
    
    [_mImageView sd_setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:SQUARE];
    _mTitleLabel.text = info.tea_title;
    _mPriceLabel.text = [NSString stringWithFormat:@"库存：%@ 份",info.remain];
    _mStockLabel.text =[NSString stringWithFormat:@"茶币：%@ 个",info.price];
    _mYDLabel.text =    [NSString stringWithFormat:@"已兑换：%@ 份",info.applys_num];
    
    
    
    if ([info.remain integerValue]  == 0) {
        _mStockLabel.text = @"库   存：无";
    }else{
        [_mStockLabel setFontColor:[UIColor getColorWithHexString:@"893e20"] fontSize:FONT(16) string:info.price];
    }
    
    [_mPriceLabel setFontColor:[UIColor getColorWithHexString:@"893e20"]  fontSize:FONT(16) string:info.remain];
    
    
    [_mYDLabel setFontColor:[UIColor getColorWithHexString:@"893e20"]  fontSize:FONT(16) string:info.applys_num];
    
    self.mClickData = info;
}

+ (instancetype)cellWidthTableView:(UITableView *)tableView
{
    static NSString *cellName = @"CYCollectTeaSampleCell";
    CYCollectTeaSampleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYCollectTeaSampleCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (IBAction)selectBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectCollectTeaSampleCell:)]) {
        [self.delegate selectCollectTeaSampleCell:self];
    }
}

@end
