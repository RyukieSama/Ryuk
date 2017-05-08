//
//  RYRouter.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/4.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+RYRouter.h"

typedef void(^pushCallBack)(id obj);

@interface RYRouter : NSObject

+ (instancetype)sharedInstance;

+ (UIViewController *)getAppTopViewController;

+ (void)loadVCWithID:(NSString *)vcID viewControllerClass:(Class)cls;

//PUSH
+ (void)ryPushToVC:(NSString *)vc param:(id)param callBack:(pushCallBack)callBack;
+ (void)ryPushToVC:(NSString *)vc param:(id)param;
+ (void)ryPushToVC:(NSString *)vc;

//Present
+ (void)ryPresentVC:(NSString *)vc param:(id)param callBack:(pushCallBack)callBack;
+ (void)ryPresentVC:(NSString *)vc param:(id)param;
+ (void)ryPresentVC:(NSString *)vc;

#pragma mark - VCKeys
/**
 某个用户的主页
 */
#define RY_ROUTER_VC_KEY_USERHOMEPAGE @"RY_ROUTER_VC_KEY_USERHOMEPAGE"
/**
 weibo发布
 */
#define RY_ROUTER_VC_KEY_POSTSTATUSE @"RY_ROUTER_VC_KEY_POSTSTATUSE"
/**
 评论转发
 */
#define RY_ROUTER_VC_KEY_REANDCOMMENT @"RY_ROUTER_VC_KEY_REANDCOMMENT"

@end
