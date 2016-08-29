//
//  CYInvoiceInfoCell.m
//  TeaMall
//  发票信息
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYInvoiceInfoCell.h"

@interface CYInvoiceInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *invTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;


@end

@implementation CYInvoiceInfoCell

- (void)awakeFromNib {
    // Initialization code
}
+(instancetype)cellWidthTableView:(UITableView*)tableView{
    static NSString *invoiceIdentify = @"CYInvoiceInfoCell";
    CYInvoiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYInvoiceInfoCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setInvoiceInfo:(NSDictionary *)invoiceInfo
{
    _invoiceInfo = invoiceInfo;
    _invTitleLbl.text = [_invoiceInfo objectForJSONKey:@"invPayee"];
    _messageLbl.text = [_invoiceInfo objectForJSONKey:@"buyersMessage"];
}

@end
