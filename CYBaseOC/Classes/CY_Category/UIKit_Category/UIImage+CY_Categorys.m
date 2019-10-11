//
//  UIImage+CY_Categorys.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIImage+CY_Categorys.h"
#import "UIColor+CY_Category.h"

@implementation UIImage (CY_Categorys)

+ (UIImage *)cc_resizableImageNamed:(NSString *)name {
    return [[self imageNamed:name] cc_resizableImage];
}

- (UIImage *)cc_resizableImage {
    CGFloat x = self.size.width * 0.5;
    CGFloat y = self.size.height * 0.5;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(y, x, y, x) resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)cc_originalImageNamed:(NSString *)name {
    return [self imageNamed:name].cc_originalImage;
}

- (UIImage *)cc_originalImage {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)cc_templateImageNamed:(NSString *)name {
    return [self imageNamed:name].cc_templateImage;
}

- (UIImage *)cc_templateImage {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (UIImage *)cc_equalRatioImageWithMaxWidth:(CGFloat)width {
    CGSize size = self.size;
    if (self.size.width > width) {
        size.width = width;
        size.height = self.size.height * (width / self.size.width);
    }
    else {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

+ (UIImage *)cc_imageWithColor:(UIColor *)color {
    return [self cc_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)cc_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)cc_roundImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    CGContextSetShouldAntialias(context, YES);
    CGContextFillEllipseInRect(context, rect);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)cc_roundRectImageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, UIScreen.mainScreen.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [color set];
    CGContextSetShouldAntialias(ctx, YES);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [path fill];
//    CGContextFillPath(ctx);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIColor *)cc_colorWithCreatedImage {
    return [self cc_colorWithPoint:CGPointMake(1, 1)];
}

- (UIColor *)cc_colorWithPoint:(CGPoint)point {
    return [self getPixelColorAtLocation:point];
}

- (UIColor *)getPixelColorAtLocation:(CGPoint)point {
    UIColor *color = nil;
    CGImageRef inImage = self.CGImage;
    
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) {
        return nil;
    }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0, 0}, {w, h}};
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);
    
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    unsigned char *data = CGBitmapContextGetData(cgctx);
    if (data != NULL) {
        //offset locates the pixel in the data from x,y.
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        @try {
            int offset = 4 * ((w * round(point.y)) + round(point.x));
            NSLog(@"offset: %d", offset);
            int alpha = data[offset];
            int red = data[offset + 1];
            int green = data[offset + 2];
            int blue = data[offset + 3];
            NSLog(@"offset: %i colors: RGB A %i %i %i %i", offset, red, green, blue, alpha);
            color = [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:(blue / 255.0f) alpha:(alpha / 255.0f)];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
        } @finally {
            
        }
    }
    
    // When finished, release the context
    CGContextRelease(cgctx);
    // Free image data memory for the context
    if (data) {
        free(data);
    }
    
    return color;
}

- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef)inImage {
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData;
    size_t bitmapByteCount;
    size_t bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow = pixelsWide * 4;
    bitmapByteCount = bitmapBytesPerRow * pixelsHigh;
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL) {
        fprintf(stderr, "CY_Error allocating color spacen");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc(bitmapByteCount);
    if (bitmapData == NULL) {
        fprintf(stderr, "CY_Memory not allocated!");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    if (context == NULL) {
        free(bitmapData);
        fprintf(stderr, "CY_Context not created!");
    }
    
    // Make sure and release colorspace before returning
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

- (UIImage *)cc_imageWithBrightness:(CGFloat)brightness {
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:inputImage forKey:kCIInputImageKey];
    [lighten setValue:@(brightness) forKey:@"inputBrightness"];
    //  饱和度      0---2
    //  [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputSaturation"];
    //  亮度  10   -1---1
    //  [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputBrightness"];
    //  对比度 -11  0---4
    //  [filter setValue:[NSNumber numberWithFloat:2] forKey:@"inputContrast"];
    
    CIImage *outputImage = [lighten valueForKey:kCIOutputImageKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
    UIImage *brighterImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return brighterImage;
}

- (UIImage *)cc_imageByApplyingAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *(^)(CGFloat))cc_imageWithAlpha {
    return ^UIImage *(CGFloat alpha) {
        return [self cc_imageByApplyingAlpha:alpha];
    };
}

@end


@implementation UIColor (CY_ImageCategory)

- (UIImage *)cc_solidImage {
    return [UIImage cc_imageWithColor:self];
}

@end


@interface CY_ImageCache ()
@property (nonatomic, strong) NSDictionary *cc_cacheDictionary;
@end

@implementation CY_ImageCache

+ (instancetype)cc_sharedCache {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSDictionary *)cc_cacheDictionary {
    if (_cc_cacheDictionary == nil) {
        _cc_cacheDictionary = [[NSDictionary alloc] init];
    }
    return _cc_cacheDictionary;
}

- (void)cc_storeImage:(UIImage *)image forColor:(UIColor *)color {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.cc_cacheDictionary];
    [dict setObject:image forKey:color];
    self.cc_cacheDictionary = dict.copy;
}

- (UIImage *)cc_imageWithContains:(UIColor *)color {
    for (int i = 0; i < self.cc_cacheDictionary.allKeys.count; i++) {
        UIColor *h_color = self.cc_cacheDictionary.allKeys[i];
        if ([h_color cc_isEqualToColor:color]) {
            return self.cc_cacheDictionary.allValues[i];
        }
    }
    return false;
}

- (UIImage *)cc_imageFromCacheForColor:(UIColor *)color {
    UIImage *image = [self cc_imageWithContains:color];
    if (image == nil) {
        image = [UIImage cc_imageWithColor:color];
        [self cc_storeImage:image forColor:color];
    }
    return image;
}

@end
