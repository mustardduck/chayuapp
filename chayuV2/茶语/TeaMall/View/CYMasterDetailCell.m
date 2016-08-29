//
//  CYMasterDetailCell.m
//  茶语
//
//  Created by Leen on 16/2/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYMasterDetailCell.h"

@implementation CYMasterDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goodsdetail_click:(id)sender {
    if (self.gotoGoodsDetails) {
        self.gotoGoodsDetails();
    }
}

- (IBAction)lijigoumai_click:(id)sender {
    if (self.bunowBlock) {
        self.bunowBlock();
    }
}
@end
