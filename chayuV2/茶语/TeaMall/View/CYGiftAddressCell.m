//
//  CYGiftAddressCell.m
//  TeaMall
//
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYGiftAddressCell.h"

@interface CYGiftAddressCell ()


@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

@end

@implementation CYGiftAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddAessInfo:(CYShippingAddressModel *)addAessInfo{
    _addAessInfo = addAessInfo;
    _usernameLbl.text = _addAessInfo.name;
    _phoneLbl.text = _addAessInfo.mobile;
    NSString *readAddress = [NSString stringWithFormat:@"%@%@%@%@",_addAessInfo.provinceName,_addAessInfo.cityName,_addAessInfo.areaName,_addAessInfo.areaAddress];
    _addressLbl.text = readAddress;
}


+(instancetype)cellWidthTableView:(UITableView*)tableView
{
    static NSString *giftAddIdentify = @"CYGiftAddressCell";
    CYGiftAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:giftAddIdentify];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"CYGiftAddressCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
