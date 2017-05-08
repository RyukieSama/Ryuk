//
//  RYReAndCommentController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/8.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYReAndCommentController.h"
#import "RYBaseConfig.h"
#import "RYPostToolBar.h"


@interface RYReAndCommentController ()



@end

@implementation RYReAndCommentController

+ (void)load {
    [RYRouter loadVCWithID:RY_ROUTER_VC_KEY_REANDCOMMENT viewControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

#pragma mark - function


#pragma mark - UI
- (void)setupUI {
    [super setupUI];
    if ([[self.params objectForKey:@"type"] integerValue] == 1) {
        self.title = @"评论";
    } else {
        self.title = @"转发";
    }
}

#pragma mark - lazy


@end
