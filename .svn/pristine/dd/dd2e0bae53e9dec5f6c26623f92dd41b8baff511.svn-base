//
//  CYOrderInfoCell.m
//  TeaMall
//  支付信息
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYOrderInfoCell.h"

@interface CYOrderInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;


@end

@implementation CYOrderInfoCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWidthTableView:(UITableView*)tableView{
    static NSString *orderInfoIdentify = @"CYOrderInfoCell";
    CYOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderInfoIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYOrderInfoCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderinfo:(NSDictionary *)orderinfo
{
    _orderinfo = orderinfo;
    _orderIdLbl.text = [_orderinfo objectForJSONKey:@"orderSn"];
    _payTypeLbl.text = [_orderinfo objectForJSONKey:@"payPlatform"];
    _timeLbl.text = [_orderinfo objectForJSONKey:@"created"];
}

@end
