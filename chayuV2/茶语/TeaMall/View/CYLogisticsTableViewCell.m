//
//  CYLogisticsTableViewCell.m
//  TeaMall
//
//  Created by Chayu on 16/1/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYLogisticsTableViewCell.h"
#import "CYOrderGoodsView.h"
@interface CYLogisticsTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *topLin;

@property (weak, nonatomic) IBOutlet UIView *bottomLin;

@property (weak, nonatomic) IBOutlet UIView *statusView;

@property (weak, nonatomic) IBOutlet UILabel *contextLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *status_height_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *status_width_cons;

@end

@implementation CYLogisticsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    _statusView.layer.cornerRadius = _statusView.height/2.0;
}
-(void)setInfo:(NSDictionary *)info
{
    _info = info;
    _contextLbl.text = [info objectForKey:@"context"];
    _timeLbl.text = [info objectForKey:@"time"];
}

- (void)setIsFirst:(BOOL)isFirst
{
    _isFirst = isFirst;
    if (_isFirst) {
        UIColor *greeColor = [UIColor getColorWithHexString:@"24A547"];
        _topLin.hidden = YES;
        _status_height_cons.constant = _status_width_cons.constant =  15;
        _statusView.backgroundColor = greeColor;
        _contextLbl.textColor = greeColor;
    }else{
        ;
        UIColor *garyColor = [UIColor getColorWithHexString:@"c9cacb"];
        _statusView.backgroundColor = garyColor;
        _contextLbl.textColor = garyColor;
        _timeLbl.textColor = garyColor ;
        _topLin.hidden = NO;
        _status_height_cons.constant = _status_width_cons.constant =  10;
    }
    
}

- (void)setIsLast:(BOOL)isLast
{
    _isLast = isLast;
    if (_isLast) {
        _bottomLin.hidden = YES;
    }else{
        _bottomLin.hidden = NO;
    }
}



@end
