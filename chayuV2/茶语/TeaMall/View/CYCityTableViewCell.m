//
//  CYCityTableViewCell.m
//  茶语
//
//  Created by Chayu on 16/3/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCityTableViewCell.h"

@interface CYCityTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation CYCityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWidthTableView:(UITableView *)tableView
{
    static NSString *cityIdentify = @"CYCityTableViewCell";
    CYCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityIdentify];
    if (!cell) {
          cell = [[[NSBundle mainBundle] loadNibNamed:@"CYCityTableViewCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    _title.text = _titleStr;
}

-(void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    if (_isSelect) {
        _selectImg.hidden = NO;
    }else{
        _selectImg.hidden = YES;
    }
}
@end
