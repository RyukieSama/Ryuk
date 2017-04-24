//
//  RYFlowTabController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYFlowTabController.h"
#import "RYBaseConfig.h"

@interface RYFlowTabController ()

@end

@implementation RYFlowTabController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.title = @"微博";
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [RYNetworkManager ry_getWithUrl:@"https://api.weibo.com/2/statuses/public_timeline.json"
                   requestDictionary:@{
                                       @"access_token" : [RYDefaults accessToken],
                                       @"count" : @20,
                                       @"page" : @1
                                       }
                       responseModel:nil
                            useCache:NO
                        writeToCache:NO
                   completionHandler:^(id data) {
        
    }];
}

@end
