//
//  CYWengZhangTypeCell.m
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWengZhangTypeCell.h"

@interface CYWengZhangTypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg1;

@property (weak, nonatomic) IBOutlet UIImageView *showImg2;

@end

@implementation CYWengZhangTypeCell

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
    NSDictionary *left = [_info objectForKey:@"left"];
    NSDictionary *right = [_info objectForKey:@"right"];
    if (left.count) {
        NSString *thumb = [left objectForKey:@"thumb"];
        [_showImg1 sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
    }
    
    
    if (right.count) {
        NSString *thumb = [right objectForKey:@"thumb"];
        [_showImg2 sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
    }
    
}

- (IBAction)imgseleci_click:(UIButton *)sender {
    NSDictionary *left = [_info objectForKey:@"left"];
    NSDictionary *right = [_info objectForKey:@"right"];
    NSString *resource_id = nil;
    NSInteger resource_type;
    if (sender.tag == 600) {
        resource_type = [[left objectForKey:@"resource_type"] integerValue];
        resource_id = [left objectForKey:@"resource_id"];
    }else{
        resource_id = [right objectForKey:@"resource_id"];
        resource_type = [[right objectForKey:@"resource_type"] integerValue];
    }
    
    if (self.imgBlock) {
        self.imgBlock(resource_id,resource_type);
    }
}
@end
