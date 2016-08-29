//
//  CYQuanZiView.m
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeQuanZiView.h"

@interface CYHomeQuanZiView ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *guanzhuLbl;
@property (weak, nonatomic) IBOutlet UILabel *tieziLbl;
@property (weak, nonatomic) IBOutlet UILabel *quanzhuLbl;


@end

@implementation CYHomeQuanZiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setNewsInfo:(CYHomeQuanInfo *)newsInfo
{
    _newsInfo = newsInfo;
    [_showImg sd_setImageWithURL:[NSURL URLWithString:_newsInfo.thumb] placeholderImage:[UIImage imageNamed:@"750×340"]];
    _content.text = _newsInfo.title;
    NSDictionary *source = _newsInfo.source;
    if ([_newsInfo.resource_type isEqualToString:@"3"]) {
        _guanzhuLbl.text = [NSString stringWithFormat:@"关注：%@",[source objectForJSONKey:@"attention_num"]];
        _tieziLbl.text = [NSString stringWithFormat:@"帖子：%@",[source objectForJSONKey:@"posts"]];
        _quanzhuLbl.text = [NSString stringWithFormat:@"圈主：%@",[source objectForJSONKey:@"nickname"]];
    }else{
        _guanzhuLbl.text = [NSString stringWithFormat:@"评论：%@",[source objectForJSONKey:@"replies"]];
        _tieziLbl.text = [NSString stringWithFormat:@"阅读：%@",[source objectForJSONKey:@"hits"]];
        _quanzhuLbl.text = [NSString stringWithFormat:@"贴主：%@",[source objectForJSONKey:@"nickname"]];
    }
   
    
}

@end
