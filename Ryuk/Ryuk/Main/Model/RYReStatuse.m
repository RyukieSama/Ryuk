//
//  RYReStatuse.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/26.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYReStatuse.h"
#import <MJExtension.h>

@implementation RYReStatuse

MJLogAllIvars

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"pic_urls" : @"RYImage"
             };
}

- (NSArray<NSString *> *)pic_urls_strings {
    if (!_pic_urls_strings) {
        NSMutableArray *muArr = @[].mutableCopy;
        for (RYImage *img in self.pic_urls) {
            [muArr addObject:img.bmiddle_pic];
        }
        _pic_urls_strings = muArr.copy;
    }
    return _pic_urls_strings;
}

@end
