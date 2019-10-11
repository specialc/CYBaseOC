//
//  CY_PythiaPlainTextFieldCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaPlainCell.h"

typedef NS_ENUM(NSUInteger, CY_PythiaPlainTextFieldType) {
    CY_PythiaPlainTextFieldTypeNormal, // 默认输入 CYNormalTextField
    CY_PythiaPlainTextFieldTypeIDCard, // 身份证输入框
    CY_PythiaPlainTextFieldTypeAmount, // 金额输入框
    CY_PythiaPlainTextFieldTypePhone,  // 手机输入框
};

@interface CY_PythiaPlainTextFieldCell : CY_PythiaPlainCell

// 在原有基础上取代contentLabel
@property (nonatomic, strong) UITextField *contentTextField;
// 距离左侧距离，默认为0，
@property (nonatomic, assign) CGFloat contentTextFieldLeftSpace;
// 输入框类型
@property (nonatomic, assign) CY_PythiaPlainTextFieldType textFieldType;

#pragma mark - 返回对应的TextField元控件
// PythiaPlainTextFieldTypeNormal
@property (nonatomic, strong, readonly) CY_NormalTextField *cc_normalTextField;
// PythiaPlainTextFieldTypeAmount
@property (nonatomic, strong, readonly) CY_AmountTextField *cc_amountTextField;
// PythiaPlainTextFieldTypeIDCard
@property (nonatomic, strong, readonly) CY_NormalTextField *cc_IDCardTextField;
// PythiaPlainTextFieldTypePhone
@property (nonatomic, strong, readonly) CY_PhoneTextField *cc_phoneTextField;

@end
