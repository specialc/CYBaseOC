//
//  CY_NormalTextField.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseTextField.h"
#import "CY_Lib.h"

@interface CY_NormalTextField : CY_BaseTextField


/**
 maxLength 长度上限，默认为0，也就是不做长度限制
 maxLength的实现依赖于下面的delegate函数
 // - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 如果自行实现该delegate函数，则可调用isReachMaxLengthWithCharactersInRange函数来做判断
 */
@property (nonatomic, assign) NSInteger maxLength;
// 允许最大的UTF8字节长度
@property (nonatomic, assign) unsigned long maxLengthOfUTF8;
// 允许最大的ASCII字节长度
@property (nonatomic, assign) unsigned long maxLengthOfASCII;

@property (nonatomic, weak) id<UITextFieldDelegate> cc_normalTextFieldDelegate;

// 是否达到输入的上限
- (BOOL)isReachMaxLengthWithCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

