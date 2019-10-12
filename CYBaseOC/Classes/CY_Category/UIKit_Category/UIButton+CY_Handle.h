//
//  UIButton+CY_Handle.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/3.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  对UIButton操作enabled的分类，通过判断checkButton是否selected或textField是否为空
 */

#import <UIKit/UIKit.h>
#import "CY_Category.h"
#import "CY_Lib.h"

@interface UIButton (CY_Handle)

@property (nonatomic, strong) NSArray<UIButton *> *cc_handleCheckButtons;
@property (nonatomic, copy) BOOL(^cc_handleCheckButtonsBlock)(NSArray<UIButton *> *cc_handleCheckButtons);

@property (nonatomic, strong) NSArray<UITextField *> *cc_handleTextFields;
@property (nonatomic, copy) BOOL(^cc_handleTextFieldsBlock)(NSArray<UITextField *> *cc_handleTextFields);

@property (nonatomic, copy) BOOL(^cc_handleBlock)(void);

- (void)cc_addHandleCheckButtons:(NSArray<UIButton *> *)cc_handleCheckButtons;
// 会存在内存泄漏隐患，一定要用weakSelf
- (void)cc_addHandleCheckButtons:(NSArray<UIButton *> *)cc_handleCheckButtons handleCheckButtonsBlock:(BOOL (^)(NSArray<UIButton *> *cc_handleCheckButtons))cc_handleCheckButtonsBlock;

- (void)cc_addHandleTextFields:(NSArray<UITextField *> *)cc_handleTextFields;
// 会存在内存泄漏隐患，一定要用weakSelf
- (void)cc_addHandleTextFields:(NSArray<UITextField *> *)cc_handleTextFields handleTextFieldsBlock:(BOOL (^)(NSArray<UITextField *> *cc_handleTextFields))cc_handleTextFieldsBlock;

// 触发
- (void)cc_triggerHandle;

@end
