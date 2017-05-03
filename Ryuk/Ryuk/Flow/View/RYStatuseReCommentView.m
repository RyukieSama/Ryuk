//
//  RYStatuseReCommentView.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/27.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYStatuseReCommentView.h"
#import "RYBaseConfig.h"

@interface RYStatuseReCommentView ()

@property (nonatomic, strong) UIImageView *ivBack;
@property (nonatomic, strong) UILabel *lbText;
@property (nonatomic, strong) UIButton *btClose;

@end

@implementation RYStatuseReCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影的颜色
//    self.layer.shadowOpacity = 0.5;   // 阴影透明度
//    self.layer.shadowOffset = CGSizeMake(1,2); // 阴影的范围
//    self.layer.shadowRadius = 2.0;  // 阴影扩散的范围控制
    
    [self addSubview:self.ivBack];
    [self.ivBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self addSubview:self.lbText];
    [self.lbText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(4);
        make.right.mas_equalTo(-4);
        make.bottom.mas_equalTo(-18);
    }];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.lbText.text = text;
}

#pragma mark - lazy
- (UILabel *)lbText {
    if (!_lbText) {
        _lbText = [[UILabel alloc] init];
        _lbText.numberOfLines = 0;
        _lbText.font = RY_FONT(14);
        _lbText.textColor = [UIColor whiteColor];
//        _lbText.textAlignment = NSTextAlignmentRight;
    }
    return _lbText;
}

- (UIImageView *)ivBack {
    if (!_ivBack) {
        _ivBack = [[UIImageView alloc] init];
        _ivBack.image = [UIImage imageNamed:@"ReBackground"];
    }
    return _ivBack;
}

@end
