//
//  RYNetworkManager.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYNetworkManager.h"

typedef NS_ENUM(NSInteger, RYWeiboErrorCode) {
    //token过期   统一处理  提醒重新授权
    RYWeiboErrorCodeTokenExpired = 21315,
    RYWeiboErrorCodeExpiredToken = 21327,
    //
};

//static NSMutableDictionary *baseDict;
static NSMutableDictionary *operationCachePool;
static NSConditionLock *conditionLock;

@implementation RYNetworkManager

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //         *baseModel = [ new];
        //        baseModel.ver = [[UIApplication sharedApplication] appVersion];
        //        baseModel.protocol_ver = 1;
        //        baseModel.platformType = 1;
        //        baseModel.larkAppId = 1;
        //        baseDict = [[NSMutableDictionary alloc] initWithDictionary:[baseModel mj_keyValues]];
        operationCachePool = [[NSMutableDictionary alloc] initWithCapacity:0];
        conditionLock = [[NSConditionLock alloc] init];
    });
}

+ (instancetype)sharedManager {
    static RYNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RYNetworkManager alloc] init];
    });
    return instance;
}

+ (void)postURL:(NSString *)URL parameter:(NSDictionary *)parameter successCallBack:(networkCallBack)success failCallback:(networkCallBack)fail {
    
}

+ (void)getURL:(NSString *)URL parameter:(NSDictionary *)parameter successCallBack:(networkCallBack)success failCallback:(networkCallBack)fail {
    
}

+ (NSURLSessionDataTask *)ry_postWithUrl:(NSString *)url requestDictionary:(NSDictionary *)requestDict responseModel:(Class)responseModel useCache:(BOOL)useCache writeToCache:(BOOL)writeToCache completionHandler:(networkCallBack)completionHandler {
    if([url rangeOfString:@" "].location != NSNotFound)
        url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (useCache && url && responseModel) {
        //        [[RYNetworkManager sharedInstance] getProtocolCacheWithURL:url responseModel:responseModel completionHandler:completionHandler];
    }
    
    [conditionLock lock];
    
    NSLog(@"------------------------------- \n %@ \n -------------------------------",requestDict);
    
    NSURLSessionDataTask *operation = [[RYNetworkManager sharedManager] POST:url
                                                                  parameters:requestDict
                                                                    progress:nil
                                                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                         if ([operationCachePool objectForKey:url]) {
                                                                             [operationCachePool removeObjectForKey:url];
                                                                         }
                                                                         NSDictionary *dic = responseObject;
                                                                         
                                                                         NSLog(@"------------------------------- \n %@ \n -------------------------------",dic);
                                                                         
                                                                         if (dic.allKeys.count == 0) {
                                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                                 completionHandler(nil);
                                                                             });
                                                                             return;
                                                                         }
                                                                         
                                                                         //                                                                            *meta = [ metaWithDictionary:dic responseModel:responseModel];
                                                                         //                                                                           if (meta.errcode != ERROR_CODE_JAVA_200 && meta) {
                                                                         //                                                                               if ([ sharedInstance].errorHandler)
                                                                         //                                                                                   [ sharedInstance].errorHandler(meta,url,parameters);
                                                                         //                                                                           }
                                                                         //                                                                           /**
                                                                         //                                                                            *  使用缓存的时候 请求结果成功时
                                                                         //                                                                            */
                                                                         //                                                                           if (writeToCache && dic && useCache && meta.ret && meta.errcode == ERROR_CODE_JAVA_200) {
                                                                         //                                                                               [[ sharedInstance] putObject:dic withId:url dataType:];
                                                                         //                                                                           }
                                                                         
                                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                                             completionHandler(dic ?: nil);
                                                                         });
                                                                     }
                                                                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                         if ([operationCachePool objectForKey:url]) {
                                                                             [operationCachePool removeObjectForKey:url];
                                                                         }
                                                                         
                                                                         NSLog(@"\n error------------%@ \n",error);
                                                                         NSDictionary *errorInfo = error.userInfo;
                                                                         
                                                                         //                                                                       if ([ sharedInstance].errorHandler) {
                                                                         //                                                                           [ sharedInstance].errorHandler(errorInfo?:@"no meta",url,parameters);
                                                                         //                                                                       }
                                                                         
                                                                         if ([errorInfo objectForKey:@"NSLocalizedDescription"]) {
                                                                             if ([[errorInfo objectForKey:@"NSLocalizedDescription"] isEqualToString:@"cancelled"] || [[errorInfo objectForKey:@"NSLocalizedDescription"] isEqualToString:@"已取消"]) {
                                                                                 NSLog(@"operation call cancelled");
                                                                                 return ;
                                                                             }
                                                                         }
                                                                         
                                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                                             completionHandler(nil);
                                                                         });
                                                                     }];
    
    if (operation) {
        [operationCachePool setObject:operation forKey:url];
        [operation resume];
    }
    
    [conditionLock unlock];
    
    return operation;
}

+ (NSURLSessionDataTask *)ry_getWithUrl:(NSString *)url requestDictionary:(NSDictionary *)requestDict responseModel:(Class)responseModel useCache:(BOOL)useCache writeToCache:(BOOL)writeToCache completionHandler:(networkCallBack)completionHandler {
    if([url rangeOfString:@" "].location != NSNotFound)
        url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (useCache && url && responseModel) {
        //        [[RYNetworkManager sharedInstance] getProtocolCacheWithURL:url responseModel:responseModel completionHandler:completionHandler];
    }
    
    [conditionLock lock];
    
    NSLog(@"------------------------------- \n %@ \n -------------------------------",requestDict);
    
    NSURLSessionDataTask *operation = [[RYNetworkManager sharedManager] GET:url
                                                                 parameters:requestDict
                                                                   progress:nil
                                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                        if ([operationCachePool objectForKey:url]) {
                                                                            [operationCachePool removeObjectForKey:url];
                                                                        }
                                                                        NSDictionary *dic = responseObject;
                                                                        
                                                                        NSLog(@"------------------------------- \n %@ \n -------------------------------",dic);
                                                                        
                                                                        if (dic.allKeys.count == 0) {
                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                completionHandler(nil);
                                                                            });
                                                                            return;
                                                                        }
                                                                        
                                                                        //                                                                            *meta = [ metaWithDictionary:dic responseModel:responseModel];
                                                                        //                                                                           if (meta.errcode != ERROR_CODE_JAVA_200 && meta) {
                                                                        //                                                                               if ([ sharedInstance].errorHandler)
                                                                        //                                                                                   [ sharedInstance].errorHandler(meta,url,parameters);
                                                                        //                                                                           }
                                                                        //                                                                           /**
                                                                        //                                                                            *  使用缓存的时候 请求结果成功时
                                                                        //                                                                            */
                                                                        //                                                                           if (writeToCache && dic && useCache && meta.ret && meta.errcode == ERROR_CODE_JAVA_200) {
                                                                        //                                                                               [[ sharedInstance] putObject:dic withId:url dataType:];
                                                                        //                                                                           }
                                                                        
                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                            completionHandler(dic ?: nil);
                                                                        });
                                                                    }
                                                                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                        if ([operationCachePool objectForKey:url]) {
                                                                            [operationCachePool removeObjectForKey:url];
                                                                        }
                                                                        
                                                                        NSLog(@"\n error------------%@ \n",error);
                                                                        NSDictionary *errorInfo = error.userInfo;
                                                                        
                                                                        //                                                                       if ([ sharedInstance].errorHandler) {
                                                                        //                                                                           [ sharedInstance].errorHandler(errorInfo?:@"no meta",url,parameters);
                                                                        //                                                                       }
                                                                        
                                                                        if ([errorInfo objectForKey:@"NSLocalizedDescription"]) {
                                                                            if ([[errorInfo objectForKey:@"NSLocalizedDescription"] isEqualToString:@"cancelled"] || [[errorInfo objectForKey:@"NSLocalizedDescription"] isEqualToString:@"已取消"]) {
                                                                                NSLog(@"operation call cancelled");
                                                                                return ;
                                                                            }
                                                                        }
                                                                        
                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                            completionHandler(nil);
                                                                        });
                                                                    }];
    
    if (operation) {
        [operationCachePool setObject:operation forKey:url];
        [operation resume];
    }
    
    [conditionLock unlock];
    
    return operation;
    
}

@end
