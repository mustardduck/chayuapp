//
//  CYWuliuTableViewCell.m
//  茶语
//
//  Created by Chayu on 16/4/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWuliuTableViewCell.h"

@implementation CYWuliuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelected:(BOOL)selected
{
    _isSelect = selected;
//    _stateImg.highlighted = _isSelect;
}

- (void)setInfo:(NSDictionary *)info
{
    _info = info;
    _titleLbl.text = [_info objectForKey:@"name"];
    BOOL select = [[_info objectForKey:@"select"] boolValue];
    _stateImg.highlighted = select;
}


@end
