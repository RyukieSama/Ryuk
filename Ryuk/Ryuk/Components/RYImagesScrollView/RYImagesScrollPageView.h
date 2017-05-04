//
//  RYImagesScrollPageView.h
//  Ryuk
//
//  Created by RongqingWang on 2017/4/11.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYImagesScrollPageView : UIView

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithNormalImage:(UIImage *)normalImage currentImage:(UIImage *)currentImage itemSpace:(CGFloat)itemSpace frame:(CGRect)frame;

@end
