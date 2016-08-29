//
//  CYMerchCollectionCell.m
//  TeaMall
//
//  Created by Chayu on 15/10/22.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMerchCollectionCell.h"
#import "SlipView.h"
#import "UILabel+Utilities.h"

@interface CYMerchCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *merch_showimg;

@property (weak, nonatomic) IBOutlet UILabel *merch_Introduction;

@property (weak, nonatomic) IBOutlet UILabel *merch_Price;

@property (weak, nonatomic) IBOutlet UILabel *merch_Sold;

@property (nonatomic,weak)UIImageView *statusImg;


@property (nonatomic,weak)UIImageView *isNewImg;

/**
 *  <#属性说明#>
 */
@property (nonatomic,weak)IBOutlet SlipView *slipView;


@end


@implementation CYMerchCollectionCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];
}



-(void)layoutSubviews
{
    _merch_showimg.width = self.width;
    _merch_showimg.height = self.width;
    _merch_showimg.layer.cornerRadius = 2.0f;
    

    
    _merch_Introduction.x = 10;
    _merch_Introduction.width = self.width-20;
    _merch_Introduction.height = 35;
    
    if(_merch_Introduction.text.length)
    {
        CGFloat he = [_merch_Introduction boundingRectWithHeight];
        
        if(he < 17)
        {
            _merch_Introduction.y =  _merch_showimg.height + 2;
        }
        else
        {
            _merch_Introduction.y = _merch_showimg.height +10;
        }
    }
    
    _slipView.y = _merch_Introduction.y +_merch_Introduction.height +10;
    _slipView.x = 10;
    _slipView.width = self.width - 20;
    _slipView.height = 1;
    
    
    
    _merch_Price.y = _merch_Introduction.height + _merch_Introduction.y + 20;
    _merch_Price.x = 10;
    _merch_Price.height = 15;
    [_merch_Price sizeToFit];
    
    _merch_Sold.y = _merch_Price.y +1;
    _merch_Sold.x = self.width - _merch_Sold.width -10;
    _merch_Sold.height = 15;
    [_merch_Sold sizeToFit];
    
    
    _statusImg.width = 40;
    _statusImg.height = 40;
    _statusImg.x = self.width-59;
    _statusImg.y = _merch_showimg.height - 59;
    [_statusImg sizeToFit];
    
    _isNewImg.width = _isNewImg.height  = 29;
//    [_isNewImg sizeToFit];
     _isNewImg.x = _isNewImg.y = 1;
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

/**
 *  创建cell(从缓存池中取)
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView ItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYMerchCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:merchIdentify forIndexPath:indexPath];
    return cell;
}

- (void)setPDCellModel:(CYBuyerPDCellModel *)merchModel
{
    _PDCellModel = merchModel;
    NSURL *url = [NSURL URLWithString:_PDCellModel.thumb];
    [_merch_showimg sd_setImageWithURL:url placeholderImage:SQUARE];
    
    _merch_Introduction.text = _PDCellModel.name;

    _merch_Price.text = [NSString stringWithFormat:@"￥%.2f",[_PDCellModel.price_sell floatValue]];
    _merch_Sold.text = [NSString stringWithFormat:@"已售：%@",_PDCellModel.pay_count];
    [_merch_Price sizeToFit];
    [_merch_Sold sizeToFit];
    _statusImg.hidden = YES;
    _isNewImg.hidden = YES;
    
//    if ([_PDCellModel.sold_out integerValue] == 0) {
//        _statusImg.hidden = NO;
//        _statusImg.image = [UIImage imageNamed:@"sold_out"];
//    }else{
//        
//        if ([_PDCellModel.is_hot integerValue] == 1) {
//            _isNewImg.hidden = NO;
//            _isNewImg.image = [UIImage imageNamed:@"hot_shiji"];
//        }
//        
//        if ([_PDCellModel.is_new integerValue] == 1) {
//            _isNewImg.hidden = NO;
//            _isNewImg.image = [UIImage imageNamed:@"new"];
//        }
//    }
}

-(void)setMerchModel:(CYMerchCellModel *)merchModel
{
    _merchModel = merchModel;
    NSURL *url = [NSURL URLWithString:_merchModel.thumb];
    [_merch_showimg sd_setImageWithURL:url placeholderImage:SQUARE];

    _merch_Introduction.text = _merchModel.name;
    
    _merch_Price.text = [NSString stringWithFormat:@"￥%.2f",[_merchModel.priceSell floatValue]];
    _merch_Sold.text = [NSString stringWithFormat:@"已售：%@",_merchModel.salesBase];
    [_merch_Price sizeToFit];
    [_merch_Sold sizeToFit];
    _statusImg.hidden = YES;
    _isNewImg.hidden = YES;
  
    
    if ([_merchModel.sold_out integerValue] == 0) {
        _statusImg.hidden = NO;
        _statusImg.image = [UIImage imageNamed:@"sold_out"];
    }else{

        if ([_merchModel.is_hot integerValue] == 1) {
            _isNewImg.hidden = NO;
            _isNewImg.image = [UIImage imageNamed:@"hot_shiji"];
        }
        
        if ([_merchModel.is_new integerValue] == 1) {
            _isNewImg.hidden = NO;
            _isNewImg.image = [UIImage imageNamed:@"new"];
        }
    }
}

-(void)setupCell
{
    UIImageView *showImg = [[UIImageView alloc] init];
    _merch_showimg = showImg;
    _merch_showimg.contentMode = UIViewContentModeScaleAspectFill;
    _merch_showimg.clipsToBounds = YES;
    _merch_showimg.layer.borderColor = BORDERCOLOR.CGColor;
    _merch_showimg.layer.borderWidth = 1.0f;
    [self addSubview:showImg];
    
    
    SlipView *slip = [[SlipView alloc] init];
    _slipView = slip;
    _slipView.backgroundColor = BORDERCOLOR;
    _slipView.lineStyle = 2;
    [self addSubview:_slipView];
    
    UILabel *contentLbl = [[UILabel alloc] init];
    _merch_Introduction = contentLbl;
    _merch_Introduction.textColor = TITLECOLOR;
    _merch_Introduction.backgroundColor =CLEARCOLOR;
    _merch_Introduction.font = [UIFont systemFontOfSize:14.0];
    _merch_Introduction.clipsToBounds = YES;
    _merch_Introduction.numberOfLines = 2.0f;
    [self addSubview:contentLbl];
    
    
    UILabel *priceLable = [[UILabel alloc] init];
    _merch_Price = priceLable;
    _merch_Price.textColor = MAIN_COLOR;
    _merch_Price.font = FONT(14.f);
    _merch_Price.backgroundColor = CLEARCOLOR;
    _merch_Price.clipsToBounds = YES;
    [self addSubview:priceLable];
    
    
    UILabel *salesLbl = [[UILabel alloc] init];
    _merch_Sold = salesLbl;
    _merch_Sold.font = FONT(10.0f);
    _merch_Sold.textColor = LIGHTCOLOR;
    _merch_Sold.backgroundColor = CLEARCOLOR;
    [self addSubview:salesLbl];
    
    UIImageView *statusimg = [[UIImageView alloc] init];
    _statusImg = statusimg;
    [self addSubview:_statusImg];
    
    
    UIImageView *isnewimg = [[UIImageView alloc] init];
    _isNewImg = isnewimg;
    [self addSubview:_isNewImg];

}

@end
