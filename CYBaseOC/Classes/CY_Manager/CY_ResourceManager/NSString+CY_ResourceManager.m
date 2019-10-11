//
//  NSString+CY_ResourceManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSString+CY_ResourceManager.h"

@implementation NSString (CY_ResourceManager)

- (UIFont *)cc_font {
    return [[CY_ResourceManager cc_sharedInstance] cc_fontWithKey:self];
}

- (UIColor *)cc_color {
    return [[CY_ResourceManager cc_sharedInstance] cc_colorWithKey:self];
}

- (UIColor *(^)(CGFloat))cc_colorWithAlpha {
    return self.cc_colorWithAlpha;
}

- (UIImage *)cc_image {
    return [[CY_ResourceManager cc_sharedInstance] cc_imageWithKey:self];
}

- (UIImage *)cc_resizableImage {
    return self.cc_image.cc_resizableImage;
}

@end

@implementation UILabel (CY_AmountAdvanceDecline)

- (NSString *)cc_changeAmount {
    return self.text;
}

- (void)setCc_changeAmount:(NSString *)cc_changeAmount {
    self.text = cc_changeAmount;
    
    // <
    if ([self.text cc_isLessThanPrice:@"0"]) {
        self.textColor = @"#55C360".cc_color;
    }
    // >
    else if ([self.text cc_isGreaterThanPrice:@"0"]) {
        self.textColor = @"#FF2020".cc_color;
    }
    // =
    else {
        self.textColor = @"#A5A5A5".cc_color;
    }
}

@end
