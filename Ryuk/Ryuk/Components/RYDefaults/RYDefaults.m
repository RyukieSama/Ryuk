//
//  RYDefaults.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYDefaults.h"

#define ACCESS_TOKEN @"accessToken"
#define USER_ID @"USER_ID"
#define REFRESH_TOKEN @"refreshToken"

@implementation RYDefaults

+ (instancetype)sharedManager {
    static RYDefaults *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RYDefaults alloc] init];
    });
    return instance;
}

#pragma mark - token
+ (void)setAccessToken:(NSString *)accessToken {
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeAccessToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)accessToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
}

#pragma mark - userID
+ (NSString *)userID {
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
}

+ (void)setUserID:(NSString *)userID {
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeUserID {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - refreshToken
+ (NSString *)refreshToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:REFRESH_TOKEN];
}

+ (void)setRefreshToken:(NSString *)refreshToken {
    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:REFRESH_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeRefreshToken {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:REFRESH_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
