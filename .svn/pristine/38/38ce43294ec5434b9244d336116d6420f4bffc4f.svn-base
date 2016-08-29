//
//  CYCollectTableViewCell.m
//  茶语
//
//  Created by Chayu on 16/5/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCollectTableViewCell.h"
#import "BaseLable.h"
@interface CYCollectTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icoimg;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet BaseLable *bragenumLbl;


@end

@implementation CYCollectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellInfo:(NSDictionary *)cellInfo
{
    _cellInfo = cellInfo;
    _icoimg.image = [UIImage imageNamed:cellInfo[@"img"]];
    _title.text = cellInfo[@"title"];
    NSInteger bragenum = [cellInfo[@"bragenum"] integerValue];
    if (bragenum>0) {
        _bragenumLbl.hidden = NO;
       _bragenumLbl.text = cellInfo[@"bragenum"];
    }
    else
    {
        _bragenumLbl.hidden = YES;
    }
    
}

@end
