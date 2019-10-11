//
//  CY_BaseView.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseView.h"

@implementation CY_BaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self cc_loadViews];
        [self cc_layoutConstraints];
    }
    return self;
}

#pragma mark - CY_BaseViewProtocol

- (void)cc_loadViews {
//    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = UIColor.clearColor;
}

- (void)cc_layoutConstraints {
    
}

@end
