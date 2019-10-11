//
//  UIScrollView+CY_Category.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIScrollView+CY_Category.h"

@implementation UIScrollView (CY_Category)

- (CGFloat)cc_contentInsetLeft {
    return self.contentInset.left;
}

- (void)setCc_contentInsetLeft:(CGFloat)cc_contentInsetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = cc_contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)cc_contentInsetRight {
    return self.contentInset.right;
}

- (void)setCc_contentInsetRight:(CGFloat)cc_contentInsetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = cc_contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)cc_contentInsetTop {
    return self.contentInset.top;
}

- (void)setCc_contentInsetTop:(CGFloat)cc_contentInsetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = cc_contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)cc_contentInsetBottom {
    return self.contentInset.bottom;
}

- (void)setCc_contentInsetBottom:(CGFloat)cc_contentInsetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = cc_contentInsetBottom;
    self.contentInset = inset;
}

@end
