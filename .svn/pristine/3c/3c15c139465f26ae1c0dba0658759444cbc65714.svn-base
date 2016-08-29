//
//  CYChaPingTopCell.m
//  茶语
//
//  Created by Chayu on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYChaPingTopCell.h"

@interface CYChaPingTopCell ()




@end

@implementation CYChaPingTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)topbtn_click:(UIButton *)sender {
    
    for (int i =500; i<503; i++) {
        UIButton *button = (UIButton *)[_contentBgView viewWithTag:i];
        if (sender.tag == i) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(topSelect:)]) {
        [self.delegate topSelect:sender.tag - 500];
    }
}
@end
