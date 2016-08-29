//
//  CYTeaListCell.m
//  TeaMall
//
//  Created by Chayu on 15/10/27.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYTeaListCell.h"
static NSString *teaListCellIdentify = @"CYTeaListCell";
@interface CYTeaListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *soldLbl;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIView *waitView;

@end

@implementation CYTeaListCell

- (void)awakeFromNib {
    _showImg.layer.borderColor = LINECOLOR.CGColor;
    _showImg.layer.borderWidth = 1.0f;
    [self.contentView sendSubviewToBack:_waitView];
}
-(void)drawRect:(CGRect)rect
{
    
}
-(void)layoutSubviews
{
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView *)tableView
{
    
    CYTeaListCell *cell = [tableView dequeueReusableCellWithIdentifier:teaListCellIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaListCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)setTeaModel:(CYTeaListModel *)teaModel
{
    _teaModel = teaModel;
    NSURL *url = [NSURL URLWithString:_teaModel.thumb];
    [_showImg sd_setImageWithURL:url placeholderImage:nil];
    _titleLbl.text = _teaModel.name;
    _contentLbl.text = _teaModel.desc;
    _priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[_teaModel.price_sell floatValue]];
    _soldLbl.text = [NSString stringWithFormat:@"已售 %@",_teaModel.sales_base];
    if (![_teaModel.mainid isEqualToString:@"13"]) {
        [_clickBtn setTitle:@"商品详情" forState:UIControlStateNormal];
    }else{
        [_clickBtn setTitle:@"好茶详情" forState:UIControlStateNormal];
    }
    
}

@end
