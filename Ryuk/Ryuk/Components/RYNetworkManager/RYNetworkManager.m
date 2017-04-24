//
//  RYNetworkManager.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYNetworkManager.h"

@implementation RYNetworkManager

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

@end
