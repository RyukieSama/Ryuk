//
//  RYFlowStatuseCell.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/26.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYFlowStatuseCell.h"

@interface RYFlowStatuseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ivImage;


@end

@implementation RYFlowStatuseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setStatuse:(RYStatuse *)statuse {
    _statuse = statuse;
    [self.ivImage sd_setImageWithURL:[NSURL URLWithString:statuse.original_pic]];
}

@end
