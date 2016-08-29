//
//  CYAttentionTableViewCell.m
//  TeaMall
//
//  Created by Chayu on 15/11/5.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYAttentionTableViewCell.h"

@interface CYAttentionTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *showImg;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *contenLbl;
@property (weak, nonatomic) IBOutlet UILabel *attentionNumLbl;

- (IBAction)showMoreMenu_click:(id)sender;
@end

@implementation CYAttentionTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView
{
    static NSString *attentionIdentify = @"CYAttentionTableViewCell";
    CYAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:attentionIdentify];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"CYAttentionTableViewCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setAttentionModel:(CYAttentionModel *)attentionModel
{
    _attentionModel = attentionModel;
    NSString *avatar = _attentionModel.avatar;
    if (avatar) {
        NSURL *url = [NSURL URLWithString:avatar];
        [_showImg sd_setImageWithURL:url placeholderImage:nil];
    }
  
    _userNameLbl.text = _attentionModel.nickname;
    _contenLbl.text = _attentionModel.intro;
    _attentionNumLbl.text = _attentionModel.attend;
}


- (IBAction)showMoreMenu_click:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(cell:AndMode:)]) {
        [self.delegate cell:self AndMode:_attentionModel];
    }
    
}
@end
