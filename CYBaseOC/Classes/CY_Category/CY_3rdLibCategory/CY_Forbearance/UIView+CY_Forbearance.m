//
//  UIView+CY_Forbearance.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIView+CY_Forbearance.h"

@implementation UIView (CY_Forbearance)

- (UILayoutPriority)horizontalHuggingPriority {
    return [self contentHuggingPriorityForAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setHorizontalHuggingPriority:(UILayoutPriority)horizontalHuggingPriority {
    [self setContentHuggingPriority:horizontalHuggingPriority forAxis:UILayoutConstraintAxisHorizontal];
}

- (UILayoutPriority)horizontalCompressionResistancePriority {
    return [self contentCompressionResistancePriorityForAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setHorizontalCompressionResistancePriority:(UILayoutPriority)horizontalCompressionResistancePriority {
    [self setContentCompressionResistancePriority:horizontalCompressionResistancePriority forAxis:UILayoutConstraintAxisHorizontal];
}

- (UILayoutPriority)verticalHuggingPriority {
    return [self contentHuggingPriorityForAxis:UILayoutConstraintAxisVertical];
}

- (void)setVerticalHuggingPriority:(UILayoutPriority)verticalHuggingPriority {
    [self setContentHuggingPriority:verticalHuggingPriority forAxis:UILayoutConstraintAxisVertical];
}

- (UILayoutPriority)verticalCompressionResistancePriority {
    return [self contentCompressionResistancePriorityForAxis:UILayoutConstraintAxisVertical];
}

- (void)setVerticalCompressionResistancePriority:(UILayoutPriority)verticalCompressionResistancePriority {
    [self setContentCompressionResistancePriority:verticalCompressionResistancePriority forAxis:UILayoutConstraintAxisVertical];
}

@end
