//
//  CYRoundLbl.m
//  TeaMall
//
//  Created by Chayu on 15/10/29.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYRoundLbl.h"

@implementation CYRoundLbl


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
}
- (void)layoutSubviews
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.height/2.0f;
    if (!self.text || self.text.length == 0 || [self.text isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
}


@end
