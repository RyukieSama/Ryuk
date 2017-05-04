//
//  RYImageScrollViewPageCell.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/11.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYImageScrollViewPageCell.h"
#import <Masonry.h>

@interface RYImageScrollViewPageCell ()

@property (nonatomic, strong) UIImageView *ivImage;

@end

@implementation RYImageScrollViewPageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}

- (void)setupUI {
    self.ivImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.ivImage];
    [self.ivImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.ivImage.image = image;
}

@end
