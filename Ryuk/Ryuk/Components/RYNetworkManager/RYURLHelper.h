//
//  RYURLHelper.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/27.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYNetworkManager.h"

typedef void(^slCallBack)(id data);

@interface RYURLHelper : NSObject

+ (void)getLongURLWith:(NSString *)shortURL callBack:(slCallBack)callBack;

@end
