//
//  CYPublicQuanZiViewController.h
//  茶语
//
//  Created by taotao on 16/8/7.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

typedef NS_ENUM(NSInteger,CYQuanZiType) {
    CYQuanZiTypeChuangJian = 0,
    CYQuanZiTypeChuangGuanLi,
    CYQuanZiTypeChuangGuanZhu
};

@interface CYPublicQuanZiViewController : CYBaseViewController


@property (nonatomic,assign)CYQuanZiType quanzitye;

@end
