//
//  CY_PhoneTextField.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseTextField.h"
#import "CY_Lib.h"

@interface CY_PhoneTextField : CY_BaseTextField
@property (nonatomic, weak) id<UITextFieldDelegate> cc_phoneTextFieldDelegate;
@property (nonatomic, copy) NSString *cc_phoneText;
@property (nonatomic, strong) NSString *cc_previousTextFieldContent;
@property (nonatomic, strong) UITextRange *cc_previousSelection;
@end

