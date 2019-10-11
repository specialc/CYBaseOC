//
//  CY_NormalTextField.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_NormalTextField.h"

#pragma mark - CY_NormalTextFieldHelper

@interface CY_NormalTextFieldHelper : NSObject <UITextFieldDelegate>
@property (nonatomic, weak) CY_NormalTextField *textField;
@end

@implementation CY_NormalTextFieldHelper

- (instancetype)initWithTextField:(CY_NormalTextField *)textField {
    self = [super init];
    if (self) {
        self.textField = textField;
        self.textField.delegate = self;
    }
    return self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    id<UITextFieldDelegate> pDelegate = ((CY_NormalTextField *)textField).cc_normalTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [pDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    // 判断是否达到输入上限
    CY_NormalTextField *my_textField = (CY_NormalTextField *)textField;
    // 达到上限就禁止继续输入
    if ([my_textField isReachMaxLengthWithCharactersInRange:range replacementString:string]) {
        return NO;
    }
    return YES;
}

#pragma mark - 下面函数都是转发UITextFieldDelegate...

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_NormalTextField *)textField).cc_normalTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [pDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_NormalTextField *)textField).cc_normalTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [pDelegate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_NormalTextField *)textField).cc_normalTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [pDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_NormalTextField *)textField).cc_normalTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [pDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_NormalTextField *)textField).cc_normalTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [pDelegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_NormalTextField *)textField).cc_normalTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [pDelegate textFieldDidEndEditing:textField];
    }
}

@end


#pragma mark - CY_NormalTextField

@interface CY_NormalTextField ()
@property (nonatomic, strong) CY_NormalTextFieldHelper *helper;
@end

@implementation CY_NormalTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

+ (instancetype)cc_normalTextField {
    return [[self alloc] init];
}

+ (instancetype)cc_normalTextFieldWithDelegate:(id)delegate {
    CY_NormalTextField *textField = [[self alloc] init];
    textField.cc_normalTextFieldDelegate = delegate;
    return textField;
}

// 是否达到输入的上限
- (BOOL)isReachMaxLengthWithCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 删除特殊处理
    if (string.length == 0) {
        return NO;
    }
    
    NSString *aString = [self.text stringByReplacingCharactersInRange:range withString:string];
    if (self.maxLength) {
        return (aString.length > self.maxLength);
    }
    else if (self.maxLengthOfUTF8) {
        const char *utf8_string = [aString UTF8String];
        if (utf8_string == NULL) {
            return NO;
        }
        unsigned long utf8_str_len = strlen(utf8_string);
        return utf8_str_len > self.maxLengthOfUTF8;
    }
    else if (self.maxLengthOfASCII) {
        const char *ascii_string = [aString cStringUsingEncoding:NSASCIIStringEncoding];
        if (ascii_string == NULL) {
            return NO;
        }
        unsigned long ascii_str_len = strlen(ascii_string);
        return ascii_str_len > self.maxLengthOfASCII;
    }
    return NO;
}

#pragma mark - Private Methods

- (void)commonInit {
    self.translatesAutoresizingMaskIntoConstraints = YES;
    self.borderStyle = UITextBorderStyleNone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.maxLength = 0;
    _helper = [[CY_NormalTextFieldHelper alloc] initWithTextField:self];
}

- (void)textFieldChanged:(UITextField *)textField {
    
}

@end
