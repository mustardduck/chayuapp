//
//  CYDeliveryInfoTableViewCell.m
//  TeaMall
//  收货信息
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYDeliveryInfoTableViewCell.h"

@interface CYDeliveryInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLbl;

@end


@implementation CYDeliveryInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
+(instancetype)cellWidthTableView:(UITableView*)tableView{
    static NSString *deliveryIdentify = @"CYDeliveryInfoTableViewCell";
    CYDeliveryInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deliveryIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYDeliveryInfoTableViewCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDeliverInfo:(NSDictionary *)deliverInfo
{
    _deliverInfo = deliverInfo;
    _nameLbl.text = [_deliverInfo objectForJSONKey:@"recName"];
    _addressLbl.text = [_deliverInfo objectForJSONKey:@"recAddress"];
    _phoneNumLbl.text = [_deliverInfo objectForJSONKey:@"recMobile"];
}

@end
