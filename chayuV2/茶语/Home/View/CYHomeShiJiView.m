//
//  CYHomeShiJiView.m
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeShiJiView.h"

@interface CYHomeShiJiView ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation CYHomeShiJiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setMarkerInfo:(CYHomeMarkertInfo *)markerInfo
{
    _markerInfo = markerInfo;
    NSString *attrStr = [NSString stringWithFormat:@"%@ | %@",_markerInfo.tags,_markerInfo.title];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:attrStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"893e20"] range:NSMakeRange(0,_markerInfo.tags.length +2)];
    _showImg.clipsToBounds = YES;
    [_showImg sd_setImageWithURL:[NSURL URLWithString:_markerInfo.thumb] placeholderImage:[UIImage imageNamed:@"750×500"]];
    
    _content.attributedText = str;
}

@end
