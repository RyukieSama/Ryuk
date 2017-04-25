//
//  RYStatuse.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYBaseConfig.h"
#import "RYGeo.h"
#import "RYUser.h"
#import "RYPrivacy.h"
#import "RYRemind.h"
#import "RYURLShort.h"

@interface RYStatuse : NSObject

@property (nonatomic, assign) long long id;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;
@property (nonatomic, assign) long long mid;
@property (nonatomic, assign) NSInteger reposts_count;
@property (nonatomic, assign) NSInteger comments_count;
@property (nonatomic, assign) NSInteger attitudes_count;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *in_reply_to_status_id;
@property (nonatomic, copy) NSString *in_reply_to_user_id;
@property (nonatomic, copy) NSString *in_reply_to_screen_name;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, strong) RYGeo *geo;
@property (nonatomic, strong) RYUser *user;
//@property (nonatomic, strong) <#class#> *retweeted_status;  被转发的原微博
//@property (nonatomic, strong) <#class#> *visible;  微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
//@property (nonatomic, strong) <#class#> *pic_ids; 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
//pic_urls

@end
