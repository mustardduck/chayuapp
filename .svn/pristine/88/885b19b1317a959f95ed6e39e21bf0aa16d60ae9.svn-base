//
//  CYWenZhangDefCell.m
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWenZhangDefCell.h"

@interface CYWenZhangDefCell ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;


@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UILabel *zanLbl;

@property (weak, nonatomic) IBOutlet UILabel *liulanLbl;
@property (weak, nonatomic) IBOutlet UIImageView *toutiaoImg;


@end

@implementation CYWenZhangDefCell

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
    NSString *thumb = [_info objectForKey:@"thumb"];
    
    if (thumb.length == 0) {
        _img_Left_cons.constant = -70;
        _showImg.hidden = YES;
    }else{
        _img_Left_cons.constant = 20;
        _showImg.hidden = NO;
        [_showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
    }
    
    NSInteger is_toutiao =[[_info objectForKey:@"is_toutiao"] integerValue];
    if (is_toutiao) {
        _toutiaoImg.hidden = NO;
        _contentLbl.text = [NSString stringWithFormat:@"         %@",[_info objectForKey:@"title"]];
    }else{
        _toutiaoImg.hidden = YES;
        _contentLbl.text = [_info objectForKey:@"title"];
    }
    
    NSDictionary *source = [_info objectForKey:@"source"];
    if (source&&source.count) {
        _zanLbl.text = [source objectForKey:@"suports"];
        _liulanLbl.text = [source objectForKey:@"clicks"];
    }else{
        NSString *suports =[_info objectForKey:@"suports"];
        NSString *clicks = [_info objectForKey:@"clicks"];
        if (suports.length) {
            _zanLbl.text = [_info objectForKey:@"suports"];
        }
        if (clicks.length) {
            _liulanLbl.text = [_info objectForKey:@"clicks"];   
        }
    }
    
    
    
}

@end
