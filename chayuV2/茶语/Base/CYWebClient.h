//
//  CYWebClient.h
//  TeaMall
//
//  Created by Leen on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface CYWebClient : NSObject

+(NSString*)urlWithName:(NSString*)urlName;

+ (void)Post:(NSString*)apiName parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id error))failure;
+ (void)Get:(NSString*)apiName parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id error))failure;

+ (void)basePost:(NSString*)apiName parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id error))failure;

/* post上传文件 */
+ (void)Post:(NSString*)apiName parametes:(id)parameters files:(id)files success:(void (^)(id responObject))success failure:(void (^)(id error))failure;


//后台悄悄请求无提示
+ (void)backgroundPost:(NSString*)apiName parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id error))failure;


+ (void)just4Test;
@end
