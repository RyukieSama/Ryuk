//
//  RYCommentBar.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/10.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYCommentBar.h"
#import "RYBaseConfig.h"

#define BUTTON_WID (38/3*2)
#define KEYBOARD_OFFSET 515/2
#define TEXTVIEW_HEIGHT 35
#define TOTAL_HEIGHT 80
#define O_FRAME CGRectMake(0, RY_UI_SCREEN_HEIGHT - TOTAL_HEIGHT - 60, RY_UI_SCREEN_WID, TOTAL_HEIGHT)
#define I_FRAME CGRectMake(0, RY_UI_SCREEN_HEIGHT - TOTAL_HEIGHT - 60 - KEYBOARD_OFFSET, RY_UI_SCREEN_WID, TOTAL_HEIGHT)

#define API_GIVE_COMMENT @"https://api.weibo.com/2/comments/create.json"

@interface RYCommentBar ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIButton *btEmoji;
@property (nonatomic, strong) UIButton *btAt;
@property (nonatomic, strong) UIButton *btTopic;
@property (nonatomic, strong) UIButton *btSent;
@property (nonatomic, strong) UITextView *tvText;

@end

@implementation RYCommentBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:O_FRAME];
    [self setupUI];
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tvText];
    [self addSubview:self.vLine];
    
    //@
    [self addSubview:self.btAt];
    [self.btAt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(4);
        make.centerY.mas_equalTo(20);
        make.width.mas_equalTo(BUTTON_WID);
        make.height.mas_equalTo(BUTTON_WID*96/90);
    }];
    
    //topic
    [self addSubview:self.btTopic];
    [self.btTopic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btAt.mas_right).offset(12);
        make.centerY.mas_equalTo(self.btAt);
        make.width.mas_equalTo(BUTTON_WID);
        make.height.mas_equalTo(BUTTON_WID);
    }];
    
    //emoji
    [self addSubview:self.btEmoji];
    [self.btEmoji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btTopic.mas_right).offset(12);
        make.centerY.mas_equalTo(self.btAt);
        make.width.mas_equalTo(BUTTON_WID);
        make.height.mas_equalTo(BUTTON_WID);
    }];
    
    //发送
    [self addSubview:self.btSent];
    [self.btSent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btAt);
        make.right.mas_equalTo(-4);
        make.height.mas_equalTo(BUTTON_WID);
        make.width.mas_equalTo(40);
    }];
}

#pragma mark - data
- (void)commentStatuse {
    NSDictionary *dic = @{
                          @"comment" : self.tvText.text,
                          @"id" : @(self.id),
                          @"comment_ori" : @(0) //当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0。
                          };
    __weak typeof(self) weakSelf = self;
    [RYNetworkManager ry_postWithUrl:API_GIVE_COMMENT
                   requestDictionary:dic
                       responseModel:nil
                            useCache:NO
                   completionHandler:^(id data) {
                       if (data) {
                           weakSelf.tvText.text = @"";
                           [weakSelf endEdit];
                           [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_COMMENT_SUCCESS object:nil userInfo:nil];
                       }
                   }];
}

- (void)commentComment {
    
}

#pragma mark - function
- (void)atClick {
//    if ([self.delegate respondsToSelector:@selector(postToolBarAtClick)]) {
//        [self.delegate postToolBarAtClick];
//    }
}

- (void)topicClick {
//    if ([self.delegate respondsToSelector:@selector(postToolBarTopicClick)]) {
//        [self.delegate postToolBarTopicClick];
//    }
}

- (void)emojiClick {
//    if ([self.delegate respondsToSelector:@selector(postToolBarEmojiClick)]) {
//        [self.delegate postToolBarEmojiClick];
//    }
}

- (void)sendClick {
    if (self.tvText.text == 0 || self.tvText.text.length > 140) {
        NSLog(@"长度不对");
    } else {
        [self commentStatuse];
    }
}

- (void)kSHow {
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = I_FRAME;
    }];
}

- (void)kHide {
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = O_FRAME;
    }];
}

- (void)endEdit {
    [self.tvText endEditing:YES];
}

- (void)startEdit {
    [self.tvText becomeFirstResponder];
}

#pragma mark - textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self kSHow];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [self kHide];
    return YES;
}


#pragma mark - lazy
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

- (UITextView *)tvText {
    if (!_tvText) {
        _tvText = [[UITextView alloc] initWithFrame:CGRectMake(4, 4, RY_UI_SCREEN_WID - 8, TEXTVIEW_HEIGHT)];
        _tvText.font = RY_FONT(16);
        _tvText.textColor = [UIColor blackColor];
        _tvText.scrollEnabled = YES;
        _tvText.delegate = self;
        _tvText.layer.borderColor = [UIColor blackColor].CGColor;
        _tvText.layer.borderWidth = RY_HEIGHT_LINE;
        _tvText.layer.cornerRadius = RY_DETAULT_CORNER_R;
        _tvText.layer.masksToBounds = YES;
    }
    return _tvText;
}

- (UIView *)vLine {
    if (!_vLine) {
        _vLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RY_UI_SCREEN_WID, RY_HEIGHT_LINE)];
        _vLine.backgroundColor = RY_COLOR_GRAY_E8E8E8;
    }
    return _vLine;
}

- (UIButton *)btSent {
    if (!_btSent) {
        _btSent = [[UIButton alloc] init];
        _btSent.layer.borderColor = [UIColor blackColor].CGColor;
        _btSent.layer.borderWidth = RY_HEIGHT_LINE;
        _btSent.layer.cornerRadius = RY_DETAULT_CORNER_R;
        _btSent.layer.masksToBounds = YES;
        [_btSent addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        [_btSent setBackgroundColor:[UIColor whiteColor]];
        [_btSent setTitle:@"发送" forState:UIControlStateNormal];
        [_btSent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btSent.titleLabel setFont:RY_FONT(15)];
        [_btSent.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _btSent;
}

@end
