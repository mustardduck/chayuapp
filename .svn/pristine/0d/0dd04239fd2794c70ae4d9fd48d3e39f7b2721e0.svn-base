//
//  CYWenZhangImgCell.m
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWenZhangImgCell.h"

@interface CYWenZhangImgCell ()


@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UIImageView *showimg1;
@property (weak, nonatomic) IBOutlet UIImageView *showimg2;
@property (weak, nonatomic) IBOutlet UIImageView *showimg3;

@property (weak, nonatomic) IBOutlet UILabel *liulanLbl;
@property (weak, nonatomic) IBOutlet UILabel *zanLbl;

@end
@implementation CYWenZhangImgCell

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
    NSArray *thumbs =[_info objectForKey:@"thumbs"];
    if (thumbs.count>0) {
        for (int i=0; i<thumbs.count; i++) {
            NSDictionary *imgInfo = thumbs[i];
            NSString *thumb = [imgInfo objectForKey:@"thumb"];
            if (i == 0) {
                [_showimg1 sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
            }else if (i == 1){
                [_showimg2 sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
            }else{
                [_showimg3 sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
            }
        }
    }
    NSDictionary *source = [_info objectForKey:@"source"];
    if (source.count) {
        NSString * clicks = (NSString *)[source objectForJSONKey:@"clicks"];
        if(clicks.length)
        {
            _liulanLbl.text = [source objectForKey:@"clicks"];
        }
        
        if([[source objectForKey:@"suports"] integerValue])
        {
            _zanLbl.text = [source objectForKey:@"suports"];
        }
    }
    _contentLbl.text = [_info objectForKey:@"title"];
    
}


@end
