//
//  RYRouter.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/4.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYRouter.h"
#import "RYBaseNavigationController.h"

@interface RYRouter ()

@property (nonatomic) NSMutableDictionary *routes;

@end

@implementation RYRouter

+ (instancetype)sharedInstance {
    static RYRouter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RYRouter alloc] init];
        instance.routes = @{}.mutableCopy;
    });
    return instance;
}

+ (UIViewController *)getAppTopViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return tabBarController.selectedViewController;
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return navigationController.visibleViewController;
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return presentedViewController.presentedViewController;
    } else {
        return rootViewController;
    }
}

+ (void)loadVCWithID:(NSString *)vcID viewControllerClass:(Class)cls {
    [((RYRouter *)[self sharedInstance]).routes setObject:cls forKey:vcID];
}

#pragma mark - PUSH
+ (void)ryPushToVC:(NSString *)vc {
    [self ryPushToVC:vc param:nil];
}

+ (void)ryPushToVC:(NSString *)vc param:(id)param {
    [self ryPushToVC:vc param:param callBack:nil];
}

+ (Class)getClassForID:(NSString *)vcID {
    return [[RYRouter sharedInstance].routes objectForKey:vcID];
}

+ (void)ryPushToVC:(NSString *)vc param:(id)param callBack:(pushCallBack)callBack {
    Class vcClass = [RYRouter getClassForID:vc];
    NSLog(@"\n-------------------------- vcID is %@ ------------------------\n",vc);
    UIViewController *topVC = [RYRouter getAppTopViewController];
    UIViewController *toVC = [[vcClass alloc] init];
    [toVC setHidesBottomBarWhenPushed:YES];
    toVC.params = param;
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController *)topVC) pushViewController:toVC animated:YES];
    } else {
        [topVC.navigationController pushViewController:toVC animated:YES];
    }
}

#pragma mark - Present
+ (void)ryPresentVC:(NSString *)vc {
    [RYRouter ryPresentVC:vc param:nil];
}

+ (void)ryPresentVC:(NSString *)vc param:(id)param {
    [RYRouter ryPresentVC:vc param:param callBack:^(id obj) {
        
    }];
}

+ (void)ryPresentVC:(NSString *)vc param:(id)param callBack:(pushCallBack)callBack {
    Class vcClass = [RYRouter getClassForID:vc];
    NSLog(@"\n-------------------------- vcID is %@ ------------------------\n",vc);
    UIViewController *topVC = [RYRouter getAppTopViewController];
    UIViewController *toVC = [[vcClass alloc] init];
    toVC.params = param;
    RYBaseNavigationController *navi = [[RYBaseNavigationController alloc] initWithRootViewController:toVC];
    [topVC presentViewController:navi
                                             animated:YES
                                           completion:^{
                                               
                                           }];
}

@end
