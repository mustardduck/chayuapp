//
//  CYCollectListController.h
//  茶语
//
//  Created by Leen on 16/5/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseListViewController.h"


@interface CYCollectListController : CYBaseViewController

@property (nonatomic,assign)CYMyCollectType collectType;

@property (nonatomic, assign) NSString *sid;
@property (nonatomic, assign) NSString *bid;
//茶评相关参数
@property (nonatomic,strong)NSString *order_created;;
@property (nonatomic,strong)NSString *order_score;
@property (nonatomic,strong)NSString *order_price;

@end
