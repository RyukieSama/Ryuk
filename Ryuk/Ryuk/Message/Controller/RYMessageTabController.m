//
//  RYMessageTabController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYMessageTabController.h"

@interface RYMessageTabController ()

@end

@implementation RYMessageTabController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)setupUI {
//    self.title = @"消息";
    self.view.backgroundColor = [UIColor redColor];
}

@end
