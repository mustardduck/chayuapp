//
//  CYChaLiCell.m
//  茶语
//
//  Created by Chayu on 16/6/3.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYChaLiCell.h"

@implementation CYChaLiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = _numBg;
    view.layer.borderColor = LINECOLOR.CGColor;
    view.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(NSDictionary *)info
{
    _info = info;
    _numLbl.text = [[_info objectForKey:@"maxNumber"] description];
}

- (IBAction)less_click:(id)sender {
    NSInteger goodnum = [_numLbl.text integerValue];
    if (goodnum>1) {
        goodnum --;
        _numLbl.text = [NSString stringWithFormat:@"%d",(int)goodnum];
        if ([self.delegate respondsToSelector:@selector(changeTeaSamNum:andCoinNum:)]) {
            [self.delegate changeTeaSamNum:self andCoinNum:goodnum];
        }
    }
}

- (IBAction)add_click:(id)sender {
    NSInteger goodnum = [_numLbl.text integerValue];
    NSInteger maxNum = [[_info objectForKey:@"maxNumber"] integerValue];
    if (goodnum<maxNum) {
        goodnum ++;
        _numLbl.text = [NSString stringWithFormat:@"%d",(int)goodnum];
        if ([self.delegate respondsToSelector:@selector(changeTeaSamNum:andCoinNum:)]) {
            [self.delegate changeTeaSamNum:self andCoinNum:goodnum];
        }
    }else{
        NSString *alt = [NSString stringWithFormat:@"你最多只能兑换%@份",@(maxNum)];
        [Itost showMsg:alt inView:WINDOW];
    }
}
@end
