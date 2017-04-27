//
//  RYURLHelper.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/27.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYURLHelper.h"

#define API_SHORT_TO_LONG_URL  @"https://api.weibo.com/2/short_url/expand.json"
//#define API_SHORT_TO_LONG_URL  @"http://video.weibo.com/show?fid=1034:279eb43fb291e8d12e46405f9b754684"

@implementation RYURLHelper

+ (void)getLongURLWith:(NSString *)shortURL callBack:(slCallBack)callBack {
    [RYNetworkManager ry_getWithUrl:API_SHORT_TO_LONG_URL
                  requestDictionary:@{
                                      @"url_short" : shortURL
                                      }
                      responseModel:nil
                           useCache:NO
                  completionHandler:^(id data) {
                      NSLog(@"%@",data);
                  }];
}

@end
