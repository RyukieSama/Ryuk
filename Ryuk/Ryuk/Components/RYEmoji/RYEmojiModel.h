//
//  RYEmojiModel.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/12.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>

//"category": "休闲",
//"common": true,
//"hot": false,
//"icon": "http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/eb/smile.gif",
//"phrase": "[呵呵]",
//"picid": null,
//"type": "face",
//"url": "http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/eb/smile.gif",
//"value": "[呵呵]"

@interface RYEmojiModel : NSObject

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *phrase;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) long long picid;
@property (nonatomic, assign) BOOL common;
@property (nonatomic, assign) BOOL hot;

@end
