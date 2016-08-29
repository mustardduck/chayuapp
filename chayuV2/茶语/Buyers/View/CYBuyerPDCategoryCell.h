//
//  CYBuyerPDCategoryCell.h
//  茶语
//
//  Created by Leen on 16/8/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYBuyerPDCategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (nonatomic, copy) void(^selectBtnBlock)();

+ (instancetype)cellWidthTableView:(UITableView *)tableView;

@end
