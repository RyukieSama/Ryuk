//
//  RYUser.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYUser : NSObject

@property (nonatomic, assign) long long id;
/**
 是否允许所有人给我发私信，true：是，false：否
 */
@property (nonatomic, assign) BOOL allow_all_act_msg;
/**
 是否允许标识用户的地理位置，true：是，false：否
 */
@property (nonatomic, assign) BOOL geo_enabled;
/**
 是否是微博认证用户，即加V用户，true：是，false：否
 */
@property (nonatomic, assign) BOOL verified;
/**
 是否允许所有人对我的微博进行评论，true：是，false：否
 */
@property (nonatomic, assign) BOOL allow_all_comment;
@property (nonatomic, assign) BOOL follow_me;
/**
 用户的在线状态，0：不在线、1：在线
 */
@property (nonatomic, assign) NSInteger online_status;
@property (nonatomic, assign) NSInteger verified_type;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, assign) NSInteger followers_count;
@property (nonatomic, assign) NSInteger friends_count;
@property (nonatomic, assign) NSInteger statuses_count;
@property (nonatomic, assign) NSInteger favourites_count;
/**
 用户的互粉数
 */
@property (nonatomic, assign) NSInteger bi_followers_count;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *description_wb;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, copy) NSString *profile_url;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *weihao;
/**
 性别，m：男、f：女、n：未知
 */
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *created_at;
/**
 用户备注信息，只有在查询用户关系时才返回此字段
 */
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *avatar_hd;
@property (nonatomic, copy) NSString *verified_reason;
/**
 用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
 */
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *cover_image;
@property (nonatomic, copy) NSString *cover_image_phone;
//@property (nonatomic, strong) RYStatuse *status;

@end
