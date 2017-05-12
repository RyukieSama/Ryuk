//
//  RYStatuseCommentCell.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/9.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYStatuseCommentCell.h"
#import "RYBaseConfig.h"

@interface RYStatuseCommentCell ()

@property (nonatomic, strong) UIButton *btAvatar;
@property (nonatomic, strong) UILabel *lbName;
@property (nonatomic, strong) RYLabel *lbText;
@property (nonatomic, strong) UIButton *btImage;

@end

@implementation RYStatuseCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI {
    //头像
    [self.contentView addSubview:self.btAvatar];
    [self.btAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(12);
        make.width.height.mas_equalTo(40);
    }];
    //昵称
    [self.contentView addSubview:self.lbName];
    [self.lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btAvatar.mas_top);
        make.left.mas_equalTo(self.btAvatar.mas_right).offset(8);
        make.right.mas_equalTo(-12);
    }];
    //文本
    [self.contentView addSubview:self.lbText];
    [self.lbText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lbName);
        make.top.mas_equalTo(self.lbName.mas_bottom).offset(4);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-12);
    }];
    
    //配图
    
}

#pragma mark - data
- (void)setComment:(RYComment *)comment {
    _comment = comment;
    [self.btAvatar sd_setImageWithURL:[NSURL URLWithString:comment.user.avatar_large] forState:UIControlStateNormal placeholderImage:RY_AVATAR_IMAGE];
    [self.lbName setText:comment.user.name];
    [self.lbText setText:comment.text];
}

- (void)setRepost:(RYStatuse *)repost {
    _repost = repost;
    [self.btAvatar sd_setImageWithURL:[NSURL URLWithString:repost.user.avatar_large] forState:UIControlStateNormal placeholderImage:RY_AVATAR_IMAGE];
    [self.lbName setText:repost.user.name];
    [self.lbText setText:repost.text];
}

#pragma mark - function
- (void)avClick {
    
}

- (void)imgClick {
    
}

#pragma mark - lazy
- (UIButton *)btAvatar {
    if (!_btAvatar) {
        _btAvatar = [[UIButton alloc] init];
        _btAvatar.layer.cornerRadius = RY_DETAULT_CORNER_R;
        _btAvatar.layer.masksToBounds = YES;
        [_btAvatar addTarget:self action:@selector(avClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btAvatar;
}

- (UIButton *)btImage {
    if (!_btImage) {
        _btImage = [[UIButton alloc] init];
        _btImage.layer.cornerRadius = RY_DETAULT_CORNER_R;
        _btImage.layer.masksToBounds = YES;
        [_btImage addTarget:self action:@selector(imgClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btImage;
}

- (UILabel *)lbName {
    if (!_lbName) {
        _lbName = [[UILabel alloc] init];
        _lbName.font = RY_FONT(16);
        _lbName.textColor = [UIColor blackColor];
    }
    return _lbName;
}

- (RYLabel *)lbText {
    if (!_lbText) {
        _lbText = [[RYLabel alloc] init];
        _lbText.font = RY_FONT(14);
        _lbText.textColor = [UIColor blackColor];
        _lbText.numberOfLines = 0;
    }
    return _lbText;
}

@end
