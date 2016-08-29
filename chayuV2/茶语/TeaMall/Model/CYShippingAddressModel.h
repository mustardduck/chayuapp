//
//  CYShippingAddressModel.h
//  TeaMall
//
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYShippingAddressModel : NSObject

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *mobile;

@property (nonatomic,strong)NSString *areaAddress;
//邮编
@property (nonatomic,strong)NSString *postcode;

/**
 *  是否默认
 */
@property (nonatomic,assign)BOOL isDefault;

@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,copy)NSString *addressId;

/**
 *  城市ID
 */
@property (nonatomic,copy)NSString *city;

/**
 *  地区Id
 */
@property (nonatomic,copy)NSString *areaid;

/**
 *  省份Id
 */
@property (nonatomic,copy)NSString *province;

/**
 *  省份
 */
@property (nonatomic,strong)NSString *provinceName;

/**
 *  城市
 */
@property (nonatomic,strong)NSString *cityName;

/**
 *  地区
 */
@property (nonatomic,strong)NSString *areaName;
@end
