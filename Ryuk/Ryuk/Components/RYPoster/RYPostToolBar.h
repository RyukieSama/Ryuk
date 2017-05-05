//
//  RYPostToolBar.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/5.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RYPostToolBarDelegate <NSObject>

- (void)postToolBarKeyboardClick;
- (void)postToolBarAlbumClick;
- (void)postToolBarAtClick;
- (void)postToolBarTopicClick;
- (void)postToolBarEmojiClick;
- (void)postToolBarLocationClick;

@end

@interface RYPostToolBar : UIView

@property (nonatomic, weak) id<RYPostToolBarDelegate> delegate;
@property (nonatomic, assign) BOOL isKetboardShowed;

@end
