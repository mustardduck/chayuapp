//
//  CYBuyerMyOrderCell.m
//  茶语
//
//  Created by Leen on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerMyOrderCell.h"
#import "CYBuyerOrderDetailProductCell.h"

@implementation CYBuyerMyOrderCell

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
    static NSString *myorderIdentify = @"CYBuyerMyOrderCell";
    CYBuyerMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:myorderIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerMyOrderCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setOrderModel:(CYBuyerOrderInfoModel *)orderModel
{
    /*
    _orderModel = orderModel;
    if (_orderModel.sellerAvatar.length) {
        NSURL *userUrl = [NSURL URLWithString:_orderModel.sellerAvatar];
        [_userImg sd_setImageWithURL:userUrl placeholderImage:DEFAULTHEADER];
    }
    _userNameLbl.text = _orderModel.sellerName;
    _goodsbg_cons.constant = [_orderModel.goodsList count]*88.0;
    _allNumLbl.text = [NSString stringWithFormat:@"共%@件商品",_orderModel.commodityCount];
    NSString *goodsprice = [NSString stringWithFormat:@"￥%.2f",[_orderModel.orderPrice floatValue]];
    NSString *totalStr = [NSString stringWithFormat:@"实付款：%@(含运费：￥%@)",goodsprice,_orderModel.ship_price];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:14.0],NSFontAttributeName,
                                   MAIN_COLOR,NSForegroundColorAttributeName,
                                   nil];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    [attr setAttributes:attributeDict range:NSMakeRange(4, goodsprice.length)];
    _allPriceLbl.attributedText = attr;
    _deleteBtn.hidden = NO;
    NSString *deleteStr = @"";
    NSString *evaStr = @"";
    [_evaluationBtn setBackgroundColor:MAIN_COLOR];
    _evaluationBtn.borderWidth = 0;
    NSInteger status = [_orderModel.status integerValue];
    //订单状态(string) [1待付款，2待发货，3待收货，5交易成功，6交易关闭]
    
    switch (status) {
        case 1:
        {
            _orderTypeLbl.text = @"待付款";
            deleteStr = @"取消订单";
            evaStr = @"付款";
            break;
        }
        case 2:
        {
            evaStr = @"退款";
            _deleteBtn.hidden = YES;
            _orderTypeLbl.text = @"待发货";
            break;
        }
        case 3:
        {
            evaStr = @"确认收货";
            deleteStr = @"查看物流";
            _orderTypeLbl.text = @"待收货";
            break;
        }
        case 5:
        {
            NSInteger comment_status = [_orderModel.comment_status integerValue];
            _orderTypeLbl.text = @"交易完成";
            if (comment_status == 2) {
                deleteStr = @"删除订单";
                _deleteBtn.hidden = YES;
                evaStr = @"删除订单";
            }else if(comment_status == 0){
                deleteStr = @"删除订单";
                evaStr = @"评价";
                
            }else{
                deleteStr = @"删除订单";
                evaStr = @"追加评价";
            }
            break;
        }
        case 6:
        {
            _deleteBtn.hidden = YES;
            deleteStr = @"删除订单";
            evaStr = @"删除订单";
            _orderTypeLbl.text = @"交易关闭";
            [_evaluationBtn setBackgroundColor:CLEARCOLOR];
            _evaluationBtn.borderColor = [UIColor getColorWithHexString:@"cccccc"];
            [_evaluationBtn setTitleColor:TITLECOLOR forState:UIControlStateNormal];
            _evaluationBtn.borderWidth = 1;
            break;
        }
            
        default:
            break;
    }
    
    
    [_deleteBtn setTitle:deleteStr forState:UIControlStateNormal];
    [_evaluationBtn setTitle:evaStr forState:UIControlStateNormal];
    [self loadGoodsView:_orderModel.goodsList];
     */
}

-(void)loadGoodsView:(NSArray *)arr
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i =0; i<[arr count]; i++) {
            CYBuyerOrderDetailProductCell *goodsView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerOrderDetailProductCell" owner:nil options:nil] firstObject];

            [_orderView addSubview:goodsView];
        }
    });
    
}

@end
