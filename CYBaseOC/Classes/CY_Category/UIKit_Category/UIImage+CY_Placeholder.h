//
//  UIImage+CY_Placeholder.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/24.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

typedef NS_ENUM(NSInteger, CC_GradientLocation) {
    CC_GradientLocation_TopToBottom,           // 从上到下
    CC_GradientLocation_LeftToRight,           // 从左到右
    CC_GradientLocation_TopLeftToBottomRight,  // 从左上到右上
    CC_GradientLocation_BottomLeftToTopRight,  // 从左下到右上
};

@interface UIImage (CY_Placeholder)

@property (nonatomic, readonly) CGRect cc_bounds;
@property (nonatomic, readonly) CGRect cc_nativeBounds;

+ (UIImage *)cc_placeholderImageWithImage:(UIImage *)image backgroundColor:(UIColor *)backgroundColor size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)cc_clipsImageWithSquareSize:(CGSize)squareSize scale:(CGFloat)scale;

+ (UIImage *)cc_linearGradientWithInputPoints:(NSArray<NSValue *> *)inputPoints inputColors:(NSArray<UIColor *> *)inputColors size:(CGSize)size;

- (UIImage *)cc_templateImageWithColor:(UIColor *)color;

/** 图片裁圆角 */
- (UIImage *)cc_round;

/** 创建渐变色图片 */
+ (UIImage *)cc_gradient:(CC_GradientLocation)location startColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size;

/** 调整图片大小 */
- (UIImage *)cc_resize:(CGSize)size;

/** 重绘图片颜色 */
- (UIImage *)cc_recolor:(UIColor *)color;

@end

