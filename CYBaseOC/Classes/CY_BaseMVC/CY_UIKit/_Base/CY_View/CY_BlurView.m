//
//  CY_BlurView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BlurView.h"

@interface CY_BlurView ()

@end

@implementation CY_BlurView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self cc_loadViews];
        [self cc_layoutConstraints];
    }
    return self;
}

#pragma mark - SubView处理函数

- (void)cc_loadViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)cc_layoutConstraints {
    
}

@end
