//
//  CYMyMessageCell.m
//  茶语
//
//  Created by Chayu on 16/7/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYMyMessageCell.h"

@implementation CYMyMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)menu_click:(UIButton *)sender {
    if (self.menuclickBlock) {
        self.menuclickBlock(sender.tag - 9000);
    }
}
@end
