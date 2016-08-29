//
//  CYOrderGoodsView.m
//  TeaMall
//
//  Created by Chayu on 15/11/6.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYOrderGoodsView.h"


@interface CYOrderGoodsView ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *standardLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLbl;

@property (weak, nonatomic) IBOutlet CYBorderButton *returnBtn;
- (IBAction)return_click:(id)sender;

@end

@implementation CYOrderGoodsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews{
 
}

- (void)awakeFromNib
{
//    UIView *view = _showImg;
//    view.layer.borderColor = LINECOLOR.CGColor;
//    view.layer.borderWidth = 1.0f;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGoodsDetail:)];
//    [_showImg addGestureRecognizer:tap];
}

-(IBAction)showGoodsDetail:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(showgoodsdetails:)]) {
        [self.delegate showgoodsdetails:_goodsInfo];
    }
}

- (void)setGoodsInfo:(CYShopTrolleyModel *)goodsInfo
{
    _goodsInfo = goodsInfo;
    NSString *imgUrlStr = _goodsInfo.thumb;
    if (imgUrlStr.length) {
        NSURL *url = [NSURL URLWithString:imgUrlStr];
        [_showImg sd_setImageWithURL:url placeholderImage:nil];
    }
    _contentLbl.text = _goodsInfo.name;
    _standardLbl.text = _goodsInfo.spec;
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",_goodsInfo.commodityPrice];
    _goodsNumLbl.text = [NSString stringWithFormat:@"x%@",_goodsInfo.goodsNumber];
    NSDictionary *info = _goodsInfo.backInfo;
    NSInteger refundType = [[info objectForKey:@"refundType"] integerValue];
    NSInteger shippingStatus = [[info objectForKey:@"shippingStatus"]integerValue];
    NSInteger states = [[info objectForKey:@"status"] integerValue];
    if (refundType == 1) {//退款
        switch (states) {
            case 0:
            {
                [_returnBtn setTitle:@"退款中" forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                  [_returnBtn setTitle:@"退款成功" forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                  [_returnBtn setTitle:@"退款失败" forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                  [_returnBtn setTitle:@"退款取消" forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
    }else{
        switch (shippingStatus) {
            case 3:
            case 5:
            {
                  [_returnBtn setTitle:@"退货中" forState:UIControlStateNormal];
            }
                break;
            case 4:
            {
                  [_returnBtn setTitle:@"请退货" forState:UIControlStateNormal];
                
            }
                break;
            case 6:
            {
                  [_returnBtn setTitle:@"退货成功" forState:UIControlStateNormal];
            }
                break;
            case 7:
            {
                  [_returnBtn setTitle:@"拒绝退货" forState:UIControlStateNormal];
            }
                break;
            case 8:
            {
                  [_returnBtn setTitle:@"退货取消" forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)setStatus:(NSString *)status
{
    _status = status;
    if (![_status isEqualToString:@"1"]) {
        _returnBtn.hidden = YES;
    }
}


- (IBAction)return_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(refundTheGoodsModel:)]) {
        [self.delegate refundTheGoodsModel:_goodsInfo];
    }
}
@end
