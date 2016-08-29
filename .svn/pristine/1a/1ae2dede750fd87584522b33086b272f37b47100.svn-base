//
//  CYTeaAddressCell.m
//  茶语
//
//  Created by Chayu on 16/3/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaAddressCell.h"

@interface CYTeaAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *addres;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *cal;

@end

@implementation CYTeaAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddressInfo:(NSDictionary *)addressInfo
{
    _addressInfo = addressInfo;
    _addres.text = [_addressInfo objectForJSONKey:@"address"];
    _name.text = [_addressInfo objectForJSONKey:@"name"];
    _cal.text = [_addressInfo objectForJSONKey:@"mobile"];
}

@end
