//
//  RYBaseConfig.m
//  Ryuk
//
//  Created by RongqingWang on 2017/4/24.
//  Copyright © 2017年 RyukieSama. All rights reserved.
//

#import "RYBaseConfig.h"

CGFloat ryColorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@implementation RYBaseConfig

+ (CGFloat)screenWid {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGRect)screenRect {
    return [UIScreen mainScreen].bounds;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    CGFloat alpha, red, blue, green;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = ryColorComponentFrom(colorString, 0, 1);
            green = ryColorComponentFrom(colorString, 1, 1);
            blue  = ryColorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = ryColorComponentFrom(colorString, 0, 1);
            red   = ryColorComponentFrom(colorString, 1, 1);
            green = ryColorComponentFrom(colorString, 2, 1);
            blue  = ryColorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = ryColorComponentFrom(colorString, 0, 2);
            green = ryColorComponentFrom(colorString, 2, 2);
            blue  = ryColorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = ryColorComponentFrom(colorString, 0, 2);
            red   = ryColorComponentFrom(colorString, 2, 2);
            green = ryColorComponentFrom(colorString, 4, 2);
            blue  = ryColorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

    
@end
