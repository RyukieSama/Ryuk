//
//  RYLabel.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/12.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYLabel.h"
#import "YYText.h"
#import "RYTextUnit.h"

@interface RYLabel ()

@property (nonatomic, strong) NSMutableArray <RYTextUnit *>*arrLinks;
@property (nonatomic, strong) NSMutableArray <RYTextUnit *>*arrImages;
@property (nonatomic, strong) NSMutableArray <RYTextUnit *>*arrAts;

@end

@implementation RYLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    return self;
}

- (void)addEvent {

}

- (void)setText:(NSString *)text {
    [super setText:text];
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:text];
    self.attributedText = attStr;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [self clearText];
    NSMutableAttributedString *muAtt = attributedText.mutableCopy;
    muAtt.yy_font = self.font;
    muAtt.yy_color = self.textColor;
    
    //遍历文本中的元素
    for (RYTextUnit *unit in self.arrAts) {
        [muAtt yy_setTextHighlightRange:unit.range
                                  color:[UIColor blueColor]
                        backgroundColor:[UIColor clearColor]
                              tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                  NSLog(@"%@",unit.content);
                              }];
    }
    
    [super setAttributedText:muAtt];
}

- (void)clearText {
    self.arrAts = nil;
    self.arrImages = nil;
    self.arrLinks = nil;
}

#pragma mark - function

- (void)atClick {
    
}

- (void)webClick {
    
}

#pragma mark - lazy
- (NSMutableArray *)arrLinks {
    if (!_arrLinks) {
        _arrLinks = @[].mutableCopy;
    }
    return _arrLinks;
}

- (NSMutableArray *)arrImages {
    if (!_arrImages) {
        _arrImages = @[].mutableCopy;
    }
    return _arrImages;
}

- (NSMutableArray *)arrAts {
    if (!_arrAts) {
        _arrAts = @[].mutableCopy;
        
        NSString *newStr = self.text;
        NSString *temp = nil;
        NSMutableString *muStr = [[NSMutableString alloc] init];
        BOOL appendSwitch = NO; //拼接开关
        NSInteger startRange = 0;
        NSInteger endRange = 0;
        
        for(int i =0; i < [newStr length]; i++) {
            temp = [newStr substringWithRange:NSMakeRange(i, 1)];
            if (appendSwitch && ![temp isEqualToString:@" "] && ![temp isEqualToString:@":"] && ((i+1) != [newStr length])) {
                [muStr appendString:temp];
            } else {
                if ([temp isEqualToString:@"@"]) {
                    appendSwitch = YES;
                    [muStr appendString:temp];
                    startRange = i;
                } else if (appendSwitch && ([temp isEqualToString:@" "] || ((i+1) == [newStr length]) || [temp isEqualToString:@":"])) {
                    endRange = i;
                    
                    if ((i+1) == [newStr length]) {
                        [muStr appendString:temp];
                        endRange = i+1;
                    }
                    
                    RYTextUnit *unit = [[RYTextUnit alloc] init];
                    unit.content = muStr;
                    unit.range = NSMakeRange(startRange, endRange - startRange);
//                    NSLog(@"%@",muStr);
                    [_arrAts addObject:unit];
                    
                    muStr = [[NSMutableString alloc] init];
                    appendSwitch = NO;
                    startRange = 0;
                    endRange = 0;
                }
            }
        }
    }
    return _arrAts;
}

@end
