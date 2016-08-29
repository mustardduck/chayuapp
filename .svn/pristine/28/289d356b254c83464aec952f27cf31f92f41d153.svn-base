//
//  CYAddressManagementCell.m
//  TeaMall
//
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYAddressManagementCell.h"

@interface CYAddressManagementCell ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

- (IBAction)setAsDefault_click:(id)sender;
- (IBAction)editor_click:(id)sender;

- (IBAction)delete_click:(id)sender;


@end

@implementation CYAddressManagementCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView
{
    static NSString *addressManagementidentify = @"CYShippingAddressCell";
    CYAddressManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:addressManagementidentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYAddressManagementCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)setModel:(CYShippingAddressModel *)model
{
    _model = model;
    _userNameLbl.text = _model.name;
    _phoneNumLbl.text = _model.mobile;
    _addressLbl.text = _model.areaAddress;
    if (_model.isDefault) {
        _defaultBtn.selected = YES;
    }else{
        _defaultBtn.selected = NO;
    }
}

- (IBAction)setAsDefault_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(setAsDefaultCell:andModel:)]) {
        [self.delegate setAsDefaultCell:self andModel:_model];
    }
}

- (IBAction)editor_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editorCell:AndModel:)]) {
        [self.delegate editorCell:self AndModel:_model];
    }
}

- (IBAction)delete_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:AndModel:)]) {
        [self.delegate deleteCell:self AndModel:_model];
    }
}
@end
