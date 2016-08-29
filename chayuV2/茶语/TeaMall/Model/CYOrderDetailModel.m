//
//  CYOrderDetailModel.m
//  TeaMall
//
//  Created by Chayu on 15/11/23.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYOrderDetailModel.h"

@implementation CYOrderDetailModel

+(NSDictionary *)objectClassInArray
{
    return @{@"goodsList":[CYShopTrolleyModel class]};
}


@end
