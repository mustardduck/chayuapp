//
//  CYTeaReplyCell.m
//  茶语
//
//  Created by Chayu on 16/7/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaReplyCell.h"


static CYTeaReplyCell *__cell = nil;
@implementation CYTeaReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)parseData:(id)data
{
    NSDictionary *replyinfo = data;
    NSString *nickname = [replyinfo objectForKey:@"nickname"];
    NSString *tonickname = [replyinfo objectForKey:@"tonickname"];
    NSString *titleStr = [NSString stringWithFormat:@"%@回复%@",nickname,tonickname];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [str addAttribute:NSForegroundColorAttributeName value:MAIN_COLOR range:NSMakeRange(0,nickname.length)];
    [str addAttribute:NSForegroundColorAttributeName value:MAIN_COLOR range:NSMakeRange(nickname.length +2,tonickname.length)];
    _huifuLbl.attributedText = str;
    _contentLbl.text = [replyinfo objectForKey:@"content"];
    _timeLbl.text = [replyinfo objectForKey:@"created"];
    _zanLbl.text = [replyinfo objectForKey:@"support"];
    self.replyInfo = data;
}

+ (CGFloat)calcCellHeight:(id)data{
    if (__cell == nil) {
        __cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReplyCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    [__cell parseData:data];
    
    [__cell setNeedsUpdateConstraints];
    [__cell updateConstraintsIfNeeded];
    
    CGFloat height = [__cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    
    return height;
}

@end
