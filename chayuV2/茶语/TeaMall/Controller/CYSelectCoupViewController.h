//
//  CYSelectCoupViewController.h
//  茶语
//
//  Created by Chayu on 16/2/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef void(^coupbackBlock)(NSDictionary *coupInfo);

@interface CYSelectCoupViewController : CYBaseViewController

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)NSDictionary *selectDic;

@property (nonatomic,strong)coupbackBlock block;

@end
