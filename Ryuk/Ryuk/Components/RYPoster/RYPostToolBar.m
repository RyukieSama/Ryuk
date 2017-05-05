//
//  RYPostToolBar.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/5.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYPostToolBar.h"
#import "RYBaseConfig.h"

#define BUTTON_WID (38/3*2)

@interface RYPostToolBar ()

@property (nonatomic, strong) UIButton *btAlbum;
@property (nonatomic, strong) UIButton *btEmoji;
@property (nonatomic, strong) UIButton *btAt;
@property (nonatomic, strong) UIButton *btTopic;
@property (nonatomic, strong) UIButton *btLocation;
@property (nonatomic, strong) UIButton *btKeyboard;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation RYPostToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}

- (void)setIsKetboardShowed:(BOOL)isKetboardShowed {
    _isKetboardShowed = isKetboardShowed;
    if (isKetboardShowed) {
        [self.btKeyboard setImage:[UIImage imageNamed:@"ios7-arrow-down"] forState:UIControlStateNormal];
    } else {
        [self.btKeyboard setImage:[UIImage imageNamed:@"ios7-arrow-up"] forState:UIControlStateNormal];
    }
}

#pragma mark - action
- (void)keyboardClick {
    if ([self.delegate respondsToSelector:@selector(postToolBarKeyboardClick)]) {
        [self.delegate postToolBarKeyboardClick];
    }
}

- (void)albumClick {
    if ([self.delegate respondsToSelector:@selector(postToolBarAlbumClick)]) {
        [self.delegate postToolBarAlbumClick];
    }
}

- (void)atClick {
    if ([self.delegate respondsToSelector:@selector(postToolBarAtClick)]) {
        [self.delegate postToolBarAtClick];
    }
}

- (void)topicClick {
    if ([self.delegate respondsToSelector:@selector(postToolBarTopicClick)]) {
        [self.delegate postToolBarTopicClick];
    }
}

- (void)emojiClick {
    if ([self.delegate respondsToSelector:@selector(postToolBarEmojiClick)]) {
        [self.delegate postToolBarEmojiClick];
    }
}

- (void)loactionClick {
    if ([self.delegate respondsToSelector:@selector(postToolBarLocationClick)]) {
        [self.delegate postToolBarLocationClick];
    }
}

#pragma mark - UI
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.vLine];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(RY_HEIGHT_LINE);
    }];
        
    //键盘控制
    [self addSubview:self.btKeyboard];
    [self.btKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(BUTTON_WID*23/38);
        make.width.mas_equalTo(BUTTON_WID);
    }];
    
    //相册
    [self addSubview:self.btAlbum];
    [self.btAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(BUTTON_WID);
        make.height.mas_equalTo(BUTTON_WID);
    }];
    
    //@
    [self addSubview:self.btAt];
    [self.btAt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btAlbum.mas_right).offset(12);
        make.centerY.mas_equalTo(self.btAlbum);
        make.width.mas_equalTo(BUTTON_WID);
        make.height.mas_equalTo(BUTTON_WID*96/90);
    }];
    
    //topic
    [self addSubview:self.btTopic];
    [self.btTopic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btAt.mas_right).offset(12);
        make.centerY.mas_equalTo(self.btAlbum);
        make.width.mas_equalTo(BUTTON_WID);
        make.height.mas_equalTo(BUTTON_WID);
    }];
    
    //emoji
    [self addSubview:self.btEmoji];
    [self.btEmoji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btTopic.mas_right).offset(12);
        make.centerY.mas_equalTo(self.btAlbum);
        make.width.mas_equalTo(BUTTON_WID);
        make.height.mas_equalTo(BUTTON_WID);
    }];
    
    //location
    [self addSubview:self.btLocation];
    [self.btLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btEmoji.mas_right).offset(12);
        make.centerY.mas_equalTo(self.btAlbum);
        make.width.mas_equalTo(BUTTON_WID);
        make.height.mas_equalTo(BUTTON_WID);
    }];
}

#pragma mark - lazy
- (UIButton *)btKeyboard {
    if (!_btKeyboard) {
        _btKeyboard = [[UIButton alloc] init];
        [_btKeyboard setImage:[UIImage imageNamed:@"ios7-arrow-up"] forState:UIControlStateNormal];
        [_btKeyboard addTarget:self action:@selector(keyboardClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btKeyboard;
}

- (UIView *)vLine {
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = RY_COLOR_GRAY_E8E8E8;
    }
    return _vLine;
}

- (UIButton *)btAlbum {
    if (!_btAlbum) {
        _btAlbum = [[UIButton alloc] init];
        [_btAlbum setImage:[UIImage imageNamed:@"ios7-analytics"] forState:UIControlStateNormal];
        [_btAlbum addTarget:self action:@selector(albumClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btAlbum;
}

- (UIButton *)btAt {
    if (!_btAt) {
        _btAt = [[UIButton alloc] init];
        [_btAt setImage:[UIImage imageNamed:@"ios7-at"] forState:UIControlStateNormal];
        [_btAt addTarget:self action:@selector(atClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btAt;
}

- (UIButton *)btEmoji {
    if (!_btEmoji) {
        _btEmoji = [[UIButton alloc] init];
        [_btEmoji setImage:[UIImage imageNamed:@"Emoji"] forState:UIControlStateNormal];
        [_btEmoji addTarget:self action:@selector(emojiClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btEmoji;
}

- (UIButton *)btTopic {
    if (!_btTopic) {
        _btTopic = [[UIButton alloc] init];
        [_btTopic setImage:[UIImage imageNamed:@"Topic"] forState:UIControlStateNormal];
        [_btTopic addTarget:self action:@selector(topicClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btTopic;
}

- (UIButton *)btLocation {
    if (!_btLocation) {
        _btLocation = [[UIButton alloc] init];
        [_btLocation setImage:[UIImage imageNamed:@"ios7-navigate"] forState:UIControlStateNormal];
        [_btLocation addTarget:self action:@selector(loactionClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btLocation;
}

@end
