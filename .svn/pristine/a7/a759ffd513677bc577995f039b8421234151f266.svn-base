//
//  RPUUID.m
//  Hera
//
//  Created by iMacForiOSDev on 16/6/1.
//  Copyright © 2016年 . All rights reserved.
//

//KeychainItemWrapper下载地址：
//https://developer.apple.com/library/ios/samplecode/GenericKeychain/Introduction/Intro.html

#import "RPUUID.h"
#import "KeychainItemWrapper.h"

static NSString *__appUUID = nil;

@implementation RPUUID

+ (NSString *)UUID
{
    if (!__appUUID) {
        __appUUID = [self generateAppUUID];
    }
    
    return __appUUID;
}



/*!
 *@brief        生成设备唯一码
 *@function     generateAppUUID
 *@param        (void)
 *@return       (void)
 */
+ (NSString *)generateAppUUID
{
    NSString *identifer = [NSString stringWithFormat:@"%@UUIDKey",BUNDLE_EXECUTABLE];
    KeychainItemWrapper *UDIDWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:identifer
                                                                           accessGroup:nil];
    NSString *storedUUID = [UDIDWrapper objectForKey:(__bridge id)(kSecAttrAccount)];
    if (storedUUID && [storedUUID length] > 0) {
        return storedUUID;
    }
    
    [UDIDWrapper resetKeychainItem];
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef str = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    NSString *uuid_str = (__bridge NSString *)str;
    [UDIDWrapper setObject:uuid_str forKey:(__bridge id)(kSecAttrAccount)];
    CFRelease(str);
    CFRelease(uuid);
    return uuid_str;
}

@end
