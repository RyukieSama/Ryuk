//
//  RYTextUnit.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/12.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYTextUnit.h"
#import <MJExtension.h>
#import "RYBaseConfig.h"

@implementation RYTextUnit

MJLogAllIvars

- (void)touchEventGo {
    switch (self.type) {
        case RYTextUnitTypeURL:
            [self linkClick];
            break;
        case RYTextUnitTypeAt:
            [self atClick];
            break;
        case RYTextUnitTypeEmoji:
            [self emojiClick];
            break;
        case RYTextUnitTypeSharp:
            [self sharpClick];
            break;
        default:
            break;
    }
}

#pragma mark - function
- (void)atClick {
    [RYRouter ryPushToVC:RY_ROUTER_VC_KEY_USERHOMEPAGE param:@{@"userName" : self.content}];
}

- (void)sharpClick {
    [RYRouter ryPushToVC:RY_ROUTER_VC_KEY_TOPIC_FLOW param:@{@"topicName" : self.content}];
}

- (void)linkClick {
    [RYRouter ryPushToVC:RY_ROUTER_VC_KEY_WEBVIEW param:@{@"url" : self.content}];
}

- (void)emojiClick {
    NSLog(@"%s",__FUNCTION__);
}

@end
