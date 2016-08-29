//
//  CYBuyerEvaluationCell.h
//  茶语
//
//  Created by Leen on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYEvaluationModel.h"
#define EVACELL_HTIGHT 60

@interface CYBuyerEvaluationCell : UITableViewCell

@property (nonatomic,strong)CYEvaluationModel *evaModel;


+(CGFloat)tableViewCellHeight:(id)data;

@end
