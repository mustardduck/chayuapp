//
//  CYAddressListViewController.h
//  TeaMall
//
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"
#import "CYShippingAddressModel.h"
typedef NS_ENUM(NSInteger,CYAddressType){
    CYAddressTypeManager = 0,  //收货地址管理
    CYAddressTypeChoose    //选择地址
};

typedef void(^addressBack)(CYShippingAddressModel *);

@interface CYAddressListViewController : CYBaseViewController

@property (nonatomic,assign)CYAddressType addressType;

@property (nonatomic,strong)addressBack back;

@end
