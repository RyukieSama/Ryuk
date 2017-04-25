//
//  RYBaseConfig.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RYMainTabBarController.h"
#import "RYBaseNavigationController.h"
//基础微博对象
#import "RYStatuse.h"
//本地用户信息
#import "RYDefaults.h"
//Net
#import "RYNetworkManager.h"
//Masnory
#import <Masonry.h>
//SD
#import <UIView+WebCache.h>
#import <UIButton+WebCache.h>
#import <UIView+WebCache.h>
#import <UIImageView+WebCache.h>
#import <WeiboSDK.h>

#pragma mark - SCREEN
#define RY_UI_SCREEN_WID [RYBaseConfig screenWid]
#define RY_UI_SCREEN_RECT [RYBaseConfig screenRect]

#pragma mark - SYSTEM
#define APP_VERSION                              [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
#define APP_BUILD_VERSION                   [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]
#define APP_DISPLAY_NAME                    [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"]

//weibo
#pragma mark - weibo
#define WEIBO_APPKEY                            @"4001732132"
#define WEIBO_REDIRECT_URI                   @"https://www.sina.com"

#pragma mark - COLOR
// 颜色(RGB)
#define RY_UI_COLOR_RGB(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RY_UI_COLOR_RGBA(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 随机颜色
#define RY_UI_COLOR_RANDOM     [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

@interface RYBaseConfig : NSObject
    
+ (CGFloat)screenWid;
    
+ (CGRect)screenRect;

/**
 "#e8e8e8" 这种格式字符串的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
    
@end
