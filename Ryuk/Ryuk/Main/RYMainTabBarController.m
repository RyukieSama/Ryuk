//
//  RYMainTabBarController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYMainTabBarController.h"
#import "RYBaseConfig.h"
#import "RYBaseNavigationController.h"

@interface RYMainTabBarController ()

@end

@implementation RYMainTabBarController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildrenVCs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

#pragma mark - UI
- (void)setChildrenVCs {
    //Flow
    UIViewController *flow = [self creatChildVC:@"RYFlowTabController" title:@"主页" image:nil];
    if (flow) {
        [self addChildViewController:flow];
    }
    
    //Message
    UIViewController *message = [self creatChildVC:@"RYMessageTabController" title:@"消息" image:nil];
    if (message) {
        [self addChildViewController:message];
    }
    
    //Center
    UIViewController *center = [self creatChildVC:@"RYCenterTabController" title:@"个人中心" image:nil];
    if (center) {
        [self addChildViewController:center];
    }
    
}

- (UIViewController *)creatChildVC:(NSString *)vcClassString title:(NSString *)title image:(UIImage *)image {
    id vc = [[NSClassFromString(vcClassString) alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        RYBaseNavigationController *navi = [[RYBaseNavigationController alloc] initWithRootViewController:vc];
        navi.title = title;
        navi.tabBarItem.image = image;
        return navi;
    }
    return nil;
}

@end
