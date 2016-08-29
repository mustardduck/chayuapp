//
//  CYBuyerPDCategorySubCell.h
//  茶语
//
//  Created by Leen on 16/6/17.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerPDCategorySubCellDelegate;


@interface CYBuyerPDCategorySubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (nonatomic, strong) id<CYBuyerPDCategorySubCellDelegate> delegate;

+ (instancetype)cellWidthTableView:(UITableView *)tableView;

@end



@protocol CYBuyerPDCategorySubCellDelegate <NSObject>

- (void)selectPDCategorySubCell:(CYBuyerPDCategorySubCell *)cell;

@end