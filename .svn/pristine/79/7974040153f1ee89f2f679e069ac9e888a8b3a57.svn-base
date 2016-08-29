//
//  CYShippingAddressCell.m
//  TeaMall
//
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYShippingAddressCell.h"

@interface CYShippingAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *defaultLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectImg_width_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultview_width_cons;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

- (IBAction)editor_click:(id)sender;

@end

@implementation CYShippingAddressCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(instancetype)cellWidthTableView:(UITableView*)tableView
{
     static NSString *shippingidentify = @"CYShippingAddressCell";
    CYShippingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:shippingidentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYShippingAddressCell" owner:nil options:nil] firstObject];
        cell.defaultLbl.layer.cornerRadius = 2.0f;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)setModel:(CYShippingAddressModel *)model
{
    _model = model;
    if (_model.isDefault) {
        _userNameLbl.text = _model.name;
        _defaultview_width_cons.constant = 60.0f;
    }else{
        _phoneNumLbl.text = [NSString stringWithFormat:@"%@    %@",model.name,model.mobile];
        _defaultview_width_cons.constant = 0.0f;
    }
    
    if (_model.isSelect) {
        _selectImg_width_cons.constant = 17.0f;
    }else{
        _selectImg_width_cons.constant = 0.0f;
    }
    
    _addressLbl.text = _model.areaAddress;
    
    
}

- (IBAction)editor_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shipeditorCell:AndModel:)]) {
        [self.delegate shipeditorCell:self AndModel:_model];
    }
}
@end
