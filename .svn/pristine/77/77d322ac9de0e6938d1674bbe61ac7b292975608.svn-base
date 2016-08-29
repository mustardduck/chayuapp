//
//  CYBuyerReturnMainCell.m
//  茶语
//
//  Created by Leen on 16/7/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerReturnMainCell.h"
#import "CYBuyerOrderDetailProductCell.h"

@implementation CYBuyerReturnMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadGoodsView:(NSArray *)arr
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i =0; i<[arr count]; i++) {
            CYBuyerOrderDetailProductCell *goodsView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerOrderDetailProductCell" owner:nil options:nil] firstObject];
            
            goodsView.priceLbl.hidden = YES;
            goodsView.countLbl.hidden = YES;
            goodsView.titleLblTrailingCons.constant = 14;
            
            [_orderView addSubview:goodsView];
        }
    });
    
}

@end
