//
//  CYBaseLabel.m
//  TeaTimer
//
//  Created by Leen on 15/7/13.
//  Copyright (c) 2015年 ChaYu. All rights reserved.
//

#import "LDXBaseLabel.h"

@implementation LDXBaseLabel


- (void) awakeFromNib{
    [super awakeFromNib];
    [self setup];
}


- (void)setup{
    [self setLableStyle:_style];
    
//    self.layer.borderWidth = 2.f;
//    self.layer.borderColor = [COLOR_LABAL_BORDRR CGColor];
//    
//    self.textColor = COLOR_LABAL_TEXT;
//    
//    self.layer.cornerRadius = self.bounds.size.height/2.f;
//    self.layer.masksToBounds = YES;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation UILabel (Extension)

- (void) setLableStyle:(NSInteger)style
{
    
    //1.标题 2.副标题 3.内容标题 4.标注 5.正文 6.名字 7.提示标签
    switch (style) {
        case 1:
            self.font = [UIFont systemFontOfSize:18];
            self.textColor = COLOR_LABAL_SECTIONTEXT;
            break;
        case 2:
            self.font = [UIFont systemFontOfSize:14];
            self.textColor = COLOR_LABAL_SUBSECTIONTEXT;
            break;
        case 3:
            self.font = [UIFont boldSystemFontOfSize:28];
            self.textColor = COLOR_LABAL_TITLETEXT;
            break;
        case 4:
            self.font = [UIFont systemFontOfSize:11];
            self.textColor = COLOR_LABAL_NODETEXT;
            break;
        case 5:
            self.font = [UIFont systemFontOfSize:16];
            self.textColor = COLOR_LABAL_CONTENTTEXT;
        case 6:
            self.font = [UIFont systemFontOfSize:14];
            self.textColor = COLOR_LABAL_NAMETEXT;
            break;
        case 7:
            self.font = [UIFont systemFontOfSize:12];
            self.textColor = COLOR_LABAL_BRADGETEXT;
            self.backgroundColor = MAIN_COLOR;
            
            self.layer.cornerRadius = self.bounds.size.height/2.f;
            self.layer.masksToBounds = YES;
            
            break;
        default:
            break;
    }
}
@end
