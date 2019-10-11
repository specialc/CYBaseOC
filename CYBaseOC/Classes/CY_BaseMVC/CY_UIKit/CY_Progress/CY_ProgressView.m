//
//  CY_ProgressView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_ProgressView.h"

@implementation CY_ProgressView

- (void)cc_loadViews {
    [super cc_loadViews];
    self.opaque = NO;
    _progressColor = UIColor.orangeColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.frame.size.height * 0.5;
    self.layer.masksToBounds = YES;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Fill Line
    rect.size.width *= self.progress;
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    CGContextFillRect(context, rect);
}

@end
