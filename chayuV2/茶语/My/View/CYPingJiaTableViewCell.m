//
//  CYPingJiaTableViewCell.m
//  茶语
//
//  Created by Chayu on 16/8/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPingJiaTableViewCell.h"


static CYPingJiaTableViewCell *__cell = nil;
@implementation CYPingJiaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    if (!_model) {
    
//    for (UIView *view in _imgchooseView.subviews) {
//        [view removeFromSuperview];
//    }
////    
//    [_imgchooseView addSubview:self.albumView];
//    UIView *view = _evaBg;
//    view.layer.borderColor = [UIColor getColorWithHexString:@"eeeeee"].CGColor;
//    view.layer.borderWidth = 1.0f;
//    view.layer.cornerRadius = 3.0f;
//    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)setModel:(CYShopTrolleyModel *)model
{
    _model = model;
//    if (_model.thumb.length) {
//        NSURL *url = [NSURL URLWithString:_model.thumb];
//        [_showimg sd_setImageWithURL:url placeholderImage:nil];
//        
//    }
//    _starView.show_star = [model.score integerValue];
//    _priceLbl.text = [NSString stringWithFormat:@"￥%@",_model.commodityPrice];
//    _titleLbl.text = _model.name;
//    _guigeLbl.text = _model.spec;
//    _evaTxt.placeholder = @"其他买家，需要您的建议哦！撰写评价可获得20贡献值";
//    if (model.imgArr) {
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSInteger imgcount = model.imgArr.count;
//            if (imgcount <5) {
//                _imgchooseheight_cons.constant = ceilf((imgcount +1)/4.)*82*SCREENBILI +58;
//            }else{
//                _imgchooseheight_cons.constant = ceilf(imgcount/4.)*82*SCREENBILI  +58;
//            }
//            [_ctnView layoutIfNeeded];
//            self.albumView.height = _imgchooseView.height;
//            self.albumView.selectArr = [NSMutableArray arrayWithArray:model.imgArr];
//            [self.albumView reloadImgData];
////        });
//     
//    }
}


@end
