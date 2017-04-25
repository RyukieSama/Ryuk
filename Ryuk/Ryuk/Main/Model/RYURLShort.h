//
//  RYURLShort.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYURLShort : NSObject

@property (nonatomic, copy) NSString *url_short;
@property (nonatomic, copy) NSString *url_long;
/**
 	链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
 */
@property (nonatomic, assign) NSInteger type;
/**
 短链的可用状态，true：可用、false：不可用。
 */
@property (nonatomic, assign) BOOL result;

@end


//url_short	string	短链接
//url_long	string	原始长链接
//type	int	链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
//result	boolean	短链的可用状态，true：可用、false：不可用。
