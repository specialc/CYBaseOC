//
//  CY_AmountTextField.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_AmountTextField.h"

#pragma mark - CY_AmountTextFieldHelper

@interface CY_AmountTextFieldHelper () <UITextFieldDelegate>
@property (nonatomic, weak) CY_AmountTextField *textField;
@end

@implementation CY_AmountTextFieldHelper

- (instancetype)initWithTextField:(CY_AmountTextField *)textField {
    self = [super init];
    if (self) {
        self.textField = textField;
        self.textField.delegate = self;
    }
    return self;
}

// 获得整数部分
- (NSString *)getIntegerPart:(NSString *)amount {
    NSRange range = [amount rangeOfString:@"."];
    if (range.location != NSNotFound) {
        return [amount substringToIndex:range.location];
    }
    else {
        return amount;
    }
}

// 获得小数部分
- (NSString *)getDecimalPart:(NSString *)amount {
    NSRange range = [amount rangeOfString:@"."];
    if (range.location != NSNotFound) {
        return [amount substringWithRange:NSMakeRange(range.location + 1, amount.length - range.location - 1)];
    }
    else {
        return @"";
    }
}

#pragma mark - UITextFieldDelegate

// 在CY_AmountTextField，此delegate函数不会被转发，请注意！
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    CY_AmountTextField *amountTextField = (CY_AmountTextField *)textField;
    NSString *aString = [amountTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    // 最多只能包含一个@"."
    if ([string isEqualToString:@"."]) {
        if ([amountTextField.text rangeOfString:@"."].location != NSNotFound) {
            return NO;
        }
    }
    
    // 整数部分不能超过上限，在maxIntegerCount不为0的时候判断
    if (amountTextField.cc_maxIntegerCount != 0) {
        NSString *amountIntegerPart = [self getIntegerPart:aString];
        if (amountIntegerPart.length > amountTextField.cc_maxIntegerCount) {
            return NO;
        }
    }
    
    // 小数部分不能超过上限，在maxDecimalCount不为0的时候判断（默认maxDecimalCount为2）
    if (amountTextField.cc_maxDecimalCount != 0) {
        NSString *amountDecimalPart = [self getDecimalPart:aString];
        if (amountDecimalPart.length > amountTextField.cc_maxDecimalCount) {
            return NO;
        }
    }
    
    return YES;
}

// 下面函数都是转发UITextFieldDelegate。。。
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_AmountTextField *)textField).cc_amountTextFieldDelegate;
    
    if ([pDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [pDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_AmountTextField *)textField).cc_amountTextFieldDelegate;
    
    if ([pDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [pDelegate textFieldShouldClear:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_AmountTextField *)textField).cc_amountTextFieldDelegate;
    
    if ([pDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [pDelegate textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_AmountTextField *)textField).cc_amountTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [pDelegate textFieldShouldReturn:textField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_AmountTextField *)textField).cc_amountTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [pDelegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_AmountTextField *)textField).cc_amountTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [pDelegate textFieldDidEndEditing:textField];
    }
}

@end


#pragma mark - CY_AmountTextField

@interface CY_AmountTextField ()
@property (nonatomic, strong) CY_AmountTextFieldHelper *helper;
@end

@implementation CY_AmountTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (NSString *)cc_getAmountText {
    if ([self.text isEqualToString:@""]) {
        return @"0";
    }
    else if ([self.text isEqualToString:@"."]) {
        return @"0";
    }
    else {
        NSRange range = [self.text rangeOfString:@"."];
        if (range.location == 0) {
            NSMutableString *str = [[NSMutableString alloc] initWithString:@"0"];
            [str appendString:self.text];
            return str;
        }
        else if (range.location == (self.text.length - 1)) {
            NSMutableString *str = [[NSMutableString alloc] initWithString:self.text];
            [str appendString:@"0"];
            return str;
        }
        return self.text;
    }
}

- (void)cc_setTextFieldMaxIntegerCount:(NSInteger)count {
    _cc_maxIntegerCount = count;
}

#pragma mark - Private Methods

- (void)commonInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.borderStyle = UITextBorderStyleNone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.keyboardType = UIKeyboardTypeDecimalPad;
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _cc_maxIntegerCount = 0;
    _cc_maxDecimalCount = 2;
    _helper = [[CY_AmountTextFieldHelper alloc] initWithTextField:self];
}

- (void)textFieldChanged:(UITextField *)textField {
    
}

@end
