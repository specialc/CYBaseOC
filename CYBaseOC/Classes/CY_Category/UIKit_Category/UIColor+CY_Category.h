//
//  UIColor+CY_Category.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

#define CC_ColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CC_ColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define rgba(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define xrgb(rgb) [UIColor cc_colorWithRGB:rgb]
#define xrgba(rgba) [UIColor cc_colorWithRGBA:rgba]

@interface UIColor (CY_Category)

+ (UIColor *)cc_colorWithRGB:(NSInteger)rgb;
+ (UIColor *)cc_colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha;
+ (UIColor *)cc_colorWithRGBA:(NSInteger)rgba;

@property (nonatomic, strong, readonly) UIColor *(^cc_colorWithAlpha)(CGFloat alpha);
@property (nonatomic, strong, readonly) UIColor *(^cc_colorWithDeepen)(CGFloat deepen);

@property (class, nonatomic, strong, readonly) UIColor *cc_tempColor;
@property (class, nonatomic, strong, readonly) UIColor *cc_randomColor;

- (NSInteger)rgba;

- (BOOL)cc_isEqualToColor:(UIColor *)color;

@end

