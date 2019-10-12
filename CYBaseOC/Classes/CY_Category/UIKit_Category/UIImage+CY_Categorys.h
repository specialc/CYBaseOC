//
//  UIImage+CY_Categorys.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface UIImage (CY_Categorys)

+ (UIImage *)cc_resizableImageNamed:(NSString *)name;
@property (nonatomic, strong, readonly) UIImage *cc_resizableImage;

+ (UIImage *)cc_originalImageNamed:(NSString *)name;
@property (nonatomic, strong, readonly) UIImage *cc_originalImage;

+ (UIImage *)cc_templateImageNamed:(NSString *)name;
@property (nonatomic, strong, readonly) UIImage *cc_templateImage;

- (UIImage *)cc_equalRatioImageWithMaxWidth:(CGFloat)width;

+ (UIImage *)cc_imageWithColor:(UIColor *)color;

+ (UIImage *)cc_imageWithColor:(UIColor *)color size:(CGSize)size;

// 获取圆角图片
+ (UIImage *)cc_roundRectImageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
// 获得圆形、椭圆形图片
+ (UIImage *)cc_roundImageWithColor:(UIColor *)color size:(CGSize)size;

- (UIColor *)cc_colorWithCreatedImage;

- (UIColor *)cc_colorWithPoint:(CGPoint)point;

- (UIImage *)cc_imageWithBrightness:(CGFloat)brightness;

- (UIImage *)cc_imageByApplyingAlpha:(CGFloat)alpha;

@property (nonatomic, strong, readonly) UIImage *(^cc_imageWithAlpha)(CGFloat alpha);

@end


@interface UIColor (CY_ImageCategory)

@property (nonatomic, strong, readonly) UIImage *cc_solidImage;

@end

@interface CY_ImageCache : NSObject

+ (instancetype)cc_sharedCache;

- (void)cc_storeImage:(UIImage *)image forColor:(UIColor *)color;

- (UIImage *)cc_imageWithContains:(UIColor *)color;

- (UIImage *)cc_imageFromCacheForColor:(UIColor *)color;

@end
