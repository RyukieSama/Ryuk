//
//  RYCommentBar.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/10.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYCommentBar : UIView

@property (nonatomic, assign) long long id;

- (void)endEdit;
- (void)startEdit;

#define NOTI_COMMENT_SUCCESS @"NOTI_COMMENT_SUCCESS"

@end
