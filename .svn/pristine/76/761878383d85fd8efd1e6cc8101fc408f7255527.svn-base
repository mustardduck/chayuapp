//
//  CYBuyerCell.m
//  茶语
//
//  Created by Leen on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerCell.h"

@interface CYBuyerCell()
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end

@implementation CYBuyerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString *cellID = @"CYBuyerCell";
    
    CYBuyerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setModel:(CYBuyerMainCellModel *)model
{
    _imgView.height = 174 * (SCREEN_WIDTH / 320);
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"750×400"]];
    
    _contentLbl.text = model.content;
    
    self.height = 244 - 174 + _imgView.height;

}

@end
