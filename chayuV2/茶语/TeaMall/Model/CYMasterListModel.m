//
//  CYMasterListModel.m
//  TeaMall
//
//  Created by Chayu on 15/11/9.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMasterListModel.h"
#import "CYGoodsListModel.h"

@implementation CYMasterListModel

+(NSDictionary *)objectClassInArray
{
    return @{@"goodsList":[CYGoodsListModel class]};
}

@end
