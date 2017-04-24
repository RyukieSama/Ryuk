//
//  RYBaseConfig.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYBaseConfig.h"

@implementation RYBaseConfig

+ (CGFloat)screenWid {
    return [UIScreen mainScreen].bounds.size.width;
}
    
+ (CGRect)screenRect {
    return [UIScreen mainScreen].bounds;
}
    
@end
