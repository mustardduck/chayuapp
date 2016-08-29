//
//  CYWebClient.m
//  TeaMall
//
//  Created by Leen on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYWebClient.h"
#import <JSONKit-NoWarning/JSONKit.h>
#import "AppDelegate.h"

//#define BASEURL @"http://192.168.52.20/shiji"
//#define BASEURL2 @"http://192.168.52.29/user"
@implementation CYWebClient

+(NSString*)urlWithName:(NSString*)urlName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Url" ofType:@"plist"];
    NSDictionary *dicUrl = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:urlName];
    NSString *key = [NSString stringWithFormat:@"%@",dicUrl[@"baseUrl"]];
    NSString *baseUrl = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:key];
    NSString *api = [NSString stringWithFormat:@"%@/%@/%@",baseUrl,dicUrl[@"version"],dicUrl[@"api"]];
    if ([key isEqualToString:@"Shiji"]) {
        api = [NSString stringWithFormat:@"%@/%@/shiji/%@",baseUrl,dicUrl[@"version"],dicUrl[@"api"]];
    }
    
    return api;
}

+ (void)Post:(NSString*)apiName parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id error))failure
{
    //    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    //    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    //    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSString *url = [CYWebClient urlWithName:apiName];
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *sessionid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
    if (sessionid.length) {
        [parms setObject:sessionid forKey:@"sessionid"];
    }
    //    WINDOW.userInteractionEnabled = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    [manager POST:url parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WINDOW.userInteractionEnabled = YES;
        NSLog(@"请求链接：%@",task.originalRequest.URL);;
        NSLog(@"返回结果：%@",responseObject);
        NSString *msg = [responseObject objectForKey:@"msg"];
        NSError *error = [CYWebClient stateCode:[responseObject objectForKey:@"state"]];
        if (!error) {
            if (![[responseObject objectForKey:@"msg"] isEqualToString:@"数据获取成功"]) {
                if ([CYWebClient isShowMsg:apiName]) {
                    
                    if(![msg isEqualToString:@"成功"])
                    {
                        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
                        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                        [SVProgressHUD showInfoWithStatus:msg];
                    }
                    
                    
                }
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            success([responseObject objectForKey:@"data"]);
            if ([CYWebClient isSaveToken:apiName]) {
                id data = [responseObject objectForKey:@"data"];
                if (data) {
                    NSString *token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
                    ChaYuer *user = [ChaYuManager getCurrentUser];
                    if (token) {
                        user.loginToken = token;
                        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                    }
                    NSString *sessionid = [[responseObject objectForKey:@"data"] objectForKey:@"sessionid"];
                    if (sessionid) {
                        user.loginssectionid = sessionid;
                        [[NSUserDefaults standardUserDefaults] setObject:sessionid forKey:@"sessionid"];
                    }
                    [ChaYuManager archiveCurrentUser:user];
                }
            }
        }
        else
        {
            //                   [SVProgressHUD dismiss];
            if (error.code == 301) {
                NSString *token =[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                ChaYuer *user  = [ChaYuManager getCurrentUser];
                if (!token.length) {
                    token = user.loginToken;
                }
                
                if (!token.length) {
                    token = @"";
                }
                [CYWebClient Post:@"Reload" parametes:@{@"token":token} success:^(id responObject) {
                    NSLog(@"Reload");
                    if ([CYWebClient isSaveToken:@"Reload"]) {
                        NSString *token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
                        if (token) {
                            user.loginToken = token;
                            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                        }
                        NSString *sessionid = [[responseObject objectForKey:@"data"] objectForKey:@"sessionid"];
                        if (sessionid) {
                            user.loginssectionid = sessionid;
                            [[NSUserDefaults standardUserDefaults] setObject:sessionid forKey:@"sessionid"];
                        }
                        [ChaYuManager archiveCurrentUser:user];
                        
                    }
                    //#warning uncheck
                    [manager POST:url parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSError *error = [CYWebClient stateCode:[responseObject objectForKey:@"state"]];
                        if (!error) {
                            success([responseObject objectForKey:@"data"]);
                        }
                        else
                        {
                            failure(error);
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
                        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                        [SVProgressHUD showErrorWithStatus:msg];
                        failure(error);
                    }];
                    
                    
                } failure:^(id error) {
                    NSLog(@"Reload failed");
                    failure(error);
                }];
            }
            else
            {
                WINDOW.userInteractionEnabled = YES;
                [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showErrorWithStatus:msg];
                failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
        //        UtilAlert(@"error.domain",error.domain);
        WINDOW.userInteractionEnabled = YES;
        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD showErrorWithStatus:@"请求失败..."];
        failure(error);
    }];
    
}

+ (void)basePost:(NSString*)apiName parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id error))failure
{
    
    //    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    //     [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    //    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSString *url = [CYWebClient urlWithName:apiName];
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *sessionid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
    if (sessionid.length) {
        [parms setObject:sessionid forKey:@"sessionid"];
    }
    
    //    WINDOW.userInteractionEnabled = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    [manager POST:url parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WINDOW.userInteractionEnabled = YES;
        NSLog(@"请求链接：%@",task.originalRequest.URL);;
        NSLog(@"返回结果：%@",responseObject);
        NSString *msg = [responseObject objectForJSONKey:@"msg"];
        NSError *error = [CYWebClient stateCode:[responseObject objectForKey:@"state"]];
        success(responseObject);
        if (!error) {
            if (![[responseObject objectForKey:@"msg"] isEqualToString:@"数据获取成功"]) {
                if ([CYWebClient isShowMsg:apiName]) {
                    
                    if(![msg isEqualToString:@"成功"])
                    {
                        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
                        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                        [SVProgressHUD showInfoWithStatus:msg];
                    }
                    
                    
                }
            }
            if ([CYWebClient isSaveToken:apiName]) {
                id data = [responseObject objectForKey:@"data"];
                if (data) {
                    NSString *token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
                    ChaYuer *user = [ChaYuManager getCurrentUser];
                    if (token) {
                        user.loginToken = token;
                        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                    }
                    NSString *sessionid = [[responseObject objectForKey:@"data"] objectForKey:@"sessionid"];
                    if (sessionid) {
                        user.loginssectionid = sessionid;
                        [[NSUserDefaults standardUserDefaults] setObject:sessionid forKey:@"sessionid"];
                    }
                    [ChaYuManager archiveCurrentUser:user];
                }
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }else
        {
            if (error.code == 301) {
                NSString *token =[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
                ChaYuer *user  = [ChaYuManager getCurrentUser];
                if (!token.length) {
                    token = user.loginToken;
                }
                
                if (!token.length) {
                    token = @"";
                }
                
                [CYWebClient Post:@"Reload" parametes:@{@"token":token} success:^(id responObject) {
                    if ([CYWebClient isSaveToken:@"Reload"]) {
                        NSString *token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
                        if (token) {
                            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                        }
                        NSString *sessionid = [[responseObject objectForKey:@"data"] objectForKey:@"sessionid"];
                        if (sessionid) {
                            [[NSUserDefaults standardUserDefaults] setObject:sessionid forKey:@"sessionid"];
                        }
                    }
                    //#warning uncheck
                    //重连
                    [manager POST:url parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSError *error = [CYWebClient stateCode:[responseObject objectForKey:@"state"]];
                        if (!error) {
                            success([responseObject objectForKey:@"data"]);
                        }
                        else
                        {
                            failure(error);
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
                        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                        [SVProgressHUD showErrorWithStatus:msg];
                        failure(error);
                    }];
                    
                } failure:^(id error) {
                    NSLog(@"Reload failed");
                    failure(error);
                }];
            }
            else
            {
                [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showErrorWithStatus:msg];
                //                failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        WINDOW.userInteractionEnabled = YES;
        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD showErrorWithStatus:@"请求失败..."];
        failure(error);
    }];
}



+ (void)Post:(NSString*)apiName parametes:(id)parameters files:(id)files success:(void (^)(id responObject))success failure:(void (^)(id error))failure
{
    
    NSString *url = [CYWebClient urlWithName:apiName];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *sessionid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
    if (sessionid) {
        [parms setObject:sessionid forKey:@"sessionid"];
    }
    [manager POST:url parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (files!=nil) {
            NSArray *keys = [files allKeys];
            for (NSString *key in keys) {
                NSArray *fileData = [files objectForKey:key];
                int i =0;
                for (UIImage *img in fileData) {
                    i++;
                    NSData *data = UIImageJPEGRepresentation(img, 1);
                    while (data.length/1000.>500.) {
                        data = UIImageJPEGRepresentation(img,0.5);
                    }
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                    NSString *keyStr = [NSString stringWithFormat:@"%@%d",key,(int)i];
                    if ([fileData count]==1) {
                        keyStr = key;
                    }
                    [formData appendPartWithFileData:data name:keyStr fileName:fileName mimeType:@"image/png"];
                }
                
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WINDOW.userInteractionEnabled = YES;
        NSLog(@"请求链接：%@",task.originalRequest.URL);
        NSLog(@"返回结果：%@",responseObject);
        NSString *msg = [responseObject objectForJSONKey:@"msg"];
        if ([CYWebClient isShowMsg:apiName]) {
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:msg];
        }
        success(responseObject);
        NSError *error = [CYWebClient stateCode:[responseObject objectForKey:@"state"]];
        if (!error) {
            //            success([responseObject objectForKey:@"data"]);
            if ([CYWebClient isSaveToken:apiName]) {
                id data = [responseObject objectForKey:@"data"];
                if (data) {
                    NSString *token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
                    ChaYuer *user = [ChaYuManager getCurrentUser];
                    if (token) {
                        user.loginToken = token;
                        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                    }
                    NSString *sessionid = [[responseObject objectForKey:@"data"] objectForKey:@"sessionid"];
                    if (sessionid) {
                        user.loginssectionid = sessionid;
                        [[NSUserDefaults standardUserDefaults] setObject:sessionid forKey:@"sessionid"];
                    }
                    [ChaYuManager archiveCurrentUser:user];
                }
            }
        }
        else
        {
            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showErrorWithStatus:msg];
            if (error.code == 301) {
                [SVProgressHUD  showSuccessWithStatus:@"已重新连接"];
                [CYWebClient Post:@"Reload" parametes:@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]} success:^(id responObject) {
                    NSLog(@"Reload");
                    if ([CYWebClient isSaveToken:@"Reload"]) {
                        NSString *token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
                        if (token) {
                            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                        }
                        NSString *sessionid = [[responseObject objectForKey:@"data"] objectForKey:@"sessionid"];
                        if (sessionid) {
                            [[NSUserDefaults standardUserDefaults] setObject:sessionid forKey:@"sessionid"];
                        }
                    }
                    
                    
                } failure:^(id error) {
                    NSLog(@"Reload failed");
                    failure(error);
                }];
            }
            else
            {
                failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        WINDOW.userInteractionEnabled = YES;
        [SVProgressHUD showErrorWithStatus:@"请求失败..."];
        failure(error);
    }];
}

+ (void)Get:(NSString*)apiName parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id error))failure{
    
    NSString *url = [CYWebClient urlWithName:apiName];
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *sessionid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];
    if (sessionid.length) {
        [parms setObject:sessionid forKey:@"sessionid"];
    }
    
    //    WINDOW.userInteractionEnabled = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WINDOW.userInteractionEnabled = YES;
        NSLog(@"请求链接：%@",task.originalRequest.URL);;
        NSLog(@"返回结果：%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        WINDOW.userInteractionEnabled = YES;
        failure(error);
    }];
}



+ (void)backgroundPost:(NSString*)apiName parametes:(id)parameters success:(void (^)(id responObject))success failure:(void (^)(id error))failure
{
    
    NSString *url = [CYWebClient urlWithName:apiName];
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:parameters];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    manager.securityPolicy.validatesDomainName = NO;//是否验证域名
    [manager POST:url parameters:parms progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        WINDOW.userInteractionEnabled = YES;
        NSLog(@"请求链接：%@",task.originalRequest.URL);;
        NSLog(@"返回结果：%@",responseObject);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
        WINDOW.userInteractionEnabled = YES;
        
    }];
}




+ (NSError*)stateCode:(id)code
{
    NSInteger stateCode = [code integerValue];
    NSError* error = nil;
    switch (stateCode) {
        case 400:
            //正确访问
            break;
        case 800:
            //服务器异常
            error = [NSError errorWithDomain:@"" code:stateCode userInfo:nil];
            break;
        case 600:
            //服务器无法访问
            error = [NSError errorWithDomain:@"" code:stateCode userInfo:nil];
            break;
        case 601:
            //服务器访问受限
            error = [NSError errorWithDomain:@"" code:stateCode userInfo:nil];
            break;
        case 500:
            //访问错误
            error = [NSError errorWithDomain:@"" code:stateCode userInfo:nil];
            break;
        case 501:
            //参数错误
            error = [NSError errorWithDomain:@"" code:stateCode userInfo:nil];
            break;
        case 502:
            //访问过期
        {
            error = [NSError errorWithDomain:@"账号未登录" code:stateCode userInfo:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                AppDelegate *appdel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdel showLogView];
            });
        }
            break;
        case 300:
            //账号未登录
        {
            error = [NSError errorWithDomain:@"账号未登录" code:stateCode userInfo:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                AppDelegate *appdel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdel showLogView];
            });
        }
            break;
            break;
        case 301:
            //Session过期
            error = [NSError errorWithDomain:@"" code:stateCode userInfo:nil];
            break;
        case 302:
            //账号访问受限
            error = [NSError errorWithDomain:@"" code:stateCode userInfo:nil];
            break;
        case 303:
            //账号被冻结
            error = [NSError errorWithDomain:@"" code:stateCode userInfo:nil];
            break;
            
            
        default:
            break;
    }
    
    return error;
}

+ (BOOL)isShowMsg:(NSString*)apiName
{
    
    if ([apiName isEqualToString:@"Reload"]) {
        return NO;
    }
    return YES;
}

+ (BOOL)isSaveToken:(NSString*)apiName
{
    if ([apiName isEqualToString:@"Login"] || [apiName isEqualToString:@"Reload"] || [apiName isEqualToString:@"Register"] || [apiName isEqualToString:@"Modify"] || [apiName isEqualToString:@"Reset_pwd"] || [apiName isEqualToString:@"Thirdlogin"] || [apiName isEqualToString:@"Oauth_bind"] || [apiName isEqualToString:@"Oauth_register"]||[apiName isEqualToString:@"Send_verify_code"]) {
        return YES;
    }
    return NO;
}
+ (void)just4Test
{
    //首页
    //    [CYWebClient Get:@"Home" parametes:nil success:^(id responObj) {
    //        NSLog(@"%@",responObj);
    //    } failure:^(id err) {
    //        NSLog(@"%@",err);
    //    }];
    
    //茶评列表
    [CYWebClient Post:@"Test" parametes:nil success:^(id responObject) {
        NSLog(@"%@",responObject);
    } failure:^(id error) {
        NSLog(@"%@",error);
    }];
}
@end
