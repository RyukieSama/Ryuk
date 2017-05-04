//
//  RYUserCenterController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/4.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYUserCenterController.h"
#import "RYBaseConfig.h"

@interface RYUserCenterController ()

@end

@implementation RYUserCenterController

+ (void)load {
    [RYRouter loadVCWithID:RY_ROUTER_VC_KEY_USERHOMEPAGE viewControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI {
    self.title = @"xxx的主页";
    self.view.backgroundColor = [UIColor greenColor];
}

@end
