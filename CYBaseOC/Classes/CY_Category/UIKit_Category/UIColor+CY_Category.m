//
//  UIColor+CY_Category.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIColor+CY_Category.h"

@implementation UIColor (CY_Category)

+ (UIColor *)cc_colorWithRGB:(NSInteger)rgb {
    return [self cc_colorWithRGB:rgb alpha:1.0];
}

+ (UIColor *)cc_colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha {
    CGFloat red = ((rgb >> 16) & 0xff) / 255.0;
    CGFloat green = ((rgb >> 8) & 0xff) / 255.0;
    CGFloat blue = ((rgb) & 0xff) / 255.0;
    return [self colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)cc_colorWithRGBA:(NSInteger)rgba {
    CGFloat red = ((rgba >> 24) & 0xff) / 255.0;
    CGFloat green = ((rgba >> 16) & 0xff) / 255.0;
    CGFloat blue = ((rgba >> 8) & 0xff) / 255.0;
    CGFloat alpha = ((rgba) & 0xff) / 255.0;
    return [self colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIColor *(^)(CGFloat))cc_colorWithAlpha {
    return ^UIColor *(CGFloat alpha) {
        CGFloat red;
        CGFloat green;
        CGFloat blue;
        [self getRed:&red green:&green blue:&blue alpha:NULL];
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    };
}

- (UIColor *(^)(CGFloat))cc_colorWithDeepen {
    return ^UIColor *(CGFloat deepen) {
        CGFloat red;
        CGFloat green;
        CGFloat blue;
        CGFloat alpha;
        [self getRed:&red green:&green blue:&blue alpha:&alpha];
        
        red = MIN(1., MAX(0, red - deepen));
        green = MIN(1., MAX(0, green - deepen));
        blue = MIN(1., MAX(0, blue - deepen));
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    };
}

+ (UIColor *)cc_tempColor {
    return [self cc_colorWithRGB:0xfef28f alpha:0.7];
}

+ (UIColor *)cc_randomColor {
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    return [self colorWithRed:red green:green blue:blue alpha:1.0];
}

- (NSInteger)rgba {
    CGFloat rValue, gValue, bValue, aValue;
    if (![self getRed:&rValue green:&gValue blue:&bValue alpha:&aValue]) {
        return NO;
    }
    
    NSInteger red = rValue * 255.0;
    NSInteger green = gValue * 255.0;
    NSInteger blue = bValue * 255.0;
    NSInteger alpha = aValue * 255.0;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

- (BOOL)cc_isEqualToColor:(UIColor *)color {
    if (![color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        return NO;
    }
    
    CGFloat redValue, greenValue, blueValue, alphaValue;
    CGFloat rValue, gValue, bValue, aValue;
    
    if (![color getRed:&redValue green:&greenValue blue:&blueValue alpha:&alphaValue]) {
        return NO;
    }
    
    if (![self getRed:&rValue green:&gValue blue:&bValue alpha:&aValue]) {
        return NO;
    }
    
    return (redValue == rValue && greenValue == gValue && blueValue == bValue && alphaValue == aValue);
}

@end
