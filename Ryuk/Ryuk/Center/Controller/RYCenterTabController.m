//
//  RYCenterTabController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYCenterTabController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface RYCenterTabController ()

@end

@implementation RYCenterTabController

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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 9.0 视频播放
    // 1.创建一个播放对象,并且实例化
    AVPlayerViewController *playViewController = [[AVPlayerViewController alloc] init];
    
    // 2.1获取资源路径
    NSURL *url = [NSURL URLWithString:@"https://video.weibo.com/show?fid=1034:279eb43fb291e8d12e46405f9b754684"];
    
    // 2.设置属性
    playViewController.player = [[AVPlayer alloc] initWithURL:url];
    
    // 3.播放
    [playViewController.player play];
    
    //modal 控制器的方式
    [self presentViewController:playViewController animated:YES completion:nil];
    
//    // 或者这样调用 添加子控件的方式
//    playViewController.view.frame = CGRectMake(0, 0, 300, 400);
//    
//    [self.view addSubview:playViewController.view];
}


#pragma mark - UI
- (void)setupUI {
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor greenColor];
}

@end
