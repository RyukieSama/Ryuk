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
    UIViewController *flow = [self creatChildVC:@"RYFlowTabController" title:@"主页" image:[UIImage imageNamed:@"tab_flow"]];
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
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:image selectedImage:nil];
        item.titlePositionAdjustment = UIOffsetMake(0, 20);
        item.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);//顶部和底部绝对值不同的话点击后图片会变形
        navi.tabBarItem = item;
        return navi;
    }
    return nil;
}

@end
