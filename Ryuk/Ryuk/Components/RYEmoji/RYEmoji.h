//
//  RYEmoji.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/12.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYEmojiModel.h"

typedef void(^emojiCallBack)(NSArray <RYEmojiModel *>*emojis);

@interface RYEmoji : NSObject

//face：普通表情、ani：魔法表情、cartoon：动漫表情，默认为face。

+ (instancetype)sharedInstance;

/**
 获取普通表情
 */
+ (void)getEmojisFace:(emojiCallBack)callBack;

/**
 获取魔法表情
 */
+ (void)getEmojisAni:(emojiCallBack)callBack;

/**
 获取动漫表情
 */
+ (void)getEmojisCartoon:(emojiCallBack)callBack;

@end
