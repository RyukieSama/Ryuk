//
//  RYImage.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/26.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYImage.h"
#import <MJExtension.h>

@implementation RYImage

MJLogAllIvars

- (NSString *)original_pic {
    if (!_original_pic) {
        _original_pic = [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:@"/large/"];
    }
    return _original_pic;
}

- (NSString *)bmiddle_pic {
    if (!_bmiddle_pic) {
        _bmiddle_pic = [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"/thumbnail/" withString:@"/bmiddle/"];
    }
    return _bmiddle_pic;
}

@end
