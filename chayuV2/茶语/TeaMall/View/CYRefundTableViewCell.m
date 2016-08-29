//
//  CYRefundTableViewCell.m
//  TeaMall
//
//  Created by Chayu on 15/11/6.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYRefundTableViewCell.h"

@interface CYRefundTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImg;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *refundTypeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *introductionLbl;
@property (weak, nonatomic) IBOutlet UILabel *standardLbl;
@property (weak, nonatomic) IBOutlet UILabel *refundPriceLbl;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet UIButton *statusButton;
- (IBAction)accountsDetail_click:(id)sender;

@end

@implementation CYRefundTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)accountsDetail_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectCell:andModel:)]) {
        [self.delegate selectCell:self andModel:_orderModel];
    }
}


-(void)layoutSubviews
{

}

- (void)setOrderModel:(CYRefundModel *)orderModel
{
    _orderModel = orderModel;
    NSString *thumb = _orderModel.thumb;
    if (thumb.length) {
        NSURL *showUrl = [NSURL URLWithString:_orderModel.thumb];
        [_showImg sd_setImageWithURL:showUrl placeholderImage:nil];
    }
   
    _userNameLbl.text = _orderModel.sellerName;
    NSString *sellerAvatar = _orderModel.sellerAvatar;
    if (sellerAvatar.length) {
        NSURL *url = [NSURL URLWithString:sellerAvatar];
        [_userImg sd_setImageWithURL:url placeholderImage:nil];
    }
    _refundTypeLbl.text = _orderModel.refundType;
    _introductionLbl.text = _orderModel.name;
    _standardLbl.text = _orderModel.spec;
    _refundPriceLbl.text = [NSString stringWithFormat:@"￥%.2f",[_orderModel.money floatValue]];
    _priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[_orderModel.price floatValue]];
    NSInteger refundType = [_orderModel.refundType integerValue];
    NSString *refundStr = @"";
    if (refundType == 1) {
        NSInteger status = 0;
       status = [_orderModel.status integerValue];
        switch (status) {
            case 0:
            {
                refundStr = @"退款中";
                break;
            }
            case 1:
            {
                refundStr = @"退款成功";
                break;
            }
            case 2:
            {
                refundStr = @"退款失败";
                break;
            }
            case 3:
            {
                refundStr = @"退款取消";
                break;
            }
                
            default:
                break;
        }
    }else{
        NSInteger shippingStatus = [_orderModel.shippingStatus integerValue];
        switch (shippingStatus) {
            case 3:
            case 5:
            {
                refundStr = @"退货中";
                break;
            }
            case 4:
            {
                refundStr = @"请退货";
                break;
            }
            case 6:
            {
                refundStr = @"退款成功";
                break;
            }
            case 7:
            {
                refundStr = @"退货失败";
                break;
            }
            case 8:
            {
                refundStr = @"退货取消";
                break;
            }
                
            default:
                break;
        }
    }


    _refundTypeLbl.text = refundStr;
    
    
}
+(instancetype)cellWidthTableView:(UITableView*)tableView
{
    static NSString *refundIndentify = @"CYRefundTableViewCell";
    CYRefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:refundIndentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYRefundTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
@end
