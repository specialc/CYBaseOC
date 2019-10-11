//
//  CY_PhoneTextField.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PhoneTextField.h"

@interface CY_PhoneTextFieldHelper : NSObject <UITextFieldDelegate>
@property (nonatomic, weak) CY_PhoneTextField *textField;
@end

@implementation CY_PhoneTextFieldHelper

- (instancetype)initWithPhoneTextField:(CY_PhoneTextField *)textField {
    self = [super init];
    if (self) {
        self.textField = textField;
        self.textField.delegate = self;
    }
    return self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Note textField's current state before performing the change, in case
    // reformatTextField wants to revert it
    self.textField.cc_previousTextFieldContent = textField.text;
    self.textField.cc_previousSelection = textField.selectedTextRange;
    
    id<UITextFieldDelegate> pDelegate = ((CY_PhoneTextField *)textField).cc_phoneTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [pDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_PhoneTextField *)textField).cc_phoneTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [pDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_PhoneTextField *)textField).cc_phoneTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [pDelegate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_PhoneTextField *)textField).cc_phoneTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [pDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_PhoneTextField *)textField).cc_phoneTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [pDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_PhoneTextField *)textField).cc_phoneTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [pDelegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((CY_PhoneTextField *)textField).cc_phoneTextFieldDelegate;
    if ([pDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [pDelegate textFieldDidEndEditing:textField];
    }
}

@end


@interface CY_PhoneTextField ()

@property (nonatomic, strong) CY_PhoneTextFieldHelper *helper;

- (void)setupFormat;
+ (NSString *)formatMobile:(NSString *)string;
+ (NSString *)removeFormat:(NSString *)string;

@end

@implementation CY_PhoneTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupFormat];
    }
    return self;
}


/**
 设置格式化输出
 */
- (void)setupFormat {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.borderStyle = UITextBorderStyleNone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.keyboardType = UIKeyboardTypeNumberPad;
    
    self.helper = [[CY_PhoneTextFieldHelper alloc] initWithPhoneTextField:self];
    [self addTarget:self action:@selector(reformatAsCardNumber:) forControlEvents:UIControlEventEditingChanged];
}

// Version 1.2
// Source and explanation: http://stackoverflow.com/a/19161529/1709587
- (void)reformatAsCardNumber:(UITextField *)textField {
    // In order to make the cursor end up positioned correctly, we need to
    // explicitly reposition it after we inject spaces into the text.
    // targetCursorPosition keeps track of where the cursor needs to end up as
    // we modify the string, and at the end we set the cursor position to it.
    NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *cardNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPosition];
    if ([cardNumberWithoutSpaces length] > 11) {
        // If the user is trying to enter more than 19 digits, we prevent
        // their change, leaving the text field in  its previous state.
        // While 16 digits is usual, credit card numbers have a hard
        // maximum of 19 digits defined by ISO standard 7812-1 in section
        // 3.8 and elsewhere. Applying this hard maximum here rather than
        // a maximum of 16 ensures that users with unusual card numbers
        // will still be able to enter their card number even if the
        // resultant formatting is odd.
        [textField setText:_cc_previousTextFieldContent];
        textField.selectedTextRange = _cc_previousSelection;
        return;
    }
    
    NSString *cardNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:cardNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPosition];
    textField.text = cardNumberWithSpaces;
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:targetCursorPosition];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
}

/*
 *   Removes non-digits from the string, decrementing `cursorPosition` as
 *   appropriate so that, for instance, if we pass in `@"1111 1123 1111"`
 *   and a cursor position of `8`, the cursor position will be changed to
 *   `7` (keeping it between the '2' and the '3' after the spaces are removed).
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition = *cursorPosition;
    NSMutableString *digitsOnlyString = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < [string length]; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        if (isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/*
 *   Inserts spaces into the string to format it as a credit card number,
 *   incrementing `cursorPosition` as appropriate so that, for instance, if we
 *   pass in `@"111111231111"` and a cursor position of `7`, the cursor position
 *   will be changed to `8` (keeping it between the '2' and the '3' after the
 *   spaces are added).
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSMutableString *stringWithAddedSpaces = [[NSMutableString alloc] init];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i = 0; i < [string length]; i++) {
        if (i <= 3) {
            if ((i > 0) && ((i % 3) == 0)) {
                [stringWithAddedSpaces appendString:@" "];
                if (i < cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        else {
            NSUInteger index = i - 3;
            if ((index > 0) && ((index % 4) == 0)) {
                [stringWithAddedSpaces appendString:@" "];
                if (i < cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

+ (NSString *)formatMobile:(NSString *)string {
    NSMutableString *stringWithAddedSpaces = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < [string length]; i++) {
        if (i <= 3) {
            if ((i > 0) && ((i % 3) == 0)) {
                [stringWithAddedSpaces appendString:@" "];
            }
        }
        else {
            NSUInteger index = i - 3;
            if ((index > 0) && ((index % 4) == 0)) {
                [stringWithAddedSpaces appendString:@" "];
            }
        }
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

+ (NSString *)removeFormat:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)cc_phoneText {
    return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (void)setCc_phoneText:(NSString *)cc_phoneText {
    self.text = cc_phoneText;
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

@end
