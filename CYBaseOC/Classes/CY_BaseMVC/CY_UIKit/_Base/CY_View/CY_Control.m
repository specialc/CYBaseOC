//
//  CY_Control.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_Control.h"

@implementation CY_Control

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self cc_loadViews];
        [self cc_layoutConstraints];
    }
    return self;
}

#pragma mark - Subview处理函数

- (void)cc_loadViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = UIColor.clearColor;
}

- (void)cc_layoutConstraints {
    
}

@end
