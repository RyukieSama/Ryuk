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

- (RYStatuseType)statuseType {
    if (self.original_pic.length == 0) {
        return RYStatuseTypeText;
    }
    if (self.pic_urls.count == 1) {
        return RYStatuseTypeImageOne;
    }
    if (self.pic_urls.count == 2) {
        return RYStatuseTypeImageTwo;
    }
    if (self.pic_urls.count == 3) {
        return RYStatuseTypeImageThree;
    }
    if (self.pic_urls.count == 4) {
        return RYStatuseTypeImageFour;
    }
    if (self.pic_urls.count == 5) {
        return RYStatuseTypeImageFive;
    }
    if (self.pic_urls.count == 6) {
        return RYStatuseTypeImageSix;
    }
    if (self.pic_urls.count == 7) {
        return RYStatuseTypeImageSeven;
    }
    if (self.pic_urls.count == 8) {
        return RYStatuseTypeImageEight;
    }
    if (self.pic_urls.count == 9) {
        return RYStatuseTypeImageNine;
    }
    if (self.source_type == 1) {
        return RYStatuseTypeVideo;
    }
    
    return RYStatuseTypeText;
}

@end
