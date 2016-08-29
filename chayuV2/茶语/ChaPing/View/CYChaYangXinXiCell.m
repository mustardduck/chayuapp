//
//  CYChaYangXinXiCell.m
//  茶语
//
//  Created by Chayu on 16/7/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYChaYangXinXiCell.h"

@implementation CYChaYangXinXiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString *title = @"此茶市集有售，前去购买>>";
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:title];
    [attrStr1 addAttribute:NSForegroundColorAttributeName value:MAIN_COLOR range:NSMakeRange(7,6)];
    [_goumaiBtn setAttributedTitle:attrStr1 forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
