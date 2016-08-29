//
//  CYXuanZeDiQuController.h
//  茶语
//
//  Created by Chayu on 16/7/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef NS_ENUM(NSInteger,CYQuYuType){
    CYQuYuTypeSheng = 0,
    CYQuYuTypeShi,
    CYQuYuTypeQu
};

@interface CYXuanZeDiQuController : CYBaseViewController

@property (nonatomic,assign)CYQuYuType quyutype;

@property (nonatomic,strong)NSString *quyuId;

@property (nonatomic,strong)NSDictionary *quyuInfo;

@end
