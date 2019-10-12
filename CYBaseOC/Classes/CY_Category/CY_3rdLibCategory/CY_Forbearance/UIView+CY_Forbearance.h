//
//  UIView+CY_Forbearance.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface UIView (CY_Forbearance)
@property (nonatomic, assign) UILayoutPriority horizontalHuggingPriority;
@property (nonatomic, assign) UILayoutPriority horizontalCompressionResistancePriority;
@property (nonatomic, assign) UILayoutPriority verticalHuggingPriority;
@property (nonatomic, assign) UILayoutPriority verticalCompressionResistancePriority;
@end
