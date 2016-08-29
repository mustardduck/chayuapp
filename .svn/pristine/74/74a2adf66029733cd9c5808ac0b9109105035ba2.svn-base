//
//  CYWoDePingLunCell.m
//  茶语
//
//  Created by Chayu on 16/7/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWoDePingLunCell.h"

@implementation CYWoDePingLunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)tableCellHeight:(NSDictionary *)info andType:(NSInteger)type
{
    CGFloat height = 150.;
    if (type == 0) {
        NSString *content = [info objectForKey:@"content"];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.]};
        CGSize lableSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-90,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        height -=17;
        height +=lableSize.height+1;
        NSDictionary *article = [info objectForKey:@"article"];
        NSString *title = [NSString stringWithFormat:@"原文 |%@",[article objectForKey:@"title"]];
        lableSize =[title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-110,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        height -=17.0;
        height +=lableSize.height;
    }else{
   
        NSDictionary *article = [info objectForKey:@"reply"];
        NSString *content = [article objectForKey:@"content"];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.]};
        CGSize lableSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-90,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        height -=17;
        height +=lableSize.height+1;
       
        NSString *title = [NSString stringWithFormat:@"我的评论 |%@",[article objectForKey:@"parentContent"]];
        lableSize =[title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-110,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        height -=17.0;
        height +=lableSize.height+1;
    }
  
    return height;
}


-(CGFloat)lableHeightWithString:(NSString *)string Size:(CGSize )size
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12.]};
    CGSize lableSize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return lableSize.height;
}

@end
