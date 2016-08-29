//
//  CYGiftCollectionViewCell.m
//  TeaMall
//
//  Created by Chayu on 15/11/24.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYGiftCollectionViewCell.h"

@interface CYGiftCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *merch_showimg;

@property (weak, nonatomic) IBOutlet UILabel *merch_Introduction;

//@property (weak, nonatomic) IBOutlet UILabel *merch_Price;

@property (weak, nonatomic) IBOutlet UILabel *merch_Sold;

//@property (nonatomic,weak)UIImageView *statusImg;

@property (nonatomic,weak)UIButton *freeBtn;

@property (nonatomic,weak) IBOutlet UILabel *yilinLbl;


@end


@implementation CYGiftCollectionViewCell



-(void)layoutSubviews
{
    _merch_showimg.width = self.width;
    _merch_showimg.height = self.width;
    
    _merch_Introduction.y = _merch_showimg.height +10;
    _merch_Introduction.width = self.width;
    _merch_Introduction.height = 35;
    
//    _merch_Price.y = _merch_Introduction.height + _merch_Introduction.y + 2;
//    _merch_Price.height = 15;
//    [_merch_Price sizeToFit];
    
    _merch_Sold.y = _merch_Introduction.height + _merch_Introduction.y + 25;
//    _merch_Sold.x = _merch_Price.width +10;
    _merch_Sold.height = 15;
    [_merch_Sold sizeToFit];
    
    _yilinLbl.height = 15;
    _yilinLbl.y = _merch_Sold.y +_merch_Sold.height +5;
    [_yilinLbl sizeToFit];
    
//    _statusImg.width = 40;
//    _statusImg.height = 40;
//    _statusImg.x = self.width-45;
//    _statusImg.y = 5;
//    [_statusImg sizeToFit];
    
    _freeBtn.x = self.width - 90;
    _freeBtn.height = 30.0f;
    _freeBtn.width = 85.0f;
    _freeBtn.y = self.height - 45;
    
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
    CYGiftCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:giftIdentify forIndexPath:indexPath];
    return cell;
}



-(void)setMerchModel:(CYGiftModel *)merchModel
{
    _merchModel = merchModel;
    NSString *imgStr = _merchModel.thumb;
    if (imgStr.length) {
        NSURL *url = [NSURL URLWithString:imgStr];
        [_merch_showimg sd_setImageWithURL:url placeholderImage:nil];
    }
    _merch_Introduction.text = _merchModel.title;
    _merch_Sold.text = [NSString stringWithFormat:@"剩余：%@",_merchModel.stock];
    _yilinLbl.text = [NSString stringWithFormat:@"已领：%@",_merchModel.draw_number];
    if ([_merchModel.stock integerValue]==0) {
        _freeBtn.backgroundColor = [UIColor getColorWithHexString:@"FFF7F2"];
        _freeBtn.layer.borderWidth = 1.0f;
        _freeBtn.layer.borderColor = MAIN_COLOR.CGColor;
        [_freeBtn setTitle:@"已领完" forState:UIControlStateNormal];
        [_freeBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    }else{
        _freeBtn.backgroundColor = MAIN_COLOR;
        _freeBtn.layer.borderWidth = 0.0f;
        _freeBtn.layer.borderColor = CLEARCOLOR.CGColor;
        [_freeBtn setTitle:@"免费领取" forState:UIControlStateNormal];
        [_freeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    
    [_merch_Sold sizeToFit];
    [_yilinLbl sizeToFit];
    
    
//    if ([_merchModel.gid isEqualToString:@"9"]) {
//        _statusImg.image = [UIImage imageNamed:@"tag_master"];
//    }else{
//        _statusImg.image = [UIImage imageNamed:@"tag_famous"];
//    }
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
    
    UILabel *contentLbl = [[UILabel alloc] init];
    _merch_Introduction = contentLbl;
    _merch_Introduction.textColor = TITLECOLOR;
    _merch_Introduction.backgroundColor =CLEARCOLOR;
    _merch_Introduction.font = [UIFont systemFontOfSize:14.0];
    _merch_Introduction.text = @"";
    _merch_Introduction.clipsToBounds = YES;
    _merch_Introduction.numberOfLines = 2.0f;
    [self addSubview:contentLbl];
    
    
    
    UILabel *salesLbl = [[UILabel alloc] init];
    _merch_Sold = salesLbl;
    _merch_Sold.font = FONT(10.0f);
    _merch_Sold.textColor = CONTENTCOLOR;
    _merch_Sold.backgroundColor = CLEARCOLOR;
    _merch_Sold.text = [NSString stringWithFormat:@"剩余：%@",@"20"];
    [self addSubview:salesLbl];
    
//    UIImageView *statusimg = [[UIImageView alloc] init];
//    _statusImg = statusimg;
//    [self addSubview:_statusImg];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    _freeBtn = button;
    _freeBtn.layer.cornerRadius = 3.0f;
    _freeBtn.backgroundColor = MAIN_COLOR;
    _freeBtn.clipsToBounds = YES;
    [_freeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_freeBtn setTitle:@"免费领取" forState:UIControlStateNormal];
    _freeBtn.titleLabel.font = FONT(14.0f);
    [_freeBtn addTarget:self action:@selector(selectFreeGift_click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_freeBtn];
    
    UILabel *yilin = [[UILabel alloc] init];
    _yilinLbl = yilin;
    _yilinLbl.font = FONT(10.0f);
    _yilinLbl.textColor = CONTENTCOLOR;
    _yilinLbl.backgroundColor = CLEARCOLOR;
    _yilinLbl.text = [NSString stringWithFormat:@"已领：%@",@"0"];
    [self addSubview:_yilinLbl];
    
    
}
-(void)selectFreeGift_click:(UIButton *)sender
{
    if ([_merchModel.stock integerValue] == 0) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectiftCell:WithModel:)]) {
        [self.delegate selectiftCell:self WithModel:_merchModel];
    }
}

@end
