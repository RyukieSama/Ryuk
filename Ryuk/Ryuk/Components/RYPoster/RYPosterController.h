//
//  RYPosterController.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/5.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYPosterController : UIViewController

@property (nonatomic, strong) UITextView *tvText;

- (void)setupUI;

- (void)post;

- (void)dismiss;

@end
