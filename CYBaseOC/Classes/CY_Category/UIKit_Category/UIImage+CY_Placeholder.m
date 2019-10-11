//
//  UIImage+CY_Placeholder.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/24.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIImage+CY_Placeholder.h"

@implementation UIImage (CY_Placeholder)

- (CGRect)cc_bounds {
    return CGRectMake(0, 0, self.size.width, self.size.height);
}

- (CGRect)cc_nativeBounds {
    return CGRectMake(0, 0, self.size.width * self.scale, self.size.height * self.scale);
}

+ (UIImage *)cc_placeholderImageWithImage:(UIImage *)image backgroundColor:(UIColor *)backgroundColor size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, UIScreen.mainScreen.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [backgroundColor set];
    CGContextSetShouldAntialias(ctx, YES);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [path fill];
    [image drawInRect:CGRectMake(size.width / 2 - image.size.width / 2, size.height / 2 - image.size.height / 2, image.size.width, image.size.height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)cc_linearGradientWithInputPoints:(NSArray<NSValue *> *)inputPoints inputColors:(NSArray<UIColor *> *)inputColors size:(CGSize)size {
    if (inputPoints.count == inputColors.count && inputColors.count == 2) {
        CGPoint _inputPoint0 = inputPoints.firstObject.CGPointValue;
        CGPoint _inputPoint1 = inputPoints.lastObject.CGPointValue;
        UIColor *_inputColor0 = inputColors.firstObject;
        UIColor *_inputColor1 = inputColors.lastObject;
        CIFilter *ciFilter = [CIFilter filterWithName:@"CILinearGradient"];
        CIVector *vector0 = [CIVector vectorWithX:size.width * _inputPoint0.x Y:size.height * (1 - _inputPoint0.y)];
        CIVector *vector1 = [CIVector vectorWithX:size.width * _inputPoint1.x Y:size.height * (1 - _inputPoint1.y)];
        [ciFilter setValue:vector0 forKey:@"inputPoint0"];
        [ciFilter setValue:vector1 forKey:@"inputPoint1"];
        [ciFilter setValue:[CIColor colorWithCGColor:_inputColor0.CGColor] forKey:@"inputColor0"];
        [ciFilter setValue:[CIColor colorWithCGColor:_inputColor1.CGColor] forKey:@"inputColor1"];
        
        // UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen.scale);
        CIImage *ciImage = ciFilter.outputImage;
        CIContext *con = [CIContext contextWithOptions:nil];
        CGImageRef resultCGImage = [con createCGImage:ciImage fromRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *resultUIImage = [UIImage imageWithCGImage:resultCGImage];
        CGImageRelease(resultCGImage);
        return resultUIImage;
    }
    return nil;
}

- (UIImage *)cc_clipsImageWithSquareSize:(CGSize)squareSize scale:(CGFloat)scale {
    // 200 * 300 => 100 * 100
    
    // 尺寸不合格
    if (squareSize.width != squareSize.height) {
        return nil;
    }
    
    CGSize orig_size = self.size;
    
    // 图片不需要编辑
    if (CGSizeEqualToSize(squareSize, orig_size)) {
        return self;
    }
    
    // 获取短边 200
    CGFloat shortSide = MIN(orig_size.width, orig_size.height);
    
    // 100/200 = 0.5
    CGFloat ratio = (squareSize.width / shortSide);
    
    // 获取缩放尺寸
    CGSize size = CGSizeMake(orig_size.width * ratio, orig_size.height * ratio);
    
    //
    UIGraphicsBeginImageContextWithOptions(squareSize, NO, scale);
    // 裁剪
    [self drawInRect:CGRectMake(squareSize.width / 2 - size.width / 2, squareSize.height / 2 - size.height / 2, size.width, size.height)];
    // CGContextClip(UIGraphicsGetCurrentContext());
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

+ (CAGradientLayer *)leftRightLinearGradientlayer:(CGSize)size fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor {
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);//从左到右
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0, @1];
    
    return gradientLayer;
}

+ (CAGradientLayer *)linearGradientLayer:(CGSize)size colors:(NSArray *)colors locations:(NSArray<NSNumber *> *)locations {
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    //  创建渐变色数组，需要转换为CGColor颜色
    //    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    //
    //    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    //    gradientLayer.startPoint = CGPointMake(0, 0);
    //    gradientLayer.endPoint = CGPointMake(1, 0);//从左到右
    //
    //    //  设置颜色变化点，取值范围 0.0~1.0
    //    gradientLayer.locations = @[@0, @1];
    
    return gradientLayer;
}

+ (UIImage *)imageFromLayer:(CALayer *)layer {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, 0);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *)templateImageWithColorError:(UIColor *)color {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)cc_templateImageWithColor:(UIColor *)color {
    // We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    // Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

- (UIImage *)cc_round {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale == 1 ? 0 : self.scale);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.size.height / 2] addClip];
    [self drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)cc_gradient:(CC_GradientLocation)location startColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size {
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    switch (location) {
        case CC_GradientLocation_TopToBottom:
            startPoint = CGPointMake(0.5, 0);
            endPoint = CGPointMake(0.5, 1);
            break;
        case CC_GradientLocation_LeftToRight:
            startPoint = CGPointMake(0, 0.5);
            endPoint = CGPointMake(1, 0.5);
            break;
        case CC_GradientLocation_TopLeftToBottomRight:
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(1, 1);
            break;
        case CC_GradientLocation_BottomLeftToTopRight:
            startPoint = CGPointMake(0, 1);
            endPoint = CGPointMake(1, 0);
            break;
            
        default:
            break;
    }
    
    CIFilter *filter = [CIFilter filterWithName:@"CILinearGradient"];
    CIVector *inputPoint0 = [CIVector vectorWithX:size.width * startPoint.x Y:size.height * (1 - startPoint.y)];
    CIVector *inputPoint1 = [CIVector vectorWithX:size.width * endPoint.x Y:size.height * (1 - endPoint.y)];
    [filter setValue:inputPoint0 forKey:@"inputPoint0"];
    [filter setValue:inputPoint1 forKey:@"inputPoint1"];
    CIColor *inputColor0 = [CIColor colorWithCGColor:startColor.CGColor];
    CIColor *inputColor1 = [CIColor colorWithCGColor:endColor.CGColor];
    [filter setValue:inputColor0 forKey:@"inputColor0"];
    [filter setValue:inputColor1 forKey:@"inputColor1"];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:filter.outputImage fromRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}

- (UIImage *)cc_resize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)cc_recolor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInRect:self.cc_bounds];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    CGContextFillRect(context, self.cc_bounds);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
