//
//  UIControl+CY_Touch.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIControl+CY_Touch.h"
#import <objc/runtime.h>

@implementation UIControl (CY_Touch)

- (void)setTouchUpInsideAction:(void (^)(UIButton *))touchUpInsideAction {
    objc_setAssociatedObject(self, @selector(touchUpInsideAction), touchUpInsideAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *))touchUpInsideAction {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)addTouchUpInsideAction:(void (^)(UIButton *))action {
    self.touchUpInsideAction = action;
    [self addTarget:self action:@selector(cc_handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cc_handleTouchUpInside:(UIButton *)sender {
    __weak UIButton *weakSender = sender;
    if (self.touchUpInsideAction) {
        self.touchUpInsideAction(weakSender);
    }
}

@end
