//
//  RYPoster.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/5.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYPoster.h"

@interface RYPoster ()

@end

@implementation RYPoster

+ (void)postStatuse {
    [RYRouter ryPresentVC:RY_ROUTER_VC_KEY_POSTSTATUSE
                   param:nil
                callBack:^(id obj) {
                    
                }];
}

+ (void)repostStatuse:(RYStatuse *)statuse {
    
}

@end
