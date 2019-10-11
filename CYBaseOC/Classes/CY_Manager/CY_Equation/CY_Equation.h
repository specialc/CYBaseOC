//
//  CY_Equation.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/9.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  判断类，正则表达式或其他比较：空白字符串、MobilePhone、Email、银行卡号、验证码、密码、姓名、身份证等
 */

#import <Foundation/Foundation.h>

@interface CY_Equation : NSObject

+ (BOOL)isMobilePhone:(NSString *)string;
+ (BOOL)isEmail:(NSString *)string;
+ (BOOL)isBankCard:(NSString *)string;
+ (BOOL)isSMSCode:(NSString *)string;
+ (BOOL)isPassword:(NSString *)string;
+ (BOOL)isName:(NSString *)name;
+ (BOOL)isIDCard:(NSString *)string;

@end
