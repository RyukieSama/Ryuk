//
//  RYBaseConfig.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RYMainTabBarController.h"
#import "RYBaseNavigationController.h"

#pragma mark - UI
#define RY_UI_SCREEN_WID [RYBaseConfig screenWid]
#define RY_UI_SCREEN_RECT [RYBaseConfig screenRect]

#pragma mark -

@interface RYBaseConfig : NSObject
    
+ (CGFloat)screenWid;
    
+ (CGRect)screenRect;
    
@end
