//
//  CYBuyerMainCell.m
//  茶语
//
//  Created by Leen on 16/5/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerMainCell.h"
#import "CYRoundLbl.h"
#import "BaseButton.h"

@interface CYBuyerMainCell()


@property (weak, nonatomic) IBOutlet UIImageView *showImage;

/**
 *  茗星头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *buyerImg;

@property (weak, nonatomic) IBOutlet UILabel *buyerNameLbl;

/**
 *  商品介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *goods_content;
@property (weak, nonatomic) IBOutlet UILabel *heartCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLbl;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@end

@implementation CYBuyerMainCell

- (void)awakeFromNib {
    // Initialization code
    
    _buyerImg.layer.cornerRadius = _buyerImg.height/2.;
    _buyerImg.layer.borderColor = [UIColor whiteColor].CGColor;
    _buyerImg.layer.borderWidth = 1.0f;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBuyer:)];
    [_buyerImg addGestureRecognizer:tap];
    tap = nil;
}

- (void) selectBuyer:(UIGestureRecognizer *)sender
{
    if([self.delegate respondsToSelector:@selector(cell:buyerModel:)])
    {
        [self.delegate cell:self buyerModel:_model];
    }
}

//- (void)setPDmodel:(CYBuyerPDCellModel *)model
//{
//    _PDmodel = model;
//    
//    [_showImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"750×500"]];
//    [_buyerImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:DEFAULTHEADER];
//    _buyerNameLbl.text = model.realname;
//    _goods_content.text = model.name;
//    _heartCountLbl.text = model.enjoy;
//    _commentCountLbl.text = model.comment_count;
//    _priceLbl.text = [NSString stringWithFormat:@"￥%@", model.price_sell];
//    
//    self.height = SCREEN_WIDTH * 250 / 375 + 90;
//}


- (void)setModel:(CYBuyerMainCellModel *)model
{
    _model = model;
    
    [_showImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"750×500"]];
    [_buyerImg sd_setImageWithURL:[NSURL URLWithString:model.selleravatar] placeholderImage:DEFAULTHEADER];

    _buyerNameLbl.text = model.sellername;
    _goods_content.text = model.title;
    _heartCountLbl.text = model.enjoy_count.length ? model.enjoy_count : @"0";
    _commentCountLbl.text = model.comment_count.length ? model.comment_count : @"0";
    _priceLbl.text = [NSString stringWithFormat:@"￥%@", model.price_sell];
        
    self.height = SCREEN_WIDTH * 250 / 375 + 90;

}

+(instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString *cellID = @"CYBuyerMainCell";
    
    CYBuyerMainCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
