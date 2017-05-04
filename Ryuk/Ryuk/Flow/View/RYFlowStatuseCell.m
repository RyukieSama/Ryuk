//
//  RYFlowStatuseCell.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/26.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYFlowStatuseCell.h"
#import "RYStatuseReCommentView.h"
#import "RYImagesScrollView.h"

@interface RYFlowStatuseCell ()

@property (nonatomic, strong) RYImagesScrollView *vCover;
@property (nonatomic, strong) RYAvatarView *btAvatar;
@property (nonatomic, strong) RYAvatarView *btFrom;
@property (nonatomic, strong) UIButton *btShowReComment;
@property (nonatomic, strong) UIButton *btLike;//赞
@property (nonatomic, strong) UIButton *btRe;//转发
@property (nonatomic, strong) UIButton *btComment;//评论
@property (nonatomic, strong) UIButton *btFavo;//收藏
@property (nonatomic, strong) UIImageView *ivBack;
@property (nonatomic, strong) UILabel *lbNickName;
@property (nonatomic, strong) UILabel *lbContent;
@property (nonatomic, strong) UIView *vLine;
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
    [self.contentView addSubview:self.ivBack];
    [self.ivBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(160);
    }];
    //用户背景
    [self.contentView addSubview:self.vCover];
    [self.vCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(160);
    }];
    
    //line
    [self.contentView addSubview:self.vLine];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.vCover.mas_bottom);
        make.width.mas_equalTo(RY_UI_SCREEN_WID);
    }];
    
    //文本
    [self.contentView addSubview:self.lbContent];
    [self.lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(self.vCover.mas_bottom).offset(45);
    }];
    
    //赞
    [self.contentView addSubview:self.btLike];
    [self.btLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lbContent);
        make.top.mas_equalTo(self.lbContent.mas_bottom).offset(8);
        make.bottom.mas_equalTo(-8);
    }];
    
    //转发
    [self.contentView addSubview:self.btRe];
    [self.btRe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btLike);
        make.left.mas_equalTo(self.btLike.mas_right).offset(4);
    }];
    
    //评论
    [self.contentView addSubview:self.btComment];
    [self.btComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btLike);
        make.left.mas_equalTo(self.btRe.mas_right).offset(4);
    }];
    
    //收藏
    [self.contentView addSubview:self.btFavo];
    [self.btFavo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btLike);
        make.right.mas_equalTo(-8);
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
        make.bottom.mas_equalTo(self.btFrom.mas_top).offset(4);
        make.width.mas_lessThanOrEqualTo(300);
        make.right.mas_equalTo(-20);
    }];
}

- (void)setupUIRYStatuseCellIDOne {
    [self setupUIRYStatuseCellIDText];
    [self.vCover mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(RY_UI_SCREEN_WID);
    }];
    [self.ivBack mas_remakeConstraints:^(MASConstraintMaker *make) {
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
//    [self.vCover setImage:RY_COVER_IMAGE forState:UIControlStateNormal];
//    self.vCover.imageURLs = @[RY_COVER_IMAGE];
//    self.vCover.currentIndex = 0;
    //公共部分
    if (statuse.retweeted_status) {//转发
        self.btFrom.hidden = NO;
        self.vReComment.hidden = statuse.hideRe;
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
    
    self.vCover.scrollToPage = statuse.currentPage;
}

- (void)setStatuseRYStatuseCellIDText:(RYStatuse *)statuse {
    self.vCover.hidden = YES;
//    [self.vCover sd_setImageWithURL:[NSURL URLWithString:statuse.user.cover_image] forState:UIControlStateNormal placeholderImage:RY_COVER_IMAGE];
    [self.ivBack sd_setImageWithURL:[NSURL URLWithString:statuse.user.avatar_large] placeholderImage:RY_COVER_IMAGE];
}

- (void)setStatuseRYStatuseCellIDOne:(RYStatuse *)statuse {
    //原po
    if (statuse.retweeted_status) {//转发
        self.vCover.imageURLs = statuse.retweeted_status.pic_urls_strings;
        [self.ivBack sd_setImageWithURL:[NSURL URLWithString:statuse.retweeted_status.bmiddle_pic] placeholderImage:RY_COVER_IMAGE];
    } else {//原创
        self.vCover.imageURLs = statuse.pic_urls_strings;
        [self.ivBack sd_setImageWithURL:[NSURL URLWithString:statuse.bmiddle_pic] placeholderImage:RY_COVER_IMAGE];
    }
}

- (void)setStatuseRYStatuseCellIDNine:(RYStatuse *)statuse {
    //原po
    if (statuse.retweeted_status) {//转发
        self.vCover.imageURLs = statuse.retweeted_status.pic_urls_strings;
        [self.ivBack sd_setImageWithURL:[NSURL URLWithString:statuse.retweeted_status.bmiddle_pic] placeholderImage:RY_COVER_IMAGE];
    } else {//原创
        self.vCover.imageURLs = statuse.pic_urls_strings;
        [self.ivBack sd_setImageWithURL:[NSURL URLWithString:statuse.bmiddle_pic] placeholderImage:RY_COVER_IMAGE];
    }
}

- (void)setStatuseRYStatuseCellIDVideo:(RYStatuse *)statuse {
    self.vCover.imageURLs = @[statuse.user.cover_image];
}

#pragma mark - action
- (void)likeClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)reClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)commentClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)favoClick {
    NSLog(@"%s",__FUNCTION__);
}

- (void)reHideClick {
    NSLog(@"%s",__FUNCTION__);
    self.statuse.hideRe = !self.statuse.hideRe;
    self.statuse = self.statuse;//手动set
}

#pragma mark - lazy
- (RYImagesScrollView *)vCover {
    if (!_vCover) {
        
        _vCover = [[RYImagesScrollView alloc] initWithFrame:CGRectZero pageStyle:RYImageScrollerPageStyleNormal];
        _vCover.autoScrollTimeInterval = 0;
        _vCover.contentMode = UIViewContentModeScaleAspectFit;
        __weak typeof(self) weakSelf = self;
        _vCover.handler_scrollCallBack = ^(NSNumber *obj) {
            weakSelf.statuse.currentPage = [obj integerValue];
        };
//        _vCover.normalPageImage = [UIImage imageNamed:@"outdoor_icon_carousel"];
//        _vCover.currentPageImage = [UIImage imageNamed:@"outdoor_icon_carousel_selected"];
    }
    return _vCover;
}

- (RYAvatarView *)btAvatar {
    if (!_btAvatar) {
        _btAvatar = [[RYAvatarView alloc] init];
        _btAvatar.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btAvatar.imageView.layer.cornerRadius = 8;
        _btAvatar.imageView.layer.masksToBounds = YES;
        //阴影
        _btAvatar.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
        _btAvatar.layer.shadowOpacity = 0.5;   // 阴影透明度
        _btAvatar.layer.shadowOffset = CGSizeMake(-2,2); // 阴影的范围
        _btAvatar.layer.shadowRadius = 2.0;  // 阴影扩散的范围控制
        
        __weak typeof(self) weakSelf = self;
        [_btAvatar ryAV_doubleClick:^{
            [weakSelf reHideClick];
        }];
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

- (RYAvatarView *)btFrom {
    if (!_btFrom) {
        _btFrom = [[RYAvatarView alloc] init];
        _btFrom.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btFrom.imageView.layer.cornerRadius = 8;
        _btFrom.imageView.layer.masksToBounds = YES;
        //阴影
        _btFrom.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
        _btFrom.layer.shadowOpacity = 0.5;   // 阴影透明度
        _btFrom.layer.shadowOffset = CGSizeMake(2,2); // 阴影的范围
        _btFrom.layer.shadowRadius = 2.0;  // 阴影扩散的范围控制
        
        __weak typeof(self) weakSelf = self;
        [_btFrom ryAV_doubleClick:^{
            [weakSelf reHideClick];
        }];
    }
    return _btFrom;
}

- (RYStatuseReCommentView *)vReComment {
    if (!_vReComment) {
        _vReComment = [[RYStatuseReCommentView alloc] init];
    }
    return _vReComment;
}

- (UIView *)vLine {
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = RY_COLOR_GRAY_E8E8E8;
        
//        _vLine.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
//        _vLine.layer.shadowOpacity = 0.5;   // 阴影透明度
//        _vLine.layer.shadowOffset = CGSizeMake(0,3); // 阴影的范围
//        _vLine.layer.shadowRadius = 3.0;  // 阴影扩散的范围控制
    }
    return _vLine;
}

- (UIImageView *)ivBack {
    if (!_ivBack) {
        _ivBack = [[UIImageView alloc] init];
        _ivBack.contentMode = UIViewContentModeScaleAspectFill;
        _ivBack.layer.masksToBounds = YES;
        //毛玻璃
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [_ivBack addSubview:effectView];
        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return _ivBack;
}

- (UIButton *)btLike {
    if (!_btLike) {
        _btLike = [[UIButton alloc] init];
        [_btLike setTitle:@"赞" forState:UIControlStateNormal];
        [_btLike setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _btLike.layer.borderWidth = 0.5;
        _btLike.layer.borderColor = [UIColor blackColor].CGColor;
        _btLike.layer.cornerRadius = 4;
        _btLike.layer.masksToBounds = YES;
        
        [_btLike addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btLike;
}

- (UIButton *)btRe {
    if (!_btRe) {
        _btRe = [[UIButton alloc] init];
        [_btRe setTitle:@"转" forState:UIControlStateNormal];
        [_btRe setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btRe.layer.borderWidth = 0.5;
        _btRe.layer.borderColor = [UIColor blackColor].CGColor;
        _btRe.layer.cornerRadius = 4;
        _btRe.layer.masksToBounds = YES;
        
        [_btRe addTarget:self action:@selector(reClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btRe;
}

- (UIButton *)btComment {
    if (!_btComment) {
        _btComment = [[UIButton alloc] init];
        [_btComment setTitle:@"评" forState:UIControlStateNormal];
        [_btComment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btComment.layer.borderWidth = 0.5;
        _btComment.layer.borderColor = [UIColor blackColor].CGColor;
        _btComment.layer.cornerRadius = 4;
        _btComment.layer.masksToBounds = YES;
        
        [_btComment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btComment;
}

- (UIButton *)btFavo {
    if (!_btFavo) {
        _btFavo = [[UIButton alloc] init];
        [_btFavo setTitle:@"藏" forState:UIControlStateNormal];
        [_btFavo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btFavo.layer.borderWidth = 0.5;
        _btFavo.layer.borderColor = [UIColor blackColor].CGColor;
        _btFavo.layer.cornerRadius = 4;
        _btFavo.layer.masksToBounds = YES;
        [_btFavo addTarget:self action:@selector(favoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btFavo;
}

@end
