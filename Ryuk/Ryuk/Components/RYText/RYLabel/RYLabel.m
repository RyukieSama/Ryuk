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

@interface RYLabel ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray <RYTextUnit *>*arrLinks;
@property (nonatomic, strong) NSMutableArray <RYTextUnit *>*arrImages;
@property (nonatomic, strong) NSMutableArray <RYTextUnit *>*arrAts;

@end

@implementation RYLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizers];
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

// 将点击的位置转换成字符串的偏移量，如果没有找到，则返回-1
- (CFIndex)touchContentOffsetInViewAtPoint:(CGPoint)point {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    if (!lines) {
        return -1;
    }
    CFIndex count = CFArrayGetCount(lines);
    
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0,0), origins);
    
    // 翻转坐标系
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    CFIndex idx = -1;
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        // 获得每一行的CGRect信息
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(rect),
                                                point.y-CGRectGetMinY(rect));
            // 获得当前点击坐标对应的字符串偏移
            idx = CTLineGetStringIndexForPosition(line, relativePoint);
        }
    }
    
    NSLog(@"````````````%ld",idx);
    return idx;
}

- (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

- (void)touchEventAtIndex:(CFIndex)index {
    //找出在这个额位置的Unit
    for (RYTextUnit *unit in self.arrAts) {
        if ((index >= unit.range.location) && (index <= unit.range.location + unit.range.length)) {
            NSLog(@"%@",unit.content);
        }
    }
}

#pragma mark - Gesture recognizers
- (void)addGestureRecognizers {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapping:)];
    [singleTap setDelegate:self];
    [self addGestureRecognizer:singleTap];
}

#pragma mark - Gesture recognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

#pragma mark - Handle tappings
- (void)handleTapping:(UITapGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    [self touchEventAtIndex:[self touchContentOffsetInViewAtPoint:point]];
}

@end
