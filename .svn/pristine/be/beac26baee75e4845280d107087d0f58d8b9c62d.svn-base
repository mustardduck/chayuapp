//
//  CYEditorAddressViewController.h
//  TeaMall
//
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"
#import "CYShippingAddressModel.h"

typedef NS_ENUM(NSInteger,CYEditorAddressType){
    CYEditorAddressTypeEdit = 0,//编辑收货地址
    CYEditorAddressTypeAdd  //添加收货地址
};


typedef void (^Calback)();

@interface CYEditorAddressViewController : CYBaseViewController

@property (nonatomic,strong)NSString *addressId;

@property (nonatomic,assign)CYEditorAddressType addressType;

@property (nonatomic,strong)CYShippingAddressModel *shopModel;

@property (nonatomic,strong)Calback addessBack;

@end
