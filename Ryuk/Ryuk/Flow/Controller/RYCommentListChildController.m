//
//  RYCommentListChildController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/9.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYCommentListChildController.h"
#import "RYBaseConfig.h"

@interface RYCommentListChildController ()

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger type;

@end

@implementation RYCommentListChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.id = [[self.params objectForKey:@"id"] integerValue];
    self.type = [[self.params objectForKey:@"type"] integerValue];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"- [%@ dealloc]",[self class]);
}

#pragma mark - UI 
- (void)setupUI {
    self.view.backgroundColor = (self.type == 2) ? [UIColor redColor] : [UIColor cyanColor];
}

@end
