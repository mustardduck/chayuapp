//
//  util_functions.h
//  Framework
//
//  Created by taotao on 15/8/18.
//  Copyright (c) 2015年 taotao. All rights reserved.
//


#import <Foundation/Foundation.h>
#include <stdio.h>
/*!
 *@brief        获取网络地址路径
 *@function     getNetworkPath
 *@param        para        -- 写入urls.plist(root/res/urls.plist)中的参数
 *@return       (NSString)  -- 网络地址路径
 */
static NSString *getNetworkPath(NSString *shortName)
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"urls" ofType:@"plist"];
    if (!filePath) {
        NSLog(@"未找到文件路径.");
        return @"";
    }
    NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *hostName = [content objectForKey:@"host"];
    if ([shortName isEqualToString:@"host"]) {
        return hostName;
    }
    NSString *relativePath = [[content objectForKey:shortName] objectForKey:@"path"];
    NSString *path = [NSString stringWithFormat:@"%@%@", hostName, relativePath];
    return path;
}

