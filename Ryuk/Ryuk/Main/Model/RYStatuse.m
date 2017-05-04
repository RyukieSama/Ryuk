//
//  RYStatuse.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYStatuse.h"

@implementation RYStatuse

MJLogAllIvars

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"pic_urls" : @"RYImage"
             };
}

- (RYStatuseType)statuseType {
    if (self.original_pic.length == 0 && self.retweeted_status.original_pic.length == 0) {
        return RYStatuseTypeText;
    }
    if (self.pic_urls.count == 9) {
        return RYStatuseTypeImageNine;
    }
//    if (self.source_type == 1) {
//        return RYStatuseTypeVideo;
//    }
    return RYStatuseTypeImageOne;
}

- (NSString *)cellID {
    if (self.statuseType == RYStatuseTypeText) {
        return RYStatuseCellIDText;
    }
    if (self.statuseType == RYStatuseTypeImageNine) {
        return RYStatuseCellIDNine;
    }
    if (self.statuseType == RYStatuseTypeVideo) {
        return RYStatuseCellIDVideo;
    }
    return RYStatuseCellIDOne;
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
