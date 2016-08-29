//
//  CYBuyerOrderDetailFooterView.m
//  茶语
//
//  Created by Leen on 16/6/15.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerOrderDetailFooterView.h"

@interface CYBuyerOrderDetailFooterView()


@property (weak, nonatomic) IBOutlet UILabel *orderTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *shipmentLbl;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

- (IBAction)unfoldcell_click:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *uofoldBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *eva_cons;

@property (weak, nonatomic) IBOutlet CYBorderButton *evaluationBtn;
@property (weak, nonatomic) IBOutlet CYBorderButton *deleteBtn;

- (IBAction)delete_click:(id)sender;
- (IBAction)evaluation_click:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *gaiLbl;

@end

@implementation CYBuyerOrderDetailFooterView


- (IBAction)unfoldcell_click:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(unfoldTheCell:)]) {
        [self.delegate unfoldTheCell:sender.self];
    }
}

- (void)setModel:(CYBuyerOrderDetailModel *)model
{
    /*
    _model = model;
    
    _numLbl.text = [NSString stringWithFormat:@"数量：%@",_model.commodityCount];
    _priceLbl.text= [NSString stringWithFormat:@"￥%.2f",[_model.orderPrice floatValue]];
    NSInteger status = [_model.status integerValue];
    if ([_model.isEditOrderPrice integerValue] ==1) {
        _gaiLbl.text = @"（改）";
    }
    
    _eva_cons.constant = 65.0f;
    _deleteBtn.hidden = NO;
    NSString *deleteStr = @"";
    NSString *evaStr = @"";
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
            //            evaStr = @"退款";
            _evaluationBtn.hidden = YES;
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
            NSInteger comment_status = [_model.comment_status integerValue];
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
            break;
        }
            
        default:
            break;
    }
    
    [_evaluationBtn setBackgroundColor:MAIN_COLOR];
    [_deleteBtn setTitle:deleteStr forState:UIControlStateNormal];
    [_evaluationBtn setTitle:evaStr forState:UIControlStateNormal];
    
     */
}

- (IBAction)delete_click:(id)sender{
    if ([self.delegate respondsToSelector:@selector(deleteView:WithModel:)]) {
        [self.delegate deleteView:self WithModel:_model];
    }
}
- (IBAction)evaluation_click:(id)sender{
    if ([self.delegate respondsToSelector:@selector(publicVeew:AndModel:)]) {
        [self.delegate publicVeew:self AndModel:_model];
    }
}

@end
