//
//  CYSearchPublicCell.m
//  茶语
//
//  Created by Chayu on 16/3/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSearchPublicCell.h"

@interface CYSearchPublicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;

@end


@implementation CYSearchPublicCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWidthTableView:(UITableView*)tableView
{
    static NSString *refundIndentify = @"CYSearchPublicCell";
    CYSearchPublicCell *cell = [tableView dequeueReusableCellWithIdentifier:refundIndentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYSearchPublicCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInfo:(NSDictionary *)info
{
    _info = info;
    NSString *str = [_info objectForKey:@"thumb"];
    if (str.length) {
        [_showImg sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:SQUARE];
    }
    _titleLbl.text = [_info objectForKey:@"name"];
    _lable1.text = [_info objectForKey:@"public1"];
    _lable2.text = [_info objectForKey:@"public2"];
    
}

@end
