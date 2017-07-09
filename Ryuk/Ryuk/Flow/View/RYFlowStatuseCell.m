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
#import "RYImageBrowser.h"
#import  <SVProgressHUD.h>

@interface RYFlowStatuseCell ()

@property (nonatomic, strong) RYImagesScrollView *vCover;
@property (nonatomic, strong) RYAvatarView *btAvatar;
@property (nonatomic, strong) RYAvatarView *btFrom;
@property (nonatomic, strong) UIButton *btShowReComment;
@property (nonatomic, strong) UIButton *btFavo;//收藏
@property (nonatomic, strong) UIButton *btRe;//转发
@property (nonatomic, strong) UIButton *btComment;//评论
@property (nonatomic, strong) UIImageView *ivBack;
@property (nonatomic, strong) UILabel *lbNickName;
@property (nonatomic, strong) RYLabel *lbContent;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) RYStatuseReCommentView *vReComment;

@end

@implementation RYFlowStatuseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //基础UI
     [self setupBaseUI];
    //根据cellId布局
    
    //纯文本  有转发文案
    if ([reuseIdentifier isEqualToString:RYStatuseCellIDText]) {
        [self setupUIRYStatuseCellIDText];
    }
    //纯文本   无转发文案
    if ([reuseIdentifier isEqualToString:RYStatuseCellIDTextNoRe]) {
        [self setupUIRYStatuseCellIDTextNoRe];
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
        make.top.mas_equalTo(self.ivBack.mas_bottom);
        make.width.mas_equalTo(RY_UI_SCREEN_WID);
    }];
    
    //文本
    [self.contentView addSubview:self.lbContent];
    [self.lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.ivBack.mas_bottom).offset(45);
    }];
    
    //收藏
    [self.contentView addSubview:self.btFavo];
    [self.btFavo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lbContent);
        make.top.mas_equalTo(self.lbContent.mas_bottom).offset(12);
        make.bottom.mas_equalTo(-8);
    }];
    
    //转发
    [self.contentView addSubview:self.btRe];
    [self.btRe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btFavo);
        make.left.mas_equalTo(self.btFavo.mas_right).offset(8);
    }];
    
    //评论
    [self.contentView addSubview:self.btComment];
    [self.btComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btFavo);
        make.left.mas_equalTo(self.btRe.mas_right).offset(8);
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

- (void)setupUIRYStatuseCellIDTextNoRe {
    [self setupUIRYStatuseCellIDText];
    [self.ivBack mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(32);
    }];
    [self.vCover removeFromSuperview];
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
        if (statuse.hideRe) {
            self.btFrom.imageView.layer.borderWidth = 2;
            self.btFrom.imageView.layer.borderColor = [UIColor blackColor].CGColor;
        } else {
            self.btFrom.imageView.layer.borderWidth = 0;
        }
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
    if ([statuse.cellID isEqualToString:RYStatuseCellIDText] || [statuse.cellID isEqualToString:RYStatuseCellIDTextNoRe]) {
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
    
    //收藏按钮
    if (statuse.favorited) {
        [self.btFavo setImage:[UIImage imageNamed:@"ios7-heart"] forState:UIControlStateNormal];
    } else {
        [self.btFavo setImage:[UIImage imageNamed:@"ios7-heart-outline"] forState:UIControlStateNormal];
    }
    
    //评论按钮
    NSString *re = statuse.reposts_count > 0 ? [NSString stringWithFormat:@" %ld",(long)statuse.reposts_count] : nil;
    [self.btRe setTitle:re forState:UIControlStateNormal];
    NSString *cm = statuse.comments_count > 0 ? [NSString stringWithFormat:@" %ld",(long)statuse.comments_count] : nil;
    [self.btComment setTitle:cm forState:UIControlStateNormal];
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
//    NSLog(@"%s",__FUNCTION__);
//    [RYStatuseManager likeStatuse:self.statuse];
}

- (void)reClick {
    [RYStatuseManager reStatuse:self.statuse completionHandler:^(id obj) {
        
    }];
}

- (void)commentClick {
    [RYStatuseManager commentStatuse:self.statuse completionHandler:^(id obj) {
        
    }];
}

- (void)favoClick {
    __weak typeof(self) weakSelf = self;
    if (self.statuse.favorited) {
        [RYStatuseManager unfavoStatuse:self.statuse completionHandler:^(id obj) {
            if ([obj integerValue] == 0) {
                [weakSelf.btFavo setImage:[UIImage imageNamed:@"ios7-heart-outline"] forState:UIControlStateNormal];
            }
        }];
    } else {
        [RYStatuseManager favoStatuse:self.statuse completionHandler:^(id obj) {
            if ([obj integerValue] == 1) {
                [weakSelf.btFavo setImage:[UIImage imageNamed:@"ios7-heart"] forState:UIControlStateNormal];
            }
        }];
    }
}

- (void)reHideClick {
    NSLog(@"%s",__FUNCTION__);
    self.statuse.hideRe = !self.statuse.hideRe;
    if (self.statuse.hideRe) {
        [self.vReComment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.btFrom.mas_top).offset(4);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
            make.right.mas_equalTo(-20);
        }];
    } else {
        [self.vReComment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.btFrom.mas_top).offset(4);
            make.width.mas_lessThanOrEqualTo(300);
            make.right.mas_equalTo(-20);
        }];
    }
//    self.statuse = self.statuse;//手动set
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        if (weakSelf.statuse.hideRe) {
            weakSelf.vReComment.alpha = 0;
            weakSelf.btFrom.imageView.layer.borderWidth = 2;
            weakSelf.btFrom.imageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        } else {
            weakSelf.vReComment.hidden = NO;
            weakSelf.vReComment.alpha = 1;
            weakSelf.btFrom.imageView.layer.borderWidth = 0;
        }
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (weakSelf.statuse.hideRe) {
            weakSelf.vReComment.hidden = YES;
        } else {

        }
    }];
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
        _vCover.handler_imageClick = ^(NSNumber *obj) {
            NSArray *arr = weakSelf.statuse.pic_urls_strings.count > 0 ? weakSelf.statuse.pic_urls_strings : weakSelf.statuse.retweeted_status.pic_urls_strings;
            [RYImageBrowser showBrowserWithImageURLs:arr atIndex:[obj integerValue] withPageStyle:RYImageBrowserPageStyleAuto fromImageView:weakSelf.vCover withProgress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
                NSLog(@"withProgress");
                [SVProgressHUD show];
            } changImage:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
                NSLog(@"changImage");
                [SVProgressHUD dismiss];
            } loadedImage:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
                NSLog(@"loadedImage");
                [SVProgressHUD dismiss];
            }];

//            [RYImageBrowser showBrowserWithImageURLs:arr atIndex:[obj integerValue] withPageStyle:RYImageBrowserPageStyleAuto];
            
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
        _btAvatar.imageView.layer.cornerRadius = RY_DETAULT_CORNER_R;
        _btAvatar.imageView.layer.masksToBounds = YES;
        //阴影
        _btAvatar.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
        _btAvatar.layer.shadowOpacity = 0.5;   // 阴影透明度
        _btAvatar.layer.shadowOffset = CGSizeMake(0,0); // 阴影的范围
        _btAvatar.layer.shadowRadius = 2.0;  // 阴影扩散的范围控制
        
        __weak typeof(self) weakSelf = self;
        [_btAvatar ryAV_doubleClick:^{
            [weakSelf reHideClick];
        }];
        [_btAvatar ryAV_oneClick:^{
            RYUser *user = weakSelf.statuse.retweeted_status.user ?: weakSelf.statuse.user;
            [RYRouter ryPushToVC:RY_ROUTER_VC_KEY_USERHOMEPAGE param:@{@"user" : user}];
        }];
    }
    return _btAvatar;
}

- (RYLabel *)lbContent {
    if (!_lbContent) {
        _lbContent = [[RYLabel alloc] init];
        _lbContent.font = RY_FONT(14);
        _lbContent.numberOfLines = 0;
        _lbContent.textColor = [UIColor blackColor];
//        _lbContent.lineBreakMode = NSLineBreakByCharWrapping; //切勿修改换行方式会导致点击出问题
        _lbContent.textClick = ^(RYTextUnit *unit) {
            [RYRouter textClickOnUnit:unit];
        };
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
        _btFrom.imageView.layer.cornerRadius = RY_DETAULT_CORNER_R;
        _btFrom.imageView.layer.masksToBounds = YES;
        //阴影
        _btFrom.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
        _btFrom.layer.shadowOpacity = 0.5;   // 阴影透明度
        _btFrom.layer.shadowOffset = CGSizeMake(0,0); // 阴影的范围
        _btFrom.layer.shadowRadius = 2.0;  // 阴影扩散的范围控制
        
        __weak typeof(self) weakSelf = self;
        [_btFrom ryAV_doubleClick:^{
            [weakSelf reHideClick];
        }];
        [_btFrom ryAV_oneClick:^{
            [RYRouter ryPushToVC:RY_ROUTER_VC_KEY_USERHOMEPAGE param:@{@"user" : weakSelf.statuse.user}];
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

- (UIButton *)btFavo {
    if (!_btFavo) {
        _btFavo = [[UIButton alloc] init];
        [_btFavo setImage:[UIImage imageNamed:@"ios7-heart-outline"] forState:UIControlStateNormal];
        [_btFavo addTarget:self action:@selector(favoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btFavo;
}

- (UIButton *)btRe {
    if (!_btRe) {
        _btRe = [[UIButton alloc] init];
        [_btRe setImage:[UIImage imageNamed:@"ios7-redo-outline"] forState:UIControlStateNormal];
        [_btRe addTarget:self action:@selector(reClick) forControlEvents:UIControlEventTouchUpInside];
        [_btRe setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btRe.titleLabel setFont:RY_FONT(12)];
    }
    return _btRe;
}

- (UIButton *)btComment {
    if (!_btComment) {
        _btComment = [[UIButton alloc] init];
        [_btComment setImage:[UIImage imageNamed:@"ios7-chatboxes-outline"] forState:UIControlStateNormal];
        [_btComment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
        [_btComment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btComment.titleLabel setFont:RY_FONT(12)];
    }
    return _btComment;
}

@end
