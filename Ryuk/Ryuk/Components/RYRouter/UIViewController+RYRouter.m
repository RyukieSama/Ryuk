//
//  UIViewController+RYRouter.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/8.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "UIViewController+RYRouter.h"
#import "objc/runtime.h"

@implementation UIViewController (RYRouter)

#pragma mark 属性关联

- (void)setParams:(id)params {
    objc_setAssociatedObject(self, @"params", params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)params {
    return objc_getAssociatedObject(self, @"params");
}

- (void)setCompleteBlock:(completeBlock)completeBlock {
    objc_setAssociatedObject(self, @"completeBlock", completeBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (completeBlock)completeBlock {
    return objc_getAssociatedObject(self, @"completeBlock");
}

@end
