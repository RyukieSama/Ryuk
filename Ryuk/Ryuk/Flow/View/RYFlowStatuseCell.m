//
//  RYFlowStatuseCell.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/26.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYFlowStatuseCell.h"
#import "RYStatuseReCommentView.h"

@interface RYFlowStatuseCell ()

@property (nonatomic, strong) UIButton *btCover;
@property (nonatomic, strong) UIButton *btAvatar;
@property (nonatomic, strong) UIButton *btFrom;
@property (nonatomic, strong) UIButton *btShowReComment;
@property (nonatomic, strong) UILabel *lbNickName;
@property (nonatomic, strong) UILabel *lbContent;
@property (nonatomic, strong) RYStatuseReCommentView *vReComment;

@end

@implementation RYFlowStatuseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //基础UI
     [self setupBaseUI];
    //根据cellId布局
    
    //纯文本
    if ([reuseIdentifier isEqualToString:RYStatuseCellIDText]) {
        [self setupUIRYStatuseCellIDText];
    }
    //单张至8张
    if ([reuseIdentifier isEqualToString:RYStatuseCellIDOne]) {
        [self setupUIRYStatuseCellIDOne];
    }
    //九宫格
    if ([reuseIdentifier isEqualToString:RYStatuseCellIDNine]) {
        [self setupUIRYStatuseCellIDNine];
    }
    //视频
    if ([reuseIdentifier isEqualToString:RYStatuseCellIDVideo]) {
        [self setupUIRYStatuseCellIDVideo];
    }

    return self;
}

#pragma mark - UI
- (void)setupBaseUI {
    self.backgroundColor = RY_COLOR_GRAY_E8E8E8;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setupUIRYStatuseCellIDText {
    //用户背景
    [self.contentView addSubview:self.btCover];
    [self.btCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(RY_UI_SCREEN_WID/2);
    }];
    
    //文本
    [self.contentView addSubview:self.lbContent];
    [self.lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(self.btCover.mas_bottom).offset(45);
        make.bottom.mas_equalTo(-8);
    }];
    
    //头像
    [self.contentView addSubview:self.btAvatar];
    [self.btAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.bottom.mas_equalTo(self.lbContent.mas_top).offset(-8);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    //昵称
    [self.contentView addSubview:self.lbNickName];
    [self.lbNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.btAvatar);
        make.left.mas_equalTo(self.btAvatar.mas_right).offset(8);
    }];
    
    //原po
    [self.contentView addSubview:self.btFrom];
    [self.btFrom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btAvatar);
        make.right.mas_equalTo(-8);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    //转发的文案
    [self.contentView addSubview:self.vReComment];
    [self.vReComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.btFrom.mas_top).offset(-4);
        make.width.mas_lessThanOrEqualTo(300);
        make.right.mas_equalTo(-30);
    }];
}

- (void)setupUIRYStatuseCellIDOne {
    [self setupUIRYStatuseCellIDText];
    [self.btCover mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(RY_UI_SCREEN_WID);
    }];
}

- (void)setupUIRYStatuseCellIDNine {
    [self setupUIRYStatuseCellIDOne];
}

- (void)setupUIRYStatuseCellIDVideo {
    [self setupUIRYStatuseCellIDText];
}

#pragma mark - data
- (void)setStatuse:(RYStatuse *)statuse {
    _statuse = statuse;
    
    //清封面
    [self.btCover setImage:RY_PLACEHOLDER_IMAGE forState:UIControlStateNormal];
    //公共部分
    if (statuse.retweeted_status) {//转发
        self.btFrom.hidden = NO;
        self.vReComment.hidden = NO;
        //大头像显示原po
        [self.btAvatar sd_setImageWithURL:[NSURL URLWithString:statuse.retweeted_status.user.avatar_large] forState:UIControlStateNormal placeholderImage:RY_AVATAR_IMAGE];
        //小头像显示转发者
        [self.btFrom sd_setImageWithURL:[NSURL URLWithString:statuse.user.avatar_large] forState:UIControlStateNormal placeholderImage:RY_AVATAR_IMAGE];
        //昵称显示原po
        [self.lbNickName setText:statuse.retweeted_status.user.screen_name];
        //原po内容
        [self.lbContent setText:statuse.retweeted_status.text];
        //转发文案
        [self.vReComment setText:statuse.text];
    } else {//原创
        self.btFrom.hidden = YES;
        self.vReComment.hidden = YES;
        //全部显示该用户的信息
        [self.btAvatar sd_setImageWithURL:[NSURL URLWithString:statuse.user.avatar_large] forState:UIControlStateNormal placeholderImage:RY_AVATAR_IMAGE];
        [self.lbNickName setText:statuse.user.screen_name];
        //原po内容
        [self.lbContent setText:statuse.text];
        //头像
        [self.btAvatar sd_setImageWithURL:[NSURL URLWithString:statuse.user.avatar_large] forState:UIControlStateNormal placeholderImage:RY_AVATAR_IMAGE];
    }
    
    //纯文本
    if ([statuse.cellID isEqualToString:RYStatuseCellIDText]) {
        [self setStatuseRYStatuseCellIDText:statuse];
    }
    //单张至8张
    if ([statuse.cellID isEqualToString:RYStatuseCellIDOne]) {
        [self setStatuseRYStatuseCellIDOne:statuse];
    }
    //九宫格
    if ([statuse.cellID isEqualToString:RYStatuseCellIDNine]) {
        [self setStatuseRYStatuseCellIDNine:statuse];
    }
    //视频
    if ([statuse.cellID isEqualToString:RYStatuseCellIDVideo]) {
        [self setStatuseRYStatuseCellIDVideo:statuse];
    }
}

- (void)setStatuseRYStatuseCellIDText:(RYStatuse *)statuse {
    [self.btCover sd_setImageWithURL:[NSURL URLWithString:statuse.user.cover_image] forState:UIControlStateNormal placeholderImage:RY_PLACEHOLDER_IMAGE];
}

- (void)setStatuseRYStatuseCellIDOne:(RYStatuse *)statuse {
    //原po
    if (statuse.retweeted_status) {//转发
        [self.btCover sd_setImageWithURL:[NSURL URLWithString:statuse.retweeted_status.original_pic] forState:UIControlStateNormal placeholderImage:RY_PLACEHOLDER_IMAGE];
    } else {//原创
        [self.btCover sd_setImageWithURL:[NSURL URLWithString:statuse.original_pic] forState:UIControlStateNormal placeholderImage:RY_PLACEHOLDER_IMAGE];
    }
}

- (void)setStatuseRYStatuseCellIDNine:(RYStatuse *)statuse {
    //原po
    if (statuse.retweeted_status) {//转发
        [self.btCover sd_setImageWithURL:[NSURL URLWithString:statuse.retweeted_status.original_pic] forState:UIControlStateNormal placeholderImage:RY_PLACEHOLDER_IMAGE];
    } else {//原创
        [self.btCover sd_setImageWithURL:[NSURL URLWithString:statuse.original_pic] forState:UIControlStateNormal placeholderImage:RY_PLACEHOLDER_IMAGE];
    }
}

- (void)setStatuseRYStatuseCellIDVideo:(RYStatuse *)statuse {
    [self.btCover sd_setImageWithURL:[NSURL URLWithString:statuse.user.cover_image] forState:UIControlStateNormal placeholderImage:RY_PLACEHOLDER_IMAGE];
}

#pragma mark - lazy
- (UIButton *)btCover {
    if (!_btCover) {
        _btCover = [[UIButton alloc] init];
        _btCover.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_btCover.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _btCover.imageView.layer.masksToBounds = YES;
        _btCover.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
        _btCover.layer.shadowOpacity = 0.5;   // 阴影透明度
        _btCover.layer.shadowOffset = CGSizeMake(0,3); // 阴影的范围
        _btCover.layer.shadowRadius = 3.0;  // 阴影扩散的范围控制
    }
    return _btCover;
}

- (UIButton *)btAvatar {
    if (!_btAvatar) {
        _btAvatar = [[UIButton alloc] init];
        _btAvatar.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btAvatar.imageView.layer.cornerRadius = 8;
        _btAvatar.imageView.layer.masksToBounds = YES;
        //阴影
        _btAvatar.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
        _btAvatar.layer.shadowOpacity = 0.5;   // 阴影透明度
        _btAvatar.layer.shadowOffset = CGSizeMake(0,2); // 阴影的范围
        _btAvatar.layer.shadowRadius = 2.0;  // 阴影扩散的范围控制
    }
    return _btAvatar;
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

- (UIButton *)btFrom {
    if (!_btFrom) {
        _btFrom = [[UIButton alloc] init];
        _btFrom.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btFrom.imageView.layer.cornerRadius = 8;
        _btFrom.imageView.layer.masksToBounds = YES;
        //阴影
        _btFrom.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
        _btFrom.layer.shadowOpacity = 0.5;   // 阴影透明度
        _btFrom.layer.shadowOffset = CGSizeMake(0,2); // 阴影的范围
        _btFrom.layer.shadowRadius = 2.0;  // 阴影扩散的范围控制
    }
    return _btFrom;
}

- (RYStatuseReCommentView *)vReComment {
    if (!_vReComment) {
        _vReComment = [[RYStatuseReCommentView alloc] init];
    }
    return _vReComment;
}

@end
