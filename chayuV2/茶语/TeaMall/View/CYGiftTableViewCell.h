//
//  CYGiftTableViewCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYGiftTableViewCell : UITableViewCell
+(instancetype)cellWidthTableView:(UITableView*)tableView;

/**
 *  礼物信息
 */
@property (nonatomic,strong)NSArray *goodsordergift;

@end
