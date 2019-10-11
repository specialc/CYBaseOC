//
//  UIView+CY_ShorthandAdditions.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIView+CY_ShorthandAdditions.h"

#define MAS_ATTR_FORWARD(attr)  \
- (MASViewAttribute *)attr {    \
    return [self mas_##attr];   \
}

@implementation UIView (CY_ShorthandAdditions)

//MAS_ATTR_FORWARD(top);
//MAS_ATTR_FORWARD(left);
//MAS_ATTR_FORWARD(bottom);
//MAS_ATTR_FORWARD(right);
//MAS_ATTR_FORWARD(leading);
//MAS_ATTR_FORWARD(trailing);
//MAS_ATTR_FORWARD(width);
//MAS_ATTR_FORWARD(height);
//MAS_ATTR_FORWARD(centerX);
//MAS_ATTR_FORWARD(centerY);
//MAS_ATTR_FORWARD(baseline);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

//MAS_ATTR_FORWARD(firstBaseline);
//MAS_ATTR_FORWARD(lastBaseline);

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

//MAS_ATTR_FORWARD(leftMargin);
//MAS_ATTR_FORWARD(rightMargin);
//MAS_ATTR_FORWARD(topMargin);
//MAS_ATTR_FORWARD(bottomMargin);
//MAS_ATTR_FORWARD(leadingMargin);
//MAS_ATTR_FORWARD(trailingMargin);
//MAS_ATTR_FORWARD(centerXWithinMargins);
//MAS_ATTR_FORWARD(centerYWithinMargins);

#endif

//- (MASViewAttribute *(^)(NSLayoutAttribute))attribute {
//    return [self mas_attribute];
//}

- (NSArray *)makeConstraints:(void (^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void (^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void (^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end
