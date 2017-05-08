//
//  RYStatuseManager.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/8.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYStatuseManager.h"
#import "RYBaseConfig.h"

#define API_ADD_FAVO @"https://api.weibo.com/2/favorites/create.json"
#define API_DELE_FAVO @"https://api.weibo.com/2/favorites/destroy.json"

@interface RYStatuseManager ()

@property (nonatomic, strong) RYStatuse *statuse;

@end

@implementation RYStatuseManager

+ (void)likeStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler {

}

+ (void)favoStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler {
    NSDictionary *param = @{
                            @"id" : @(statuse.id)
                            };

    [RYNetworkManager ry_postWithUrl:API_ADD_FAVO
                   requestDictionary:param
                       responseModel:nil
                            useCache:NO
                   completionHandler:^(id data) {
                       if (!data) {
                           return;
                       }
                       
                       statuse.favorited = YES;
                       
                       if (handler) {
                           handler(@(1));
                       }
                   }];
}

+ (void)unfavoStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler {
    NSDictionary *param = @{
                            @"id" : @(statuse.id)
                            };
    
    [RYNetworkManager ry_postWithUrl:API_DELE_FAVO
                   requestDictionary:param
                       responseModel:nil
                            useCache:NO
                   completionHandler:^(id data) {
                       if (!data) {
                           return;
                       }
                       
                       statuse.favorited = NO;
                       
                       if (handler) {
                           handler(@(0));
                       }
                   }];
}

+ (void)commentStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler {
    
}

+ (void)reStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler {
    
}

@end
