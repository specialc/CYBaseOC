//
//  CY_ResourceManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_ResourceManager.h"

#define RES_LIGHT_FONT_NAME         @"PingFangSC-Light"
#define RES_FONT_NAME               @"PingFangSC-Regular"
#define RES_BOLD_FONT_NAME          @"PingFangSC-Midium"

#define PythiaColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define PythiaColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

@interface CY_ResourceManager ()

@end

@implementation CY_ResourceManager

+ (CY_ResourceManager *)cc_sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - 配置解析相关方法

- (void)cc_run {
    
}

#pragma mark - 方法

- (UIColor *)cc_colorWithKey:(NSString *)colorKey {
    if ([colorKey hasPrefix:@"#"]) {
        NSString *colorStr = [colorKey substringFromIndex:1];
        return PythiaColorFromRGB(strtoul([colorStr UTF8String], 0, 16));
    }
    return nil;
}

- (UIImage *)cc_imageWithKey:(NSString *)imageKey {
    UIImage *outputImage = nil;
    outputImage = [UIImage imageNamed:imageKey];
    return outputImage;
}

- (UIFont *)cc_fontWithKey:(NSString *)fontKey {
    if (!fontKey && fontKey.cc_isEmpty) {
        return nil;
    }
    
    // 15px
    if ([fontKey.lowercaseString hasSuffix:@"px"]) {
        NSString *fontSizeStr = [fontKey substringToIndex:fontKey.length - 2];
        CGFloat fontSize = fontSizeStr.doubleValue;
        return [UIFont fontWithName:RES_FONT_NAME size:fontSize] ?: [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    }
    // 15px-bold 15px_bold
    else if ([fontKey.lowercaseString hasSuffix:@"px-bold"] || [fontKey.lowercaseString hasSuffix:@"px_bold"]) {
        NSString *fontSizeStr = [fontKey substringToIndex:fontKey.length - 7];
        CGFloat fontSize = fontSizeStr.doubleValue;
        return [UIFont fontWithName:RES_BOLD_FONT_NAME size:fontSize] ?: [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
    }
    // 15px-light 15px_light
    if ([fontKey.lowercaseString hasSuffix:@"px-light"] || [fontKey.lowercaseString hasSuffix:@"px_light"]) {
        NSString *fontSizeStr = [fontKey substringToIndex:fontKey.length - 7];
        CGFloat fontSize = fontSizeStr.doubleValue;
        return [UIFont fontWithName:RES_LIGHT_FONT_NAME size:fontSize] ?: [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    }
    return nil;
}

- (UIFont *)cc_systemFontWithKey:(NSString *)fontkey {
    if (!fontkey && fontkey.cc_isEmpty) {
        return nil;
    }
    
    // 15px
    if ([fontkey.lowercaseString hasSuffix:@"px"]) {
        NSString *fontSizeStr = [fontkey substringToIndex:fontkey.length -2];
        CGFloat fontSize = fontSizeStr.doubleValue;
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    }
    // 15px-bold 15px_bold
    else if ([fontkey.lowercaseString hasSuffix:@"px-bold"] || [fontkey.lowercaseString hasSuffix:@"px_bold"]) {
        NSString *fontSizeStr = [fontkey substringToIndex:fontkey.length - 7];
        CGFloat fontSize = fontSizeStr.doubleValue;
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
    }
    // 15px-light 15px_light
    if ([fontkey.lowercaseString hasSuffix:@"px-light"] || [fontkey.lowercaseString hasSuffix:@"px_light"]) {
        NSString *fontSizeStr = [fontkey substringToIndex:fontkey.length - 7];
        CGFloat fontSize = fontSizeStr.doubleValue;
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    }
    return nil;
}

@end
