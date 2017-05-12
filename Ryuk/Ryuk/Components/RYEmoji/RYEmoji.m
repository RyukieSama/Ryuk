//
//  RYEmoji.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/12.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYEmoji.h"
#import "RYBaseConfig.h"

#define API_GET_WEIBO_EMOJI @"https://api.weibo.com/2/emotions.json"

static NSString *enmojiFace = @"face";
static NSString *enmojiAni = @"ani";
static NSString *enmojiCartoon = @"cartoon";

@implementation RYEmoji

+ (instancetype)sharedInstance {
    static RYEmoji *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RYEmoji alloc] init];
    });
    return instance;
}

+ (void)getEmojis {
    //TODO: 先看本地有没有缓存
    
    //TODO: 从网络下载
//    type	false	string	表情类别，face：普通表情、ani：魔法表情、cartoon：动漫表情，默认为face。
//    language	false	string	语言类别，cnname：简体、twname：繁体，默认为cnname。
    
    NSDictionary *param = @{
                            @"type" : @"",
                            @"language" : @""
                            };
    
    
}

@end
