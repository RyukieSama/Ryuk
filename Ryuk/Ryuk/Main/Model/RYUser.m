//
//  RYUser.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYUser.h"
#import <MJExtension.h>

@implementation RYUser

MJLogAllIvars

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return  @{
              @"description_wb" : @"description"
              };
}

@end
