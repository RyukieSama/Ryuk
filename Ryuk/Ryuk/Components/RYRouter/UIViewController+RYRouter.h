//
//  UIViewController+RYRouter.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/8.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^completeBlock)(id data);

@interface UIViewController (RYRouter)

@property (nonatomic, strong) id params;
@property (nonatomic, copy) completeBlock completeBlock;

@end
