//
//  CYQuanZiTopCell.m
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYQuanZiTopCell.h"

@implementation CYQuanZiTopCell

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
        self.menuclickBlock(sender.tag - 500);
    }
}
@end
