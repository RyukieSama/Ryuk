//
//  RYFlowPageModel.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYFlowPageModel.h"

@implementation RYFlowPageModel

MJLogAllIvars

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"statuses" : @"RYStatuse",
             @"reposts" : @"RYStatuse",
             @"comments" : @"RYComment"
             };
}

@end
