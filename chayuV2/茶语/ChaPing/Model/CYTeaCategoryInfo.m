//
//  CYTeaCategoryInfo.m
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaCategoryInfo.h"

@implementation CYTeaChildCategoryInfo


@end

@implementation CYHotCategotyInfo


@end

@implementation CYTeaCategoryInfo

- (NSArray *)children
{
    return [CYTeaChildCategoryInfo objectArrayWithKeyValuesArray:_children];
}
- (NSArray *)child
{
    return [CYTeaChildCategoryInfo objectArrayWithKeyValuesArray:_child];
}

@end


@implementation CYPingPaiInfo

- (NSArray *)list
{
    return [CYTeaChildCategoryInfo objectArrayWithKeyValuesArray:_list];
}


@end