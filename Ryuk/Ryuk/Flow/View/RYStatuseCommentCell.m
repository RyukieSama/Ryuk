//
//  RYStatuseCommentCell.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/9.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYStatuseCommentCell.h"
#import "RYBaseConfig.h"

@implementation RYStatuseCommentCell

- (void)setComment:(RYComment *)comment {
    _comment = comment;
    self.textLabel.text = comment.text;
}

- (void)setRepost:(RYStatuse *)repost {
    _repost = repost;
    self.textLabel.text = repost.text;
}

@end
