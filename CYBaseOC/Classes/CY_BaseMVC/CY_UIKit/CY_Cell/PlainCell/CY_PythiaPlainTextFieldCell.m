//
//  CY_PythiaPlainTextFieldCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaPlainTextFieldCell.h"
#import "CY_IDCardKeyboardView.h"

@interface CY_PythiaPlainTextFieldCell () <CY_IDCardKeyboardViewDelegate>
@property (nonatomic, assign) NSRange selectRange;

@end

@implementation CY_PythiaPlainTextFieldCell

- (void)cc_loadViews {
    [super cc_loadViews];
    
    _contentTextFieldLeftSpace = 0;
    _textFieldType = CY_PythiaPlainTextFieldTypeNormal;
    [self resetTextField];
}

- (void)resetTextField {
    UITextField *temptf = self.contentTextField;
    if (!temptf) {
        
    }
    
    [self.contentTextField removeFromSuperview];
    
    switch (self.textFieldType) {
        case CY_PythiaPlainTextFieldTypeNormal:
            {
                CY_NormalTextField *textField = [[CY_NormalTextField alloc] init];
                textField.textColor = @"#383838".cc_color;
                textField.font = @"15px".cc_font;
                textField.cc_placeHolderFont = @"15px".cc_font;
                textField.cc_placeHolderColor = @"#DDDDDD".cc_color;
                textField.placeholder = @"请输入".cc_localizedString;
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                [self.contentView addSubview:textField];
                self.contentTextField = textField;
            }
            break;
            
        case CY_PythiaPlainTextFieldTypeAmount:
        {
            CY_AmountTextField *textField = [[CY_AmountTextField alloc] init];
            textField.textColor = @"#383838".cc_color;
            textField.font = @"15px".cc_font;
            textField.cc_placeHolderFont = @"15px".cc_font;
            textField.cc_placeHolderColor = @"#DDDDDD".cc_color;
            textField.placeholder = @"请输入金额".cc_localizedString;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            [self.contentView addSubview:textField];
            self.contentTextField = textField;
        }
            break;
            
        case CY_PythiaPlainTextFieldTypeIDCard:
        {
            CY_NormalTextField *textField = [[CY_NormalTextField alloc] init];
            textField.textColor = @"#383838".cc_color;
            textField.font = @"15px".cc_font;
            textField.cc_placeHolderFont = @"15px".cc_font;
            textField.cc_placeHolderColor = @"#DDDDDD".cc_color;
            textField.placeholder = @"请输入身份证号码".cc_localizedString;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            textField.maxLength = 18;
            [self.contentView addSubview:textField];
            self.contentTextField = textField;
            
            CY_IDCardKeyboardView *keyboard = [[CY_IDCardKeyboardView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 216)];
            keyboard.delegate = self;
            textField.inputView = keyboard;
        }
            break;
            
        case CY_PythiaPlainTextFieldTypePhone:
        {
            CY_PhoneTextField *textField = [[CY_PhoneTextField alloc] init];
            textField.textColor = @"#383838".cc_color;
            textField.font = @"15px".cc_font;
            textField.cc_placeHolderFont = @"15px".cc_font;
            textField.cc_placeHolderColor = @"#DDDDDD".cc_color;
            textField.placeholder = @"请输入手机号".cc_localizedString;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            [self.contentView addSubview:textField];
            self.contentTextField = textField;
        }
            break;
            
        default:
            break;
    }
}

- (void)cc_layoutConstraints {
    [super cc_layoutConstraints];
    
    [self.contentTextField remakeConstraints:^(MASConstraintMaker *make) {
        if (self.contentTextFieldLeftSpace) {
            make.left.equalTo(self.contentTextFieldLeftSpace);
        }
        else {
            make.left.equalTo(self.titleLabel.mas_right).offset(8);
        }
        make.right.equalTo(self.contentLabel);
        make.top.bottom.equalTo(0);
    }];
}

- (void)setContentTextFieldLeftSpace:(CGFloat)contentTextFieldLeftSpace {
    _contentTextFieldLeftSpace = contentTextFieldLeftSpace;
    [self cc_layoutConstraints];
}

- (void)setTextFieldType:(CY_PythiaPlainTextFieldType)textFieldType {
    _textFieldType = textFieldType;
    [self resetTextField];
    [self cc_layoutConstraints];
}

- (CY_NormalTextField *)cc_normalTextField {
    if (self.textFieldType == CY_PythiaPlainTextFieldTypeNormal) {
        return (id)self.contentTextField;
    }
    return nil;
}
- (CY_PhoneTextField *)cc_phoneTextField {
    if (self.textFieldType == CY_PythiaPlainTextFieldTypePhone) {
        return (id)self.contentTextField;
    }
    return nil;
}

- (CY_AmountTextField *)cc_amountTextField {
    if (self.textFieldType == CY_PythiaPlainTextFieldTypeAmount) {
        return (id)self.contentTextField;
    }
    return nil;
}

- (CY_NormalTextField *)cc_IDCardTextField {
    if (self.textFieldType == CY_PythiaPlainTextFieldTypeIDCard) {
        return (id)self.contentTextField;
    }
    return nil;
}

#pragma mark - CY_IDCardKeyboardDelegate

- (void)numberKeyboardBackspace {
    if (self.cc_IDCardTextField && self.cc_IDCardTextField.text.length != 0) {
        _selectRange = [self.cc_IDCardTextField selectedRange];
        if (_selectRange.location > 0) {
            NSMutableString *textStr = [NSMutableString stringWithString:self.cc_IDCardTextField.text];
            [textStr replaceCharactersInRange:NSMakeRange(_selectRange.location - 1, 1) withString:@""];
            self.cc_IDCardTextField.text = textStr;
            _selectRange = NSMakeRange(_selectRange.location - 1, 1);
            [self.cc_IDCardTextField insertSelectedRange:_selectRange];
        }
    }
    [self.cc_IDCardTextField sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)numberKeyboardInput:(NSString *)number {
    if (self.cc_IDCardTextField && self.cc_IDCardTextField.text.length < 18) {
        _selectRange = [self.cc_IDCardTextField selectedRange];
        NSMutableString *textStr = [NSMutableString stringWithString:self.cc_IDCardTextField.text];
        if (!_selectRange.location) {
            [textStr insertString:[NSString stringWithFormat:@"%@", number] atIndex:0];
            self.cc_IDCardTextField.text = textStr;
            _selectRange = NSMakeRange(1, 1);
            [self.cc_IDCardTextField insertSelectedRange:_selectRange];
        }
        else {
            [textStr insertString:[NSString stringWithFormat:@"%@", number] atIndex:_selectRange.location];
            self.cc_IDCardTextField.text = textStr;
            _selectRange = NSMakeRange(_selectRange.location + 1, 1);
            [self.cc_IDCardTextField insertSelectedRange:_selectRange];
        }
    }
    [self.cc_IDCardTextField sendActionsForControlEvents:UIControlEventEditingChanged];
}

@end
