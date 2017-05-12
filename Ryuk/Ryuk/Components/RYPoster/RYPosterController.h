//
//  RYPosterController.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/5.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYBaseConfig.h"

@interface RYPosterController : UIViewController

@property (nonatomic, strong) RYTextView *tvText;

- (void)setupUI;

- (void)post;

- (void)dismiss;

@end
