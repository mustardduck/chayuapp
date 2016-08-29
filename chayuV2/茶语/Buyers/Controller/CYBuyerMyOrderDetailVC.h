//
//  CYBuyerMyOrderDetailVC.h
//  茶语
//
//  Created by Leen on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"
#import "CYBuyerOrderInfoModel.h"

@interface CYBuyerMyOrderDetailVC : CYBaseViewController


@property (nonatomic,strong)CYBuyerOrderInfoModel *model;

@property (nonatomic,strong)void(^changeOrderBlock)();

@end
