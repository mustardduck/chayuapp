//
//  CYQuanZiListCell.m
//  茶语
//
//  Created by Chayu on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYQuanZiListCell.h"
#import "UILabel+Utilities.h"

@interface CYQuanZiListCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLblWidthCons;

@property (weak, nonatomic) IBOutlet UIImageView *guanfangIcon;


@end

@implementation CYQuanZiListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setInfo:(NSDictionary *)info
{
    _info = info;
    NSString *imgurl = [_info objectForKey:@"logo"];
    [_showimg sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:SQUARE];
    _titleLbl.text = [_info objectForKey:@"name"];
    _guanzhuLbl.text = [NSString stringWithFormat:@"关注：%@",[_info objectForJSONKey:@"attentionnum"]];
    _tieziLbl.text = [NSString stringWithFormat:@"帖子：%@",[_info objectForJSONKey:@"topics"]];
    BOOL isattention = [[_info objectForJSONKey:@"isattention"] boolValue];
    if (isattention) {
        _guanzhuBtn.selected = YES;
    }
    
    BOOL isGuanFang = [[info objectForJSONKey:@"created_source"] boolValue];//0是官方 1是会员
    
    _guanfangIcon.hidden = isGuanFang;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_titleLbl.boundingRectWithWidth > SCREEN_WIDTH - 110 - 56 )
        {
            _titleLblWidthCons.constant = SCREEN_WIDTH - 110 - 56;
        }
        else
        {
            _titleLblWidthCons.constant = _titleLbl.boundingRectWithWidth;
        }
    });
}

- (IBAction)attention_click:(id)sender {
    if (self.guanzhuBlock) {
        self.guanzhuBlock(_info);
    }
}
@end
