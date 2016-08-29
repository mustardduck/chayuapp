//
//  BaseCell.m
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (BaseCell *)loadFromNibName:(NSString *)nibName
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return (BaseCell *)[arr objectAtIndex:0];
}

+ (CGFloat)calcCellHeight:(id)data
{
    return 44;
}

- (void)parseData:(id)data
{
    self.mClickData = data;
}

@end
