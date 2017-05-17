//
//  RYTextUnit.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/12.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYTextUnit.h"
#import <MJExtension.h>

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
    NSLog(@"%s",__FUNCTION__);
}

- (void)sharpClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)linkClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)emojiClick {
    NSLog(@"%s",__FUNCTION__);
}

@end
