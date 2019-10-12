//
//  CY_AmountTextField.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseTextField.h"
#import "CY_Lib.h"

#pragma mark - CY_AmountTextFieldHelper

@interface CY_AmountTextFieldHelper : NSObject

@end


#pragma mark - CY_AmountTextField

@interface CY_AmountTextField : CY_BaseTextField
@property (nonatomic, assign) NSInteger cc_maxIntegerCount;
@property (nonatomic, assign) NSInteger cc_maxDecimalCount;
@property (nonatomic, weak) id<UITextFieldDelegate> cc_amountTextFieldDelegate;

- (void)cc_setTextFieldMaxIntegerCount:(NSInteger)count;
- (NSString *)cc_getAmountText;
@end

