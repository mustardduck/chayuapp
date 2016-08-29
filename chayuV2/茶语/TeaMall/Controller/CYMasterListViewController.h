//
//  CYMasterListViewController.h
//  TeaMall
//
//  Created by Chayu on 15/10/22.
//  Copyright © 2015年 Chayu. All rights reserved.
//
 
#import "CYBaseViewController.h"
typedef NS_ENUM(NSInteger,CYSellerType){
    CYSellerTypeMaster = 0,
    CYSellerTypeHandmade, //名家
};
@interface CYMasterListViewController : CYBaseViewController

@property(nonatomic,assign)CYSellerType type;

@end
