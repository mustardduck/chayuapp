//
//  CYShoppingTrolleyCell.h
//  TeaMall
//
//  Created by Chayu on 15/10/28.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYShopTrolleyModel.h"

@protocol CYShoppingTrolleyCellDelegate;

@interface CYShoppingTrolleyCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLbl;
@property (nonatomic,strong)id<CYShoppingTrolleyCellDelegate>delegate;


@property (nonatomic,strong)CYShopTrolleyModel *shopTrolleyModel;
@end


@protocol CYShoppingTrolleyCellDelegate <NSObject>

-(void)changeGoodsNum:(CYShoppingTrolleyCell *)cell
                Model:(CYShopTrolleyModel *)model
                IsAdd:(BOOL)add;

- (void)selectgoods:(CYShoppingTrolleyCell *)cell andModel:(CYShopTrolleyModel *)model;

@end