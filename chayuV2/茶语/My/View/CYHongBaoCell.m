//
//  CYHongBaoCell.m
//  茶语
//
//  Created by Leen on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHongBaoCell.h"

@implementation CYHongBaoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CYHongBaoModel *)model
{
    _model = model;
    
    _lb_title.text = _model.title;
    _lb_time.text  = [NSString stringWithFormat:@"使用期限%@-%@",_model.start,_model.end];
    _lb_money.text = [NSString stringWithFormat:@"%.f",[_model.money floatValue]];
    _lb_note.text  = _model.qual;
    
    if ([model.status integerValue] ==1) {
        _statusImg.image = [UIImage imageNamed:@"dkq-ksy"];
    }else{
        _statusImg.image = [UIImage imageNamed:@"dkq-ysy"];
    }
    
    
}
@end
