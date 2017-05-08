//
//  RYStatuseManager.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/8.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RYStatuse;

typedef void(^completionHandler)(id obj);

@interface RYStatuseManager : NSObject

//微博相关操作
+ (void)likeStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler;
+ (void)favoStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler;
+ (void)unfavoStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler;
+ (void)commentStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler;
+ (void)reStatuse:(RYStatuse *)statuse completionHandler:(completionHandler)handler;



@end
