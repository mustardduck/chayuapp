//
//  CYHomeWenZhangView.m
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeWenZhangView.h"
#import "PYMultiLabel.h"
#import "UIColor+Additions.h"

@interface CYHomeWenZhangView ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;


@property (weak, nonatomic) IBOutlet PYMultiLabel *contentLbl;

@property (weak, nonatomic) IBOutlet UILabel *zanLbl;

@property (weak, nonatomic) IBOutlet UILabel *liulanLbl;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *toutiaoIcon;

@end

@implementation CYHomeWenZhangView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setNewsInfo:(CYHomeToDayNewsInfo *)newsInfo
{
    _newsInfo = newsInfo;
    
//    NSString *attrStr = [NSString stringWithFormat:@"%@ | %@",_newsInfo.tags,_markerInfo.title];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:attrStr];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"893e20"] range:NSMakeRange(0,_markerInfo.tags.length +2)];
    
    [_showImg sd_setImageWithURL:[NSURL URLWithString:_newsInfo.thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
    NSDictionary *source = _newsInfo.source;
    NSString * commendType = @"";
    if(_newsInfo.commend == 1)
    {
        commendType = @"         ";
    }
    else if (_newsInfo.commend == 2)
    {
        commendType = @"最新";
    }
    else if (_newsInfo.commend == 3)
    {
        commendType = @"最热";
    }
    
    _toutiaoIcon.hidden = YES;
    
    if(commendType.length)
    {
        if(_newsInfo.commend == 1)
        {
            _toutiaoIcon.hidden = NO;
            _contentLbl.text = [NSString stringWithFormat:@"%@%@", commendType, _newsInfo.title];
        }
        else
        {
            _contentLbl.text = [NSString stringWithFormat:@"%@ | %@", commendType, _newsInfo.title];
            
            [_contentLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(0, 5)];
        }

    }
    else
    {
        _contentLbl.text = _newsInfo.title;
    }
    
    _zanLbl.text = [source objectForJSONKey:@"suports"];
    _liulanLbl.text =  [source objectForJSONKey:@"clicks"];
}

@end
