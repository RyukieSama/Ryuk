//
//  RYAvatarView.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/3.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYAvatarView.h"

@interface RYAvatarView ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy) dcCallBack callBack;
@property (nonatomic, copy) dcCallBack callBackOne;

@end

@implementation RYAvatarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addGestureRecognizers];
    return self;
}

- (void)ryAV_doubleClick:(dcCallBack)dcClick {
    self.callBack = dcClick;
}

- (void)ryAV_oneClick:(dcCallBack)dcClick {
    self.callBackOne = dcClick;
}

- (void)jumpToUserCenter {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - Gesture recognizers
- (void)addGestureRecognizers {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapping:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapping:)];
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImageWithLongPress)];
    
    [doubleTap setNumberOfTapsRequired:2.0];
    [singleTap requireGestureRecognizerToFail:doubleTap];
//    [longPress setMinimumPressDuration:0.5];
    
    [singleTap setDelegate:self];
    [doubleTap setDelegate:self];
//    [longPress setDelegate:self];
    
    [self addGestureRecognizer:singleTap];
    [self addGestureRecognizer:doubleTap];
//    [self addGestureRecognizer:longPress];
}

#pragma mark - Gesture recognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

#pragma mark - Handle tappings
- (void)handleTapping:(UITapGestureRecognizer *)recognizer {
    if (recognizer.numberOfTapsRequired == 2) {
        if (self.callBack) {
            self.callBack();
        }
    } else if(recognizer.numberOfTapsRequired == 1) {
        if (self.callBackOne) {
            self.callBackOne();
        } else {
            //默认跳用户个人中心
            [self jumpToUserCenter];
        }
    }
}

@end
