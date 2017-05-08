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
//Router
#import "RYRouter.h"
//本地用户信息
#import "RYDefaults.h"
//Net
#import "RYNetworkManager.h"
//微博相关操作
#import "RYStatuseManager.h"
//Masnory
#import <Masonry.h>
//SD
#import <UIView+WebCache.h>
#import <UIButton+WebCache.h>
#import <UIView+WebCache.h>
#import <UIImageView+WebCache.h>
#import <WeiboSDK.h>
#import <MJRefresh.h>
//组件
#import "RYAvatarView.h"
//微博发布器
#import "RYPoster.h"

#pragma mark - SCREEN
#define RY_UI_SCREEN_WID [RYBaseConfig screenWid]
#define RY_UI_SCREEN_HEIGHT [RYBaseConfig screenHeight]
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
#define RY_COLOR_GRAY_E8E8E8 [RYBaseConfig colorWithHexString:@"e8e8e8"]
// 随机颜色
#define RY_UI_COLOR_RANDOM     [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]
//默认占位图
#define RY_PLACEHOLDER_IMAGE [UIImage imageNamed:@"e8e8e8"]
//默认头像
#define RY_AVATAR_IMAGE [UIImage imageNamed:@"a0a0a0"]
//默认占位图 9:3
#define RY_COVER_IMAGE [UIImage imageNamed:@"cover"]
//字体
#define RY_FONT(x) [UIFont systemFontOfSize:(x)]
//分割线高度
#define RY_HEIGHT_LINE  1/[UIScreen mainScreen].nativeScale

@interface RYBaseConfig : NSObject
    
+ (CGFloat)screenWid;

+ (CGFloat)screenHeight;
    
+ (CGRect)screenRect;

/**
 "#e8e8e8" 这种格式字符串的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
    
@end
