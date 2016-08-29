//
//  CYOrderInfoModel.m
//  TeaMall
//
//  Created by Chayu on 15/11/6.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYOrderInfoModel.h"

@implementation CYOrderInfoModel


+(NSDictionary *)objectClassInArray
{
    return @{@"goodsList":[CYShopTrolleyModel class]};
}

@end
