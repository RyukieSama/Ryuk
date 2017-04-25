//
//  RYNetworkManager.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <MJExtension.h>

typedef void(^networkCallBack)(id data);

@interface RYNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

+ (void)postURL:(NSString *)URL parameter:(NSDictionary *)parameter successCallBack:(networkCallBack)success failCallback:(networkCallBack)fail;

+ (void)getURL:(NSString *)URL parameter:(NSDictionary *)parameter successCallBack:(networkCallBack)success failCallback:(networkCallBack)fail;

+ (NSURLSessionDataTask *)ry_postWithUrl:(NSString *)url requestDictionary:(NSDictionary *)requestDict responseModel:(Class)responseModel useCache:(BOOL)useCache writeToCache:(BOOL)writeToCache completionHandler:(networkCallBack)completionHandler;

+ (NSURLSessionDataTask *)ry_getWithUrl:(NSString *)url requestDictionary:(NSDictionary *)requestDict responseModel:(Class)responseModel useCache:(BOOL)useCache completionHandler:(networkCallBack)completionHandler;

@end
