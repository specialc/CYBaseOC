//
//  CY_KeyboardManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_KeyboardManager.h"

@interface CY_KeyboardManager ()

@end

@implementation CY_KeyboardManager

- (void)dealloc {
    [self cc_removeKeyboardObserver];
}

- (instancetype)initWithDelegate:(id<CY_KeyboardManagerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - Observer

- (void)cc_addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)cc_removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleKeyboardFrameChanged:(NSNotification *)notification {
    NSNumber *durationValue = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSValue *beginFrameValue = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    NSValue *endFrameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval duration = durationValue.doubleValue;
    CGRect keyboardBeginFrame = beginFrameValue.CGRectValue;
    CGRect keyboardEndFrame = endFrameValue.CGRectValue;
    BOOL isKeyboardShow = keyboardBeginFrame.origin.y > keyboardEndFrame.origin.y;
    
    // 如果frame没改变，则看当前显示还是隐藏
    if (CGRectEqualToRect(keyboardBeginFrame, keyboardEndFrame)) {
        isKeyboardShow = keyboardEndFrame.origin.y < [UIScreen mainScreen].bounds.size.height;
    }
    // 如果size改变了，则看当前是显示还是隐藏
    if (!CGSizeEqualToSize(keyboardBeginFrame.size, keyboardEndFrame.size)) {
        isKeyboardShow = keyboardEndFrame.origin.y < [UIScreen mainScreen].bounds.size.height;
    }
    if (isKeyboardShow) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cc_keyboardManager:showWithFrame:duration:)]) {
            [self.delegate cc_keyboardManager:self showWithFrame:keyboardEndFrame duration:duration];
        }
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cc_keyboardManager:hideWithFrame:duration:)]) {
            [self.delegate cc_keyboardManager:self hideWithFrame:keyboardEndFrame duration:duration];
        }
    }
}

@end
