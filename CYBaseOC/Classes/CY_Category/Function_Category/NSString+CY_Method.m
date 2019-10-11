//
//  NSString+CY_Method.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSString+CY_Method.h"

@implementation NSString (CY_Method)

- (NSNumber *)cc_numberValue {
    return @(self.doubleValue);
}

- (CGSize)cc_sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (NSRange)cc_fullRange {
    return [self rangeOfString:self];
}

- (NSURL *)cc_URL {
    return [NSURL URLWithString:self];
}

- (NSString *)cc_stringByAddingCNMobilePhoneFormat {
    NSMutableString *string = [NSMutableString stringWithString:self];
    if (self.length == 11) {
        [string insertString:@" " atIndex:3];
        [string insertString:@" " atIndex:8];
        return string;
    }
    return self;
}

@end


@implementation NSString (CY_Check)

+ (BOOL)cc_isNullOrEmpty:(NSString *)key {
    if (key == nil) {
        return YES;
    }
    return [key cc_isEmpty];
}

+ (BOOL)cc_isNullOrWhiteSpace:(NSString *)key {
    if (key == nil) {
        return YES;
    }
    if (![key isKindOfClass:[NSString class]]) {
        return YES;
    }
    return [key cc_isWhiteSpace];
}

- (BOOL)cc_isNotEmpty {
    return !self.cc_isEmpty;
}

- (BOOL)cc_isNotWhiteSpace {
    return !self.cc_isWhiteSpace;
}

- (BOOL)cc_hasCharacter {
    return self.cc_isNotEmpty;
}

- (BOOL)cc_hasCharacterExcludeWhiteSpace {
    return self.cc_isNotWhiteSpace;
}

- (BOOL)cc_isEmpty {
    return [self isEqualToString:@""];
}

- (BOOL)cc_isWhiteSpace {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] cc_isEmpty];
}

@end


@implementation NSString (CY_Localized)

- (NSString *)cc_localizedString {
    return [self cc_localizedStringWithConmment:nil];
}

- (NSString *)cc_localizedStringWithConmment:(NSString *)comment {
    return NSLocalizedString(self, comment);
}

@end
