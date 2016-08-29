//
//  CYLogisticsModel.h
//  TeaMall
//
//  Created by Chayu on 16/1/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYShopTrolleyModel.h"
@interface CYLogisticsModel : NSObject


/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSArray *goodsList;
/**
 *  快递logo
 */
@property (nonatomic,copy)NSString *logisticsLogo;

/**
 *  快递Id
 */
@property (nonatomic,strong)NSString *logisticsId;

/**
 *  快递名称
 */
@property (nonatomic,strong)NSString *logisticsName;

/**
 *  快递单号
 */
@property (nonatomic,strong)NSString *logisticsNu;

/**
 *  快递状态
 */
@property (nonatomic,strong)NSString *logisticsStatus;

/**
 *  物流信息
 */
@property (nonatomic,strong)NSArray *logisticsList;


//茶样信息
/**
 *  物流公司名称
 */
@property (nonatomic,strong)NSString *company_name;

/**
 * 物流单号
 */
@property (nonatomic,strong)NSString *waybill;

/**
 * 物流状态
 */
@property (nonatomic,strong)NSString  *status_description;

/**
 *  快递图标
 */
@property (nonatomic,strong)NSString *logo;


@property (nonatomic,strong)NSArray *log;

@end
