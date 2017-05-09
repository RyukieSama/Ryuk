//
//  RYFlowPageModel.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYBaseConfig.h"
#import "RYComment.h"

@interface RYFlowPageModel : NSObject

/**
 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, assign) long long since_id;
/**
 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, assign) long long max_id;
/**
 list weibo 列表
 */
@property (nonatomic, strong) NSArray <RYStatuse *>*statuses;
/**
 list weibo 列表
 */
@property (nonatomic, strong) NSArray <RYComment *>*comments;
/**
 list weibo 列表
 */
@property (nonatomic, strong) NSArray <RYStatuse *>*reposts;

@end
