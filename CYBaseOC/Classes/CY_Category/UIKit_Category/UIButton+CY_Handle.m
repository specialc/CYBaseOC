//
//  UIButton+CY_Handle.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/3.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIButton+CY_Handle.h"

@implementation UIButton (CY_Handle)

static NSString *CY_HandleCheckButtonsKey = @"Mark.By.CY.HandleCheckButtons";
- (NSArray<UIButton *> *)cc_handleCheckButtons {
    return objc_getAssociatedObject(self, &CY_HandleCheckButtonsKey);
}
- (void)setCc_handleCheckButtons:(NSArray<UIButton *> *)cc_handleCheckButtons {
    objc_setAssociatedObject(self, &CY_HandleCheckButtonsKey, cc_handleCheckButtons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static NSString *CY_HandleCheckButtonsBlockKey = @"Mark.By.CY.HandleCheckButtonsBlock";
- (BOOL (^)(NSArray<UIButton *> *))cc_handleCheckButtonsBlock {
    id obj = objc_getAssociatedObject(self, &CY_HandleCheckButtonsBlockKey);
    return obj;
}
- (void)setCc_handleCheckButtonsBlock:(BOOL (^)(NSArray<UIButton *> *))cc_handleCheckButtonsBlock {
    objc_setAssociatedObject(self, &CY_HandleCheckButtonsBlockKey, cc_handleCheckButtonsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static NSString *CY_HandleCheckTextFieldsKey = @"Mark.By.CY.HandleCheckTextFieldsKey";
- (NSArray<UITextField *> *)cc_handleTextFields {
    return objc_getAssociatedObject(self, &CY_HandleCheckTextFieldsKey);
}
- (void)setCc_handleTextFields:(NSArray<UITextField *> *)cc_handleTextFields {
    objc_setAssociatedObject(self, &CY_HandleCheckTextFieldsKey, cc_handleTextFields, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static NSString *CY_HandleCheckTextFieldsBlockKey = @"Mark.By.CY.HandleCheckTextFieldsBlockKey";
- (BOOL (^)(NSArray<UITextField *> *))cc_handleTextFieldsBlock {
    return objc_getAssociatedObject(self, &CY_HandleCheckTextFieldsBlockKey);
}
- (void)setCc_handleTextFieldsBlock:(BOOL (^)(NSArray<UITextField *> *))cc_handleTextFieldsBlock {
    objc_setAssociatedObject(self, &CY_HandleCheckTextFieldsBlockKey, cc_handleTextFieldsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static void *CY_HandleBlockKey = &CY_HandleBlockKey;
- (BOOL (^)(void))cc_handleBlock {
    return objc_getAssociatedObject(self, &CY_HandleBlockKey);
}
- (void)setCc_handleBlock:(BOOL (^)(void))cc_handleBlock {
    objc_setAssociatedObject(self, &CY_HandleBlockKey, cc_handleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)cc_addHandleCheckButtons:(NSArray<UIButton *> *)cc_handleCheckButtons {
    [self cc_addHandleCheckButtons:cc_handleCheckButtons handleCheckButtonsBlock:NULL];
}
- (void)cc_addHandleCheckButtons:(NSArray<UIButton *> *)cc_handleCheckButtons handleCheckButtonsBlock:(BOOL (^)(NSArray<UIButton *> *))cc_handleCheckButtonsBlock {
    self.cc_handleCheckButtons = cc_handleCheckButtons;
    self.cc_handleCheckButtonsBlock = cc_handleCheckButtonsBlock;
    for (UIButton *checkButton in cc_handleCheckButtons) {
        [checkButton addTarget:self action:@selector(cc_handleCheckButtonValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self cc_triggerHandle];
}

- (void)cc_addHandleTextFields:(NSArray<UITextField *> *)cc_handleTextFields {
    [self cc_addHandleTextFields:cc_handleTextFields handleTextFieldsBlock:NULL];
}

- (void)cc_addHandleTextFields:(NSArray<UITextField *> *)cc_handleTextFields handleTextFieldsBlock:(BOOL (^)(NSArray<UITextField *> *))cc_handleTextFieldsBlock {
    self.cc_handleTextFieldsBlock = cc_handleTextFieldsBlock;
    self.cc_handleTextFields = cc_handleTextFields;
    for (UITextField *textField in cc_handleTextFields) {
        [textField addTarget:self action:@selector(cc_handleTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    [self cc_triggerHandle];
}

#pragma mark - Touches

- (void)cc_handleCheckButtonValueChanged:(UIButton *)sender {
    [self cc_triggerHandle];
}

- (void)cc_handleTextFieldEditingChanged:(UITextField *)sender {
    [self cc_triggerHandle];
}

#pragma mark -

- (void)cc_triggerHandle {
    BOOL enabled = YES;
    
    // 通用
    if (self.cc_handleBlock) {
        enabled = self.cc_handleBlock();
    }
    if (!enabled) {
        self.enabled = enabled;
        return;
    }
    
    // 复选按钮
    if (self.cc_handleCheckButtons) {
        if (self.cc_handleCheckButtonsBlock) {
            enabled = self.cc_handleCheckButtonsBlock(self.cc_handleCheckButtons);
        }
        else {
            enabled = [self cc_EnabledForCheckButtons];
        }
    }
    if (!enabled) {
        self.enabled = enabled;
        return;
    }
    
    // 输入框
    if (self.cc_handleTextFields) {
        if (self.cc_handleTextFieldsBlock) {
            enabled = self.cc_handleTextFieldsBlock(self.cc_handleTextFields);
        }
        else {
            enabled = [self cc_EnabledForTextFields];
        }
    }
    if (!enabled) {
        self.enabled = enabled;
        return;
    }
    
    // 最后
    self.enabled = enabled;
}

#pragma mark - Methods

- (BOOL)cc_EnabledForCheckButtons {
    for (UIButton *checkButton in self.cc_handleCheckButtons) {
        if (!checkButton.isSelected) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)cc_EnabledForTextFields {
    for (UITextField *textField in self.cc_handleTextFields) {
        if ([NSString cc_isNullOrWhiteSpace:textField.text]) {
            return NO;
        }
    }
    return YES;
}

@end
