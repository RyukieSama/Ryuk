//
//  RYLabel.m
//  Ryuk
//
//  Created by RongqingWang on 2017/5/12.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYLabel.h"
#import "RYTextUnit.h"

static NSString *urlPre = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
static NSString *atPre = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
static NSString *sharpPre = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
static NSString *emojiPre = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";

@interface RYLabel ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray <RYTextUnit *>*arrUnints;

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
    NSMutableString *muStr = text.mutableCopy;
//    [muStr appendString:@"\n"];
    [super setText:muStr];
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:muStr];
    self.attributedText = attStr;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [self clearText];
    NSMutableAttributedString *muAtt = attributedText.mutableCopy;
    
    [muAtt setAttributes:@{
                           NSFontAttributeName : self.font
                           }
                   range:NSMakeRange(0, attributedText.length)];
    
    //遍历文本中的元素
    for (RYTextUnit *unit in self.arrUnints) {
        [muAtt setAttributes:@{
                               NSForegroundColorAttributeName:[UIColor cyanColor],
                               NSFontAttributeName : self.font
                               }
                       range:unit.range];

    }
    
    [super setAttributedText:muAtt];
}

- (void)clearText {
    self.arrUnints = nil;
}

#pragma mark - function
- (void)atClick {
    
}

- (void)webClick {
    
}

#pragma mark - lazy
- (NSMutableArray<RYTextUnit *> *)arrUnints {
    if (!_arrUnints) {
        _arrUnints = @[].mutableCopy;
        [_arrUnints addObjectsFromArray:[self validateLink:self.text]];
        [_arrUnints addObjectsFromArray:[self validateAt:self.text]];
        [_arrUnints addObjectsFromArray:[self validateSharp:self.text]];
        [_arrUnints addObjectsFromArray:[self validateEmoji:self.text]];
    }
    return _arrUnints;
}

//- (NSMutableArray *)arrAts {
//    if (!_arrAts) {
//        _arrAts = [self validateAt:self.text].mutableCopy;
//        
//        //先看有没有 @
////        if ([self.text containsString:@"@"]) {
////            NSString *newStr = self.text;
////            NSString *temp = nil;
////            NSMutableString *muStr = [[NSMutableString alloc] init];
////            BOOL appendSwitch = NO; //拼接开关
////            NSInteger startRange = 0;
////            NSInteger endRange = 0;
////            
////            for(int i =0; i < [newStr length]; i++) {
////                temp = [newStr substringWithRange:NSMakeRange(i, 1)];
////                if (appendSwitch && ![temp isEqualToString:@" "] && ![temp isEqualToString:@":"] && ![temp isEqualToString:@"："] && ((i+1) != [newStr length])) {
////                    [muStr appendString:temp];
////                } else {
////                    if ([temp isEqualToString:@"@"]) {
////                        appendSwitch = YES;
////                        [muStr appendString:temp];
////                        startRange = i;
////                    } else if (appendSwitch && ([temp isEqualToString:@" "] || ((i+1) == [newStr length]) || [temp isEqualToString:@":"] || [temp isEqualToString:@"："])) {
////                        endRange = i;
////                        
////                        if ((i+1) == [newStr length]) {
////                            [muStr appendString:temp];
////                            endRange = i+1;
////                        }
////                        
////                        RYTextUnit *unit = [[RYTextUnit alloc] init];
////                        unit.content = muStr;
////                        unit.range = NSMakeRange(startRange, endRange - startRange);
////                        unit.type = RYTextUnitTypeAt;
////                        [_arrAts addObject:unit];
////                        
////                        //还原
////                        muStr = [[NSMutableString alloc] init];
////                        appendSwitch = NO;
////                        startRange = 0;
////                        endRange = 0;
////                    }
////                }
////            }
////        }
//        
////        NSArray *arr = [self validateAt:self.text];
////        if (arr.count > 0) {
////            for (NSString *str in arr) {
////                RYTextUnit *unit = [[RYTextUnit alloc] init];
////                unit.content = str;
////                unit.range = [self.text rangeOfString:str];
////                unit.type = RYTextUnitTypeAt;
////                [_arrAts addObject:unit];
////            }
////        }
//        
//    }
//    return _arrAts;
//}

#pragma mark - touch
// 将点击的位置转换成字符串的偏移量，如果没有找到，则返回-1
- (CFIndex)touchContentOffsetInViewAtPoint:(CGPoint)point {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [self.text length]), path, NULL);
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

    NSInteger length = self.text.length;
    
    if (idx < length) {
        NSLog(@"点击位置:%ld ```````````````    字符为:%@",idx,[self.text substringWithRange:NSMakeRange(idx, 1)]);
    } else {
        NSLog(@"越界了");
    }
    
    CFRelease(framesetter);
    CFRelease(frame);
    CFRelease(path);
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
    for (RYTextUnit *unit in self.arrUnints) {
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

#pragma mark - predicate
- (NSArray <RYTextUnit *>*)validateLink:(NSString *)link {
    NSMutableArray *arr = @[].mutableCopy;
    // | 匹配多个条件,相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@",urlPre];
    // 使用系统的正则类来遍历
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:link options:0 range:NSMakeRange(0, link.length)];
    // 3.遍历结果
    for (NSTextCheckingResult *result in results) {
        RYTextUnit *unit = [[RYTextUnit alloc] init];
        unit.content = [link substringWithRange:result.range];
        unit.range = result.range;
        unit.type = RYTextUnitTypeURL;
        [arr addObject:unit];
    }
    return arr.copy;
}

- (NSArray <RYTextUnit *>*)validateAt:(NSString *)at {
    NSMutableArray *arr = @[].mutableCopy;
    // | 匹配多个条件,相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@",atPre];
    // 使用系统的正则类来遍历
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:at options:0 range:NSMakeRange(0, at.length)];
    // 3.遍历结果
    for (NSTextCheckingResult *result in results) {
        RYTextUnit *unit = [[RYTextUnit alloc] init];
        unit.content = [at substringWithRange:result.range];
        unit.range = result.range;
        unit.type = RYTextUnitTypeAt;
        [arr addObject:unit];
    }
    return arr.copy;
}

- (NSArray <RYTextUnit *>*)validateSharp:(NSString *)sharp {
    NSMutableArray *arr = @[].mutableCopy;
    // | 匹配多个条件,相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@",sharpPre];
    // 使用系统的正则类来遍历
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:sharp options:0 range:NSMakeRange(0, sharp.length)];
    // 3.遍历结果
    for (NSTextCheckingResult *result in results) {
        RYTextUnit *unit = [[RYTextUnit alloc] init];
        unit.content = [sharp substringWithRange:result.range];
        unit.range = result.range;
        unit.type = RYTextUnitTypeSharp;
        [arr addObject:unit];
    }
    return arr.copy;
}

- (NSArray <RYTextUnit *>*)validateEmoji:(NSString *)emoji {
    NSMutableArray *arr = @[].mutableCopy;
    // | 匹配多个条件,相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@",emojiPre];
    // 使用系统的正则类来遍历
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:emoji options:0 range:NSMakeRange(0, emoji.length)];
    // 3.遍历结果
    for (NSTextCheckingResult *result in results) {
        RYTextUnit *unit = [[RYTextUnit alloc] init];
        unit.content = [emoji substringWithRange:result.range];
        unit.range = result.range;
        unit.type = RYTextUnitTypeEmoji;
        [arr addObject:unit];
    }
    return arr.copy;
}

@end
