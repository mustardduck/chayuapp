//
//  CYShoppingTrolleyCell.m
//  TeaMall
//
//  Created by Chayu on 15/10/28.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYShoppingTrolleyCell.h"

@interface CYShoppingTrolleyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *specMesLbl;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIView *goodsNumBg;
@property (weak, nonatomic) IBOutlet UIButton *lessbtn;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;

- (IBAction)choose_goods_click:(id)sender;


- (IBAction)changeGoodsNum_click:(id)sender;

@end

@implementation CYShoppingTrolleyCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews
{
    
    _goodsNumBg.layer.borderColor = LINECOLOR.CGColor;
    _goodsNumBg.layer.borderWidth = 1.0f;
    _goodsNumLbl.layer.borderColor = LINECOLOR.CGColor;
    _goodsNumLbl.layer.borderWidth = 1.0f;
    _showImg.layer.borderColor = LINECOLOR.CGColor;
    _showImg.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWidthTableView:(UITableView *)tableView
{
    static NSString *shopTrolleyIden = @"CYShoppingTrolleyCell";
    CYShoppingTrolleyCell *cell = [tableView dequeueReusableCellWithIdentifier:shopTrolleyIden];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYShoppingTrolleyCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setShopTrolleyModel:(CYShopTrolleyModel *)shopTrolleyModel
{
    _shopTrolleyModel = shopTrolleyModel;
    NSURL *url = [NSURL URLWithString:shopTrolleyModel.thumb];
    [_showImg sd_setImageWithURL:url];
    _contentLbl.text = _shopTrolleyModel.name;
    _specMesLbl.text  = _shopTrolleyModel.spec;
    _price.text = [NSString stringWithFormat:@"￥%.2f",[_shopTrolleyModel.price floatValue]];
    _goodsNumLbl.text = _shopTrolleyModel.goodsNumber;
    if (_shopTrolleyModel.isSelect) {
        _selectButton.selected = YES;
    }else{
        _selectButton.selected = NO;
    }
}




- (IBAction)choose_goods_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectgoods:andModel:)]) {
        [self.delegate selectgoods:self andModel:_shopTrolleyModel];
    }
}

- (IBAction)changeGoodsNum_click:(id)sender {
    UIButton *selectBtn = (UIButton *)sender;
        NSInteger goodsNum = [_goodsNumLbl.text integerValue];
    BOOL isAdd = NO;
    if (selectBtn == _addbtn) {
        if (goodsNum <[_shopTrolleyModel.stock integerValue]-1) {
            goodsNum ++;
        }else{
            [Itost showMsg:@"库存不足" inView:WINDOW];
            return;
        }
        
        isAdd = YES;
    }else{
        
        if (goodsNum<2) {
            return;
        }
        goodsNum --;
        isAdd = NO;
    }
    _shopTrolleyModel.goodsNumber = [NSString stringWithFormat:@"%d",(int)goodsNum];
    if ([self.delegate respondsToSelector:@selector(changeGoodsNum:Model:IsAdd:)]) {
        [self.delegate changeGoodsNum:self Model:_shopTrolleyModel IsAdd:isAdd];
    }
    
}
@end
