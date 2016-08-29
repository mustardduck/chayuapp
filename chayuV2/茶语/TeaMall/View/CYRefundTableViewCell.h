//
//  CYRefundTableViewCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/6.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYRefundModel.h"

@protocol CYRefundTableViewCellDeletage;

@interface CYRefundTableViewCell : UITableViewCell

@property (nonatomic,strong)CYRefundModel *orderModel;

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,strong)id<CYRefundTableViewCellDeletage>delegate;

@end

@protocol CYRefundTableViewCellDeletage <NSObject>

-(void)selectCell:(CYRefundTableViewCell *)cell andModel:(CYRefundModel*)model;

@end