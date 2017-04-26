//
//  RYFlowStatuseCell.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/26.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYFlowStatuseCell.h"

@interface RYFlowStatuseCell ()

@property (nonatomic, strong) UIImageView *ivCover;
@property (nonatomic, strong) UIImageView *ivAvatar;
@property (nonatomic, strong) UILabel *lbNickName;
@property (nonatomic, strong) UILabel *lbContent;


@end

@implementation RYFlowStatuseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI {
    self.backgroundColor = RY_COLOR_GRAY_E8E8E8;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //图片
    [self.contentView addSubview:self.ivCover];
    [self.ivCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(300);
    }];
    
    //文本
    [self.contentView addSubview:self.lbContent];
    [self.lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(self.ivCover.mas_bottom).offset(45);
        make.bottom.mas_equalTo(-8);
    }];
    
    //头像
    [self.contentView addSubview:self.ivAvatar];
    [self.ivAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.bottom.mas_equalTo(self.lbContent.mas_top).offset(-8);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    //昵称
    [self.contentView addSubview:self.lbNickName];
    [self.lbNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.ivAvatar);
        make.left.mas_equalTo(self.ivAvatar.mas_right).offset(8);
    }];
    
}

- (void)setStatuse:(RYStatuse *)statuse {
    _statuse = statuse;
    [self.ivCover sd_setImageWithURL:[NSURL URLWithString:statuse.original_pic] placeholderImage:RY_PLACEHOLDER_IMAGE];
    [self.ivAvatar sd_setImageWithURL:[NSURL URLWithString:statuse.user.avatar_large] placeholderImage:RY_AVATAR_IMAGE];
    [self.lbContent setText:statuse.text];
    [self.lbNickName setText:statuse.user.screen_name];
}

#pragma mark - lazy
- (UIImageView *)ivCover {
    if (!_ivCover) {
        _ivCover = [[UIImageView alloc] init];
        _ivCover.contentMode = UIViewContentModeScaleAspectFill;
        _ivCover.layer.masksToBounds = YES;
//        _ivCover.backgroundColor = RY_COLOR_GRAY_E8E8E8;
//        _ivCover.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
//        _ivCover.layer.shadowOpacity = 0.8;   // 阴影透明度
//        _ivCover.layer.shadowOffset = CGSizeMake(0,2); // 阴影的范围
//        _ivCover.layer.shadowRadius = 5.0;  // 阴影扩散的范围控制
    }
    return _ivCover;
}

- (UIImageView *)ivAvatar {
    if (!_ivAvatar) {
        _ivAvatar = [[UIImageView alloc] init];
        _ivAvatar.contentMode = UIViewContentModeScaleAspectFit;
        //阴影
        _ivAvatar.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
        _ivAvatar.layer.shadowOpacity = 0.8;   // 阴影透明度
        _ivAvatar.layer.shadowOffset = CGSizeMake(-2,2); // 阴影的范围
        _ivAvatar.layer.shadowRadius = 2.0;  // 阴影扩散的范围控制
    }
    return _ivAvatar;
}

- (UILabel *)lbContent {
    if (!_lbContent) {
        _lbContent = [[UILabel alloc] init];
        _lbContent.font = RY_FONT(15);
        _lbContent.numberOfLines = 0;
    }
    return _lbContent;
}

- (UILabel *)lbNickName {
    if (!_lbNickName) {
        _lbNickName = [[UILabel alloc] init];
        _lbNickName.font = RY_FONT(18);
    }
    return _lbNickName;
}

@end
