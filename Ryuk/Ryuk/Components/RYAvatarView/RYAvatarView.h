//
//  RYAvatarView.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/3.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dcCallBack)();

@interface RYAvatarView : UIButton

/**
 双击的回调
 */
- (void)ryAV_doubleClick:(dcCallBack)dcClick;

- (void)ryAV_oneClick:(dcCallBack)dcClick;

@end
