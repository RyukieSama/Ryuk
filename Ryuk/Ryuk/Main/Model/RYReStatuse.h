//
//  RYReStatuse.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/26.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYGeo.h"
#import "RYUser.h"
#import "RYPrivacy.h"
#import "RYRemind.h"
#import "RYURLShort.h"
#import "RYImage.h"

@interface RYReStatuse : NSObject

@property (nonatomic, assign) long long id;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;
@property (nonatomic, assign) long long mid;
@property (nonatomic, assign) NSInteger reposts_count;
@property (nonatomic, assign) NSInteger comments_count;
@property (nonatomic, assign) NSInteger attitudes_count;
/**
 链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
 */
@property (nonatomic, assign) NSInteger source_type;
@property (nonatomic, copy) NSString *created_at;
/**
 微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 微博来源
 */
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *in_reply_to_status_id;
@property (nonatomic, copy) NSString *in_reply_to_user_id;
@property (nonatomic, copy) NSString *in_reply_to_screen_name;
/**
 缩略图片地址，没有时不返回此字段
 */
@property (nonatomic, copy) NSString *thumbnail_pic;
/**
 中等尺寸图片地址，没有时不返回此字段
 */
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, strong) RYGeo *geo;
@property (nonatomic, strong) RYUser *user;
@property (nonatomic, strong) NSArray <RYImage *>*pic_urls;
@property (nonatomic, strong) NSArray <NSString *>*pic_urls_strings;

@end
