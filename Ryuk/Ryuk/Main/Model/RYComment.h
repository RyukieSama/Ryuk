//
//  RYComment.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/25.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYUser.h"
#import "RYStatuse.h"

@interface RYComment : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, strong) RYUser *user;
@property (nonatomic, strong) RYStatuse *status;
//@property (nonatomic, strong) <#class#> *reply_comment;

@end
