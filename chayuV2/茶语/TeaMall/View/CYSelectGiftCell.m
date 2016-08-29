//
//  CYSelectGiftCell.m
//  TeaMall
//
//  Created by Chayu on 15/11/25.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYSelectGiftCell.h"

@interface CYSelectGiftCell ()


@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;

@end

@implementation CYSelectGiftCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView
{
   static  NSString *selectgiftIdentify = @"CYSelectGiftCell";
    CYSelectGiftCell *cell =[tableView dequeueReusableCellWithIdentifier:selectgiftIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYSelectGiftCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(CYGiftModel *)model
{
    _model = model;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *imgStr = _model.thumb;
        if (imgStr.length) {
            NSURL *url = [NSURL URLWithString:imgStr];
            [_showImg sd_setImageWithURL:url placeholderImage:nil];
        }
        _titleLbl.text = _model.title;
        _numLbl.text = [NSString stringWithFormat:@"x%@",_model.giftNum];
    });
 
}


@end
