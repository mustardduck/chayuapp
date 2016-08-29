//
//  CYSearchDefaultHeader.m
//  茶语
//
//  Created by Chayu on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSearchDefaultHeader.h"

@interface CYSearchDefaultHeader ()


- (IBAction)menu_click:(id)sender;


@end

@implementation CYSearchDefaultHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)menu_click:(UIButton *)sender {
    if (self.selectMennuBlock) {
        self.selectMennuBlock(sender.tag - 500);
    }
}
@end
