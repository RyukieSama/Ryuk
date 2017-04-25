//
//  RYFlowTabController.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYFlowTabController.h"
#import "RYBaseConfig.h"
#import "RYFlowPageModel.h"

#define API_MY_TIMELINE @"https://api.weibo.com/2/statuses/home_timeline.json"

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
    //    access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
    //    since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    //    max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    //    count	false	int	单页返回的记录条数，最大不超过100，默认为20。
    //    page	false	int	返回结果的页码，默认为1。
    //    base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
    //    feature	false	int	过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
    //    trim_user	false	int	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
    [RYNetworkManager ry_getWithUrl:API_MY_TIMELINE
                  requestDictionary:@{
                                      @"since_id" : @0,
                                      @"max_id" : @0,
                                      @"count" : @20,
                                      @"page" : @1,
                                      @"base_app" : @0,
                                      @"feature" : @0,
                                      @"trim_user" : @0
                                      }
                      responseModel:[RYFlowPageModel class]
                           useCache:NO
                  completionHandler:^(id data) {
                      NSLog(@"kkk===%@",data);
                  }];
}

@end
