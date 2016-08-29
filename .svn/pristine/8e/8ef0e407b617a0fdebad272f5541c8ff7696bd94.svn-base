//
//  BlueBoxer.m
//  JiangbeiEPA
//
//  Created by iXcoder on 13-9-6.
//  Copyright (c) 2013年 bulebox. All rights reserved.
//

#import "ChaYuManager.h"
#import <objc/runtime.h>
#ifndef SYS_USER
#define SYS_USER            @"CurrentSystemUser"
#endif
static ChaYuer *sysUser = nil;

@implementation ChaYuer

- (void)dealloc
{
//    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    Class cls = [self class];
    uint count = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        const char *key = property_getName(properties[i]);
        NSString *keyName = [NSString stringWithUTF8String:key];
        NSString *value = [self valueForKeyPath:keyName];
        [aCoder encodeObject:value forKey:keyName];
        keyName = nil;
        value = nil;
    }
    free(properties);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        Class cls = [self class];
        uint proCount = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &proCount);
        for (int i = 0; i < proCount; i++) {
            const char *key = property_getName(properties[i]);
            NSString *keyName = [NSString stringWithUTF8String:key];
            if ([aDecoder containsValueForKey:keyName]) {
                id value = [aDecoder decodeObjectForKey:keyName];
                [self setValue:value forKeyPath:keyName];
            }
        }
        free(properties);
    }
    return self;
}


- (void)updateUserInfo:(NSDictionary *)infoDic
{
    ChaYuer *user = [ChaYuManager getCurrentUser];
    user.nickname = [infoDic objectForJSONKey:@"nickname"];
    user.avatar = [infoDic objectForJSONKey:@"avatar"];
    user.email = [infoDic objectForJSONKey:@"email"];
    user.sex = [infoDic objectForJSONKey:@"sex"];
    user.intro = [infoDic objectForJSONKey:@"intro"];
    user.mobile = [infoDic objectForJSONKey:@"mobile"];
    user.loged = YES;
    user.uid = [infoDic objectForJSONKey:@"uid"];
    user.score = [infoDic objectForJSONKey:@"score"];
    user.experience = [infoDic objectForJSONKey:@"experience"];
    user.regtime = [self dataWithSince:[[infoDic objectForJSONKey:@"regtime"] doubleValue]];
    [ChaYuManager archiveCurrentUser:user];
}

- (NSString *)dataWithSince:(NSTimeInterval )dataString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        ];
    //    });
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataString];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}




@end


@implementation ChaYuManager

/*!
 *@brief        储存当前用户信息
 *@function     archiveCurrentUser:
 *@param        currentUser
 *@return       (void)
 */
+ (void)archiveCurrentUser:(ChaYuer *)currentUser
{
    sysUser = currentUser;
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:sysUser];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:SYS_USER];
    [[NSUserDefaults standardUserDefaults]synchronize];
    return;
}

/*!
 *@brief        获取当前用户信息
 *@function     getCurrentUser
 *@param        (void)
 *@return       (void)
 */
+ (ChaYuer *)getCurrentUser
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SYS_USER];
    if (data != nil) {
        sysUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else {
        sysUser = [[ChaYuer alloc] init];
    }
    return sysUser;
}

@end