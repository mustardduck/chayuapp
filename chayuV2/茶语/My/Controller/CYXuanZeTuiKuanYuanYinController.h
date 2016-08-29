//
//  CYXuanZeTuiKuanYuanYinController.h
//  茶语
//
//  Created by Chayu on 16/8/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

@interface CYXuanZeTuiKuanYuanYinController : CYBaseViewController

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,copy)void (^tuikuanyuanyinBlock)(NSString *,NSInteger);

@end
