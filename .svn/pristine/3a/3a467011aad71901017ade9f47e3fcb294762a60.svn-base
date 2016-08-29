//
//  CYBuyerShipAreaSubCell.h
//  茶语
//
//  Created by Leen on 16/7/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerShipAreaSubCellDelegate;


@interface CYBuyerShipAreaSubCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (nonatomic, strong) id<CYBuyerShipAreaSubCellDelegate> delegate;

+ (instancetype)cellWidthTableView:(UITableView *)tableView;

@end


@protocol CYBuyerShipAreaSubCellDelegate <NSObject>

- (void)selectShipAreaSubCell:(CYBuyerShipAreaSubCell *)cell;

@end