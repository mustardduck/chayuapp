//
//  CYHuaTiListCell.m
//  茶语
//
//  Created by Chayu on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHuaTiListCell.h"

@interface CYHuaTiListCell ()




@end

@implementation CYHuaTiListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setInfo:(NSDictionary *)info
{
    _info = info;
    NSString *imgStr = [_info objectForJSONKey:@"thumb"];
    if (imgStr.length>0) {
        _img_left_cons.constant = 20;
        _showimg.hidden = NO;
        [_showimg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:SQUARE];
    }else{
        _img_left_cons.constant = -80;
        _showimg.hidden = YES;
    }
    
    _titleLbl.text =[_info objectForKey:@"subject"];
    
    NSInteger digest = [[_info objectForKey:@"digest"] integerValue];
    
    
    NSInteger topped = [[_info objectForKey:@"topped"] integerValue];
    if (topped == 3 && !_isQuanZiDetails) {
        _titleLbl.text = [NSString stringWithFormat:@"         %@",[_info objectForKey:@"subject"]];
        _statusImg.hidden = NO;
        _statusImg.image = [UIImage imageNamed:@"huati_zhiding_ico"];
    }else{
        if (digest == 1) {
            _statusImg.hidden = NO;
            _titleLbl.text = [NSString stringWithFormat:@"       %@",[_info objectForKey:@"subject"]];
            _statusImg.image = [UIImage imageNamed:@"huati_jinghua_ico"];
        }else{
            _statusImg.hidden = YES;
        }
    }
    
    if (_isQuanZiDetails) {
        if (topped <=3 && topped >0) {
            _titleLbl.text = [NSString stringWithFormat:@"         %@",[_info objectForKey:@"subject"]];
            _statusImg.hidden = NO;
            _statusImg.image = [UIImage imageNamed:@"huati_zhiding_ico"];
        }else{
            if (digest == 1) {
                _statusImg.hidden = NO;
                _titleLbl.text = [NSString stringWithFormat:@"         %@",[_info objectForKey:@"subject"]];
                _statusImg.image = [UIImage imageNamed:@"huati_jinghua_ico"];
            }else{
                _statusImg.hidden = YES;
            }
        }
    }
    
    _contentLbl.text =[_info objectForKey:@"content"];
    _pinglunLbl.text = [_info objectForKey:@"replies"];
    _liulanLbl.text = [_info objectForKey:@"hits"];
}

@end
