//
//  CYQuanZiItemCell.m
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYQuanZiItemCell.h"

@interface CYQuanZiItemCell ()




@end

@implementation CYQuanZiItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(NSArray *)info
{
    _info = info;
    for (int i = 0; i<[_info count]; i++) {
        NSDictionary *quanziinfo = _info[i];
        UIView *view =[self.contentView viewWithTag:300+i];
        UIImageView *showimg = [view viewWithTag:400+i];
        UILabel *titleLbl = [view viewWithTag:500+i];
        UILabel *guanzhuLbl = [view viewWithTag:600+i];
        UILabel *tieziLbl = [view viewWithTag:700+i];
        NSString *imgurl = [quanziinfo objectForKey:@"thumb"];
        if (imgurl.length) {
             [showimg sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:SQUARE];
        }
      
        titleLbl.text = [quanziinfo objectForJSONKey:@"title"];
        NSDictionary *source = [quanziinfo objectForJSONKey:@"source"];
        if (![source isKindOfClass:[NSNull class]]) {
            guanzhuLbl.text = [NSString stringWithFormat:@"关注：%@",[source objectForJSONKey:@"attention_num"]];
            tieziLbl.text = [NSString stringWithFormat:@"帖子：%@",[source objectForJSONKey:@"posts"]];
        }
 
    }
}

- (IBAction)quanzi_click:(UIButton *)sender {
    if (self.quanziBlock) {
        self.quanziBlock(sender.tag - 650);
    }
}
@end
