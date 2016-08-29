//
//  CYOrderPriceCell.h
//  茶语
//
//  Created by Chayu on 16/2/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYOrderPriceCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,strong)NSDictionary *priceInfo;

@property (nonatomic,strong)NSDictionary *sellerInfo;


@property (weak, nonatomic) IBOutlet UIButton *lianxiKefuBtn;

@end
