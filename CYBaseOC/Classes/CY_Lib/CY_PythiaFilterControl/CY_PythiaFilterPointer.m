//
//  CY_PythiaFilterPointer.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaFilterPointer.h"

@implementation CY_PythiaFilterPointer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = false;
        _color = UIColor.orangeColor;
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.color.CGColor ?: UIColor.clearColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectInset(rect, 6, 6));
}

@end
