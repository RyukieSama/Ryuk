//
//  RYDefaults.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYDefaults : NSObject

+ (instancetype)sharedManager;

+ (NSString *)accessToken;
+ (void)setAccessToken:(NSString *)accessToken;
+ (void)removeAccessToken;

+ (NSString *)userID;
+ (void)setUserID:(NSString *)userID;
+ (void)removeUserID;

+ (NSString *)refreshToken;
+ (void)setRefreshToken:(NSString *)refreshToken;
+ (void)removeRefreshToken;

@end
