//
//  RYNetworkManager.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYNetworkManager.h"
#import "RYBaseConfig.h"

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

//+ (void)postURL:(NSString *)URL parameter:(NSDictionary *)parameter successCallBack:(networkCallBack)success failCallback:(networkCallBack)fail {
//    
//}
//
//+ (void)getURL:(NSString *)URL parameter:(NSDictionary *)parameter successCallBack:(networkCallBack)success failCallback:(networkCallBack)fail {
//    
//}

+ (NSURLSessionDataTask *)ry_postWithUrl:(NSString *)url requestDictionary:(NSDictionary *)requestDict responseModel:(Class)responseModel useCache:(BOOL)useCache completionHandler:(networkCallBack)completionHandler {
    if([url rangeOfString:@" "].location != NSNotFound) {
        url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    [conditionLock lock];
    
    NSMutableDictionary *mudic = requestDict.mutableCopy;
    [mudic setObject:[RYDefaults accessToken] forKey:@"access_token"];
    
    NSLog(@"------------------------------- \n %@ \n -------------------------------",mudic);
    
    NSURLSessionDataTask *operation = [[RYNetworkManager sharedManager] POST:url
                                                                  parameters:mudic
                                                                    progress:nil
                                                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                         if ([operationCachePool objectForKey:url]) {
                                                                             [operationCachePool removeObjectForKey:url];
                                                                         }
                                                                         
                                                                         if ([responseObject isKindOfClass:[NSArray class]]) {
                                                                             if ([responseObject count] == 0) {
                                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                                     completionHandler(nil);
                                                                                 });
                                                                                 return;
                                                                             }
                                                                             
                                                                             NSLog(@"------------------------------- \n %@ \n -------------------------------",responseObject);
                                                                             
                                                                             //正常返回
                                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                                 if (responseModel) {
                                                                                     completionHandler([responseModel mj_objectArrayWithKeyValuesArray:responseObject] ?: nil);
                                                                                 } else {
                                                                                     completionHandler(responseObject ?: nil);
                                                                                 }
                                                                             });
                                                                             
                                                                         } else {
                                                                             NSDictionary *dic = responseObject;
                                                                             
                                                                             NSLog(@"------------------------------- \n %@ \n -------------------------------",dic);
                                                                             
                                                                             //空
                                                                             if (dic.allKeys.count == 0) {
                                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                                     completionHandler(nil);
                                                                                 });
                                                                                 return;
                                                                             }
                                                                             
                                                                             //是否报错
                                                                             if ([dic objectForKey:@"error_code"]) {
                                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                                     completionHandler(dic ?: nil);
                                                                                 });
                                                                             }
                                                                             
                                                                             //正常返回
                                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                                 if (responseModel) {
                                                                                     completionHandler([responseModel mj_objectWithKeyValues:dic] ?: nil);
                                                                                 } else {
                                                                                     completionHandler(dic ?: nil);
                                                                                 }
                                                                             });
                                                                         }
                                                                         
                                                                     }
                                                                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                         if ([operationCachePool objectForKey:url]) {
                                                                             [operationCachePool removeObjectForKey:url];
                                                                         }
                                                                         
                                                                         NSLog(@"\n error------------%@ \n",error);
                                                                         NSDictionary *errorInfo = error.userInfo;

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

+ (NSURLSessionDataTask *)ry_getWithUrl:(NSString *)url requestDictionary:(NSDictionary *)requestDict responseModel:(Class)responseModel useCache:(BOOL)useCache completionHandler:(networkCallBack)completionHandler {
    if([url rangeOfString:@" "].location != NSNotFound) {
        url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    [conditionLock lock];
    
    NSMutableDictionary *mudic = requestDict.mutableCopy;
    [mudic setObject:[RYDefaults accessToken] forKey:@"access_token"];
    
    NSLog(@"------------------------------- \n %@ \n -------------------------------",mudic);
    
    NSURLSessionDataTask *operation = [[RYNetworkManager sharedManager] GET:url
                                                                 parameters:mudic
                                                                   progress:nil
                                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                        if ([operationCachePool objectForKey:url]) {
                                                                            [operationCachePool removeObjectForKey:url];
                                                                        }
                                                                        
                                                                        if ([responseObject isKindOfClass:[NSArray class]]) {
                                                                            if ([responseObject count] == 0) {
                                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                                    completionHandler(nil);
                                                                                });
                                                                                return;
                                                                            }
                                                                            
                                                                            NSLog(@"------------------------------- \n %@ \n -------------------------------",responseObject);
                                                                            
                                                                            //正常返回
                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                if (responseModel) {
                                                                                    completionHandler([responseModel mj_objectArrayWithKeyValuesArray:responseObject] ?: nil);
                                                                                } else {
                                                                                    completionHandler(responseObject ?: nil);
                                                                                }
                                                                            });
                                                                            
                                                                        } else {
                                                                            NSDictionary *dic = responseObject;
                                                                            
                                                                            NSLog(@"------------------------------- \n %@ \n -------------------------------",dic);
                                                                            
                                                                            //空
                                                                            if (dic.allKeys.count == 0) {
                                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                                    completionHandler(nil);
                                                                                });
                                                                                return;
                                                                            }
                                                                            
                                                                            //是否报错
                                                                            if ([dic objectForKey:@"error_code"]) {
                                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                                    completionHandler(dic ?: nil);
                                                                                });
                                                                            }
                                                                            
                                                                            //正常返回
                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                if (responseModel) {
                                                                                    completionHandler([responseModel mj_objectWithKeyValues:dic] ?: nil);
                                                                                } else {
                                                                                    completionHandler(dic ?: nil);
                                                                                }
                                                                            });
                                                                        }
                                                                        
                                                                    }
                                                                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                        if ([operationCachePool objectForKey:url]) {
                                                                            [operationCachePool removeObjectForKey:url];
                                                                        }
                                                                        
                                                                        NSLog(@"\n error------------%@ \n",error);
                                                                        NSDictionary *errorInfo = error.userInfo;
                                                                        
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
