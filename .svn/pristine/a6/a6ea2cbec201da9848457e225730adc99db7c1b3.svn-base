//
//  CYCorderFooterView.m
//  茶语
//
//  Created by Chayu on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCorderFooterView.h"
#import "PYMultiLabel.h"
#import "UIColor+Additions.h"

@interface CYCorderFooterView ()

@property (weak, nonatomic) IBOutlet UILabel *realpriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *allpriceLbl;
@property (weak, nonatomic) IBOutlet PYMultiLabel *goodsnumLbl;
@property (weak, nonatomic) IBOutlet UILabel *couppriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *shippriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *invoiceLbl;
@property (weak, nonatomic) IBOutlet UIView *invoiceView;

@end


@implementation CYCorderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setOrderInfo:(NSDictionary *)orderInfo
{
    _orderInfo = orderInfo;
    CGFloat allprcie = [[_orderInfo objectForKey:@"allprcie"] floatValue];
    CGFloat coupprice = [[_orderInfo objectForKey:@"coupprice"] floatValue];
    CGFloat shipprice = [[_orderInfo objectForKey:@"shipprice"] floatValue];
    CGFloat invoicePrice = [[_orderInfo objectForKey:@"invoicePrice"] floatValue];
    
    _goodsnumLbl.text = [NSString stringWithFormat:@"%@件商品",[_orderInfo objectForKey:@"goodsnum"]];
    [_goodsnumLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(0, _goodsnumLbl.text.length - 3)];
    
    _realpriceLbl.text = [NSString stringWithFormat:@"￥%.2f",allprcie-coupprice+shipprice + invoicePrice];
    _allpriceLbl.text = [NSString stringWithFormat:@"￥%.2f",allprcie];
    _couppriceLbl.text = [NSString stringWithFormat:@"-￥%.2f",coupprice];
    _shippriceLbl.text = [NSString stringWithFormat:@"+￥%.2f",shipprice];
    
    if(invoicePrice)
    {
        _invoiceLbl.text = [NSString stringWithFormat:@"+￥%.2f",invoicePrice];
        _invoiceView.hidden = NO;
        
        self.height = 183;
    }
    else
    {
        _invoiceView.hidden = YES;
        
        self.height = 151;
    }

}

@end
