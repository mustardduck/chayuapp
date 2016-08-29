//
//  CYQuanZiDetTopCell.m
//  茶语
//
//  Created by Chayu on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYQuanZiDetTopCell.h"
#import "UILabel+Utilities.h"


@interface CYQuanZiDetTopCell ()
{
    UIButton *selectBUtton;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line_x;

@property (weak, nonatomic) IBOutlet UIImageView *showimg;


@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *guanzhuLbl;

@property (weak, nonatomic) IBOutlet UILabel *quanzhuLbl;

@property (weak, nonatomic) IBOutlet UIView *menuBg;

@property (weak, nonatomic) IBOutlet UIImageView *guanfangIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLblWidth;

@end


@implementation CYQuanZiDetTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    selectBUtton = [_menuBg viewWithTag:600];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)menu_click:(UIButton *)sender {
    
    if (sender.tag == selectBUtton.tag) {
        return;
    }
    
    sender.selected = YES;
    selectBUtton.selected = NO;
    
    
    if (self.menuBlock) {
        self.menuBlock(sender.tag - 600);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _line_x.constant = sender.x;
        [_menuBg layoutIfNeeded];
    }];
    selectBUtton = sender;
}

- (IBAction)fatie_click:(id)sender {
    if (self.fatieBlock) {
        self.fatieBlock();
    }
}

- (IBAction)shenqingquanzhu_click:(id)sender {
}

- (void)setInfo:(NSDictionary *)info{
    _info = info;
    NSString *logo = [info objectForKey:@"logo"];
    if (logo.length) {
        [_showimg sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:SQUARE];
    }
    _titleLbl.text =[info objectForKey:@"name"];
    NSString *guanzhiStr = [NSString stringWithFormat:@"关注：%@",[_info objectForKey:@"attentionnum"]];
    NSString *tieziStr = [NSString stringWithFormat:@"帖子：%@",[_info objectForKey:@"topics"]];
    _guanzhuLbl.text = [NSString stringWithFormat:@"%@         %@",guanzhiStr,tieziStr];
    _quanzhuLbl.text = [NSString stringWithFormat:@"圈主：%@",[_info objectForKey:@"manager"]];
    
    BOOL isGuanFang = [[info objectForJSONKey:@"created_source"] boolValue];//0是官方 1是会员
    _guanfangIcon.hidden = isGuanFang;

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_titleLbl.boundingRectWithWidth > SCREEN_WIDTH - 110 - 56 )
        {
            _titleLblWidth.constant = SCREEN_WIDTH - 110 - 56;
        }
        else
        {
            _titleLblWidth.constant = _titleLbl.boundingRectWithWidth;
        }
    });


    
    
}

@end
