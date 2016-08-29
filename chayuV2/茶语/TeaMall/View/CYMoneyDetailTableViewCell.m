//
//  CYMoneyDetailTableViewCell.m
//  TeaMall
//
//  Created by Chayu on 15/11/13.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMoneyDetailTableViewCell.h"

@interface CYMoneyDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;

@end

@implementation CYMoneyDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMoney:(NSString *)money
{
    _money = money;
    _moneyLbl.text = [NSString stringWithFormat:@"￥%.2f",[_money floatValue]];
}

- (void)setMoneyto:(NSString *)moneyto
{
    _moneyto = moneyto;
    _timeLbl.text = moneyto;
}


@end
