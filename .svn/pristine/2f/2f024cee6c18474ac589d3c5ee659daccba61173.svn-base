//
//  CYAttentionTableViewCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/5.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYAttentionModel.h"


@protocol CYAttentionTableViewCellDeletage;
@interface CYAttentionTableViewCell : UITableViewCell
@property (nonatomic,strong)CYAttentionModel *attentionModel;
@property (nonatomic,assign)id<CYAttentionTableViewCellDeletage>delegate;

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@end

@protocol CYAttentionTableViewCellDeletage <NSObject>

-(void)cell:(CYAttentionTableViewCell *)cell AndMode:(CYAttentionModel *)model;

@end