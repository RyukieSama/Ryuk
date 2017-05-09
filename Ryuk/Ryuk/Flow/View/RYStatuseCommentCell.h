//
//  RYStatuseCommentCell.h
//  Ryuk
//
//  Created by RongqingWang on 2017/5/9.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYComment.h"
#import "RYStatuse.h"

@interface RYStatuseCommentCell : UITableViewCell

@property (nonatomic, strong) RYComment *comment;
@property (nonatomic, strong) RYStatuse *repost;

@end
