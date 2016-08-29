//
//  CYSelectWeiQuanController.h
//  茶语
//
//  Created by Chayu on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

@interface CYSelectWeiQuanController : CYBaseViewController

@property (nonatomic,copy)void(^backInfoBlock)(NSString *);

@property (nonatomic,strong)NSString *selectOrderStr;

@end
