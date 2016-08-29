//
//  CYBuyerMainCell.h
//  茶语
//
//  Created by Leen on 16/5/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBuyerMainCellModel.h"
#import "CYBuyerPDCellModel.h"

//#define CellH (254/(375/SCREEN_WIDTH))

@protocol CYBuyerMainCellDelegate;

@interface CYBuyerMainCell : UITableViewCell

@property (nonatomic, strong) CYBuyerMainCellModel * model;
//@property (nonatomic,strong)CYBuyerPDCellModel *PDmodel;

@property (nonatomic, assign) id<CYBuyerMainCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *buyerBtn;

+ (instancetype) cellForTableView:(UITableView *)tableView;

@end

@protocol CYBuyerMainCellDelegate <NSObject>

@optional
//买手介绍详情
- (void)cell:(CYBuyerMainCell *)cell buyerModel:(CYBuyerMainCellModel *)model;

//商品详情
- (void)selectGoods:(NSString *)goodsId;

@end