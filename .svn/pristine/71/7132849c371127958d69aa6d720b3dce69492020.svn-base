//
//  CYTeaProcessInfo.m
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaProcessInfo.h"

@implementation CYTeaProcessInfo

- (CYTeaProcessDetailInfo *)drytea
{
    return [CYTeaProcessDetailInfo objectWithKeyValues:_drytea];
}

- (NSArray *)cook
{
    return [CYTeaProcessDetailInfo objectArrayWithKeyValuesArray:_cook];
}

- (CYTeaProcessPaoInfo *)ready_pao
{
    return [CYTeaProcessPaoInfo objectWithKeyValues:_ready_pao];
}

- (CYTeaProcessDetailInfo *)leaves
{
    return [CYTeaProcessDetailInfo objectWithKeyValues:_leaves];
}

- (NSInteger)count
{
//    return self.gancha.count + self.pao.count + self.readyPao.count + self.tangdi.count;
    return 5;
}

@end


@implementation CYTeaProcessDetailInfo

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"mDescription":@"description"};
}

@end

@implementation CYTeaProcessPaoInfo

@end