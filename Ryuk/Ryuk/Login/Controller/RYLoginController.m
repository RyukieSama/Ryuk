//
//  RYLoginController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYLoginController.h"
#import "RYBaseConfig.h"

@interface RYLoginController ()

@property (nonatomic, strong) UIButton *btLogin;

@end

@implementation RYLoginController

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
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.btLogin];
    [self.btLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
}

#pragma mark - action
- (void)loginClick {
    NSLog(@"login");
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"https://www.sina.com";
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"RYLoginController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

#pragma mark - lazy
- (UIButton *)btLogin {
    if (!_btLogin) {
        _btLogin = [[UIButton alloc] init];
        _btLogin.backgroundColor = [UIColor grayColor];
        [_btLogin addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        [_btLogin setTitle:@"登录" forState:UIControlStateNormal];
        [_btLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btLogin;
}

@end
