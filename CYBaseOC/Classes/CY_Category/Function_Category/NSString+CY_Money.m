//
//  NSString+CY_Money.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSString+CY_Money.h"

@implementation NSString (CY_Money)

#pragma mark - 金额比较

- (NSComparisonResult)cc_comparePrice:(NSString *)price {
    NSDecimalNumber *priceNumber1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *priceNumber2 = [NSDecimalNumber decimalNumberWithString:price];
    NSComparisonResult result = [priceNumber1 compare:priceNumber2];
    return result;
}

- (BOOL)cc_isEqualToPrice:(NSString *)price {
    NSComparisonResult compareResult = [self cc_comparePrice:price];
    return compareResult == NSOrderedSame;
}

- (BOOL)cc_isGreaterThanPrice:(NSString *)price {
    NSComparisonResult compareResult = [self cc_comparePrice:price];
    return compareResult == NSOrderedDescending;
}

- (BOOL)cc_isGreaterThanOrEqualToPrice:(NSString *)price {
    NSComparisonResult compareResult = [self cc_comparePrice:price];
    return compareResult == NSOrderedDescending || compareResult == NSOrderedSame;
}

- (BOOL)cc_isLessThanPrice:(NSString *)price {
    NSComparisonResult compareResult = [self cc_comparePrice:price];
    return compareResult == NSOrderedAscending;
}

- (BOOL)cc_isLessThanOrEqualToPrice:(NSString *)price {
    NSComparisonResult compareResult = [self cc_comparePrice:price];
    return compareResult == NSOrderedAscending || compareResult == NSOrderedSame;
}

#pragma mark - 加减乘除 各保留两位

// 保留小数，默认保留两位
- (unsigned short)cc_pointOmit {
    return 2;
}

// 保留小数的Format -- 暂未使用
- (NSString *)cc_pointOmitFormat {
    switch ([self cc_pointOmit]) {
        case 0:
            return @"%.0f";
            break;
        case 1:
            return @"%.1f";
            break;
        case 2:
            return @"%.2f";
            break;
        case 3:
            return @"%.3f";
            break;
        case 4:
            return @"%.4f";
            break;
        case 5:
            return @"%.5f";
            break;
        case 6:
            return @"%.6f";
            break;
            
            
        default:
            return @"%.2f";
            break;
    }
}

// 舍入规则，默认只入不舍
- (NSRoundingMode)cc_roundingMode {
    return NSRoundUp;
}

// 配置舍入规则，以及小数点后保留几位
- (NSDecimalNumberHandler *)cc_behavior {
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:self.cc_roundingMode scale:self.cc_pointOmit raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
}

#pragma mark - 加减乘除

- (NSString *)cc_priceByAdding:(NSString *)number {
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [number1 decimalNumberByAdding:number2 withBehavior:self.cc_behavior];
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)cc_priceBySubtracting:(NSString *)number {
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [number1 decimalNumberBySubtracting:number2 withBehavior:self.cc_behavior];
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)cc_priceByMultiplyingBy:(NSString *)number {
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [number1 decimalNumberByMultiplyingBy:number2 withBehavior:self.cc_behavior];
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)cc_priceByDividingBy:(NSString *)number {
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [number1 decimalNumberByDividingBy:number2 withBehavior:self.cc_behavior];
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)cc_priceByOmit {
    return [self cc_priceByAdding:@"0"];
}


#pragma mark - 获取

// 得到金额的整数位数
- (NSInteger)cc_priceIntegerPartCount {
    NSString *integerPart;
    NSRange range = [self rangeOfString:@"."];
    if (range.location != NSNotFound) {
        integerPart = [self substringToIndex:range.location];
    }
    else {
        integerPart = self;
    }
    return integerPart.length;
}

// 获得小数部分
- (NSString *)cc_priceDecimalPart {
    NSRange range = [self rangeOfString:@"."];
    if (range.location != NSNotFound) {
        return [self substringWithRange:NSMakeRange(range.location + 1, self.length - range.location - 1)];
    }
    else {
        return @"";
    }
}

- (NSString *)cc_stringByAddingThousandsSeparator {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:@(self.doubleValue)];
    
    //    NSArray *numberCom = [self componentsSeparatedByString:@"."];
    //
    //    NSString *intSection;
    //    NSString *decimalSection;
    //
    //    // 非正常数字
    //    if (numberCom.count > 2) {
    //        return self;
    //    }
    //    // 包含小数点
    //    else if (numberCom.count == 2) {
    //        intSection = numberCom.firstObject;
    //        decimalSection = numberCom.lastObject;
    //    }
    //    // 不包含小数点
    //    else if (numberCom.count == 1) {
    //        intSection = numberCom.firstObject;
    //        decimalSection = nil;
    //    }
    //
    //
    //    // 计算位数
    //    int count = 0;
    //    long long int a = self.longLongValue;
    //    while (a != 0) {
    //        count++;
    //        a /= 10;
    //    }
    //
    //    NSMutableString *string = [NSMutableString stringWithString:intSection];
    //    NSMutableString *newstring = [NSMutableString string];
    //    while (count > 3) {
    //        count -= 3;
    //        NSRange rang = NSMakeRange(string.length - 3, 3);
    //        NSString *str = [string substringWithRange:rang];
    //        [newstring insertString:str atIndex:0];
    //        [newstring insertString:@"," atIndex:0];
    //        [string deleteCharactersInRange:rang];
    //    }
    //    [newstring insertString:string atIndex:0];
    //
    //    if (decimalSection) {
    //        [newstring appendString:@"."];
    //        [newstring appendString:decimalSection];
    //    }
    //
    //    return newstring;
}

@end
