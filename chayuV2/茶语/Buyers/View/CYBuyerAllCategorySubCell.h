//
//  CYBuyerAllCategorySubCell.h
//  茶语
//
//  Created by Leen on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerAllCategorySubCellDelegate;


@interface CYBuyerAllCategorySubCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (nonatomic, assign) id<CYBuyerAllCategorySubCellDelegate> delegate;

+ (instancetype)cellWidthTableView:(UITableView *)tableView;

@end


@protocol CYBuyerAllCategorySubCellDelegate <NSObject>

- (void)selectBuyerAllCategorySubCell:(CYBuyerAllCategorySubCell *)cell;

@end