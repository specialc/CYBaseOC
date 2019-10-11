//
//  NSString+CY_Money.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/27.
//  Copyright © 2019 CY. All rights reserved.
//

/**
 *  操作金额的分类，包含金额加减乘除，金额比较大小，获取整数部分和小数部分等。
 */

#import <Foundation/Foundation.h>

@interface NSString (CY_Money)

#pragma mark - 金额比较

- (NSComparisonResult)cc_comparePrice:(NSString *)price;

// ==
- (BOOL)cc_isEqualToPrice:(NSString *)price;

// >
- (BOOL)cc_isGreaterThanPrice:(NSString *)price;

// >=
- (BOOL)cc_isGreaterThanOrEqualToPrice:(NSString *)price;

// <
- (BOOL)cc_isLessThanPrice:(NSString *)price;

// <=
- (BOOL)cc_isLessThanOrEqualToPrice:(NSString *)price;

// 加
- (NSString *)cc_priceByAdding:(NSString *)number;

// 减
- (NSString *)cc_priceBySubtracting:(NSString *)number;

// 乘
- (NSString *)cc_priceByMultiplyingBy:(NSString *)number;

// 除
- (NSString *)cc_priceByDividingBy:(NSString *)number;

// 按照舍入规则保留两位小数
- (NSString *)cc_priceByOmit;


#pragma mark - 获取

// 得到金额的整数位数
- (NSInteger)cc_priceIntegerPartCount;

// 获得小数部分
- (NSString *)cc_priceDecimalPart;

//
- (NSString *)cc_stringByAddingThousandsSeparator;

@end

