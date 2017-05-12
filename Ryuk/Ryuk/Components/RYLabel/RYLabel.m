//
//  RYLabel.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/12.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYLabel.h"


@interface RYLabel ()

@property (nonatomic, strong) NSMutableArray *arrLinks;
@property (nonatomic, strong) NSMutableArray *arrImages;
@property (nonatomic, strong) NSMutableArray *arrAts;

@end

@implementation RYLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.arrAts = @[].mutableCopy;
    self.arrImages = @[].mutableCopy;
    self.arrLinks = @[].mutableCopy;
    return self;
}

- (void)addEvent {

}

- (void)setText:(NSString *)text {
    [super setText:text];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    [super setAttributedText:attributedText];
}

#pragma mark - function

- (void)atClick {
    
}

- (void)webClick {
    
}

@end
