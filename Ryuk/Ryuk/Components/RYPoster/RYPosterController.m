//
//  RYPosterController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/5.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYPosterController.h"
#import "RYBaseConfig.h"

@interface RYPosterController ()

@end

@implementation RYPosterController

+ (void)load {
    [RYRouter loadVCWithID:RY_ROUTER_VC_KEY_POSTSTATUSE viewControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

#pragma mark - action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UI
- (void)setupUI {
    self.title = @"发布";
    self.view.backgroundColor = [UIColor cyanColor];
}

#pragma mark - lazy


@end
