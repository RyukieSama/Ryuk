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
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.lbText];
    [self.lbText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(4);
        make.right.bottom.mas_equalTo(-4);
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
//        _lbText.textAlignment = NSTextAlignmentRight;
    }
    return _lbText;
}

@end
