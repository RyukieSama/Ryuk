//
//  RYPrivacy.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYPrivacy : NSObject

/**
 是否可以评论我的微博，0：所有人、1：关注的人、2：可信用户
 */
@property (nonatomic, assign) NSInteger comment;
/**
 是否开启地理信息，0：不开启、1：开启
 */
@property (nonatomic, assign) NSInteger geo;
/**
 是否可以给我发私信，0：所有人、1：我关注的人、2：可信用户
 */
@property (nonatomic, assign) NSInteger message;
/**
 是否可以通过真名搜索到我，0：不可以、1：可以
 */
@property (nonatomic, assign) NSInteger realname;
/**
 勋章是否可见，0：不可见、1：可见
 */
@property (nonatomic, assign) NSInteger badge;
/**
 是否可以通过手机号码搜索到我，0：不可以、1：可以
 */
@property (nonatomic, assign) NSInteger mobile;
/**
 是否开启webim， 0：不开启、1：开启
 */
@property (nonatomic, assign) NSInteger webim;

@end

