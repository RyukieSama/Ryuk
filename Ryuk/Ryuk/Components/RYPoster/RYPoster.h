//
//  RYPoster.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/5.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYBaseConfig.h"
#import "RYPosterController.h"
@class RYStatuse;

@interface RYPoster : NSObject

/**
 发布微博
 */
+ (void)postStatuse;

/**
 转发微博

 @param statuse 被转发的微博
 */
+ (void)repostStatuse:(RYStatuse *)statuse;

@end
