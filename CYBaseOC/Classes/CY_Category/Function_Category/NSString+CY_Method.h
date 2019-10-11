//
//  NSString+CY_Method.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CY_Method)

@property (nonatomic, strong, readonly) NSNumber *cc_numberValue;
@property (nonatomic, assign, readonly) NSRange cc_fullRange;

- (NSURL *)cc_URL;
- (CGSize)cc_sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

// 将手机号码字符串转成 3 4 4 格式：131 1111 1111
- (NSString *)cc_stringByAddingCNMobilePhoneFormat;

@end


@interface NSString (CY_Check)

+ (BOOL)cc_isNullOrEmpty:(NSString *)key;
+ (BOOL)cc_isNullOrWhiteSpace:(NSString *)key;


/**
 if self is nil, return NO;
 if self is empty, return NO;
 other return YES;
 */
@property (nonatomic, assign, readonly) BOOL cc_isNotEmpty;
@property (nonatomic, assign, readonly) BOOL cc_isNotWhiteSpace;
@property (nonatomic, assign, readonly) BOOL cc_hasCharacter;
@property (nonatomic, assign, readonly) BOOL cc_hasCharacterExcludeWhiteSpace;

// It's deprecated, if self is nil, will return false, but it's not an expected value.
@property (nonatomic, assign, readonly) BOOL cc_isEmpty;
@property (nonatomic, assign, readonly) BOOL cc_isWhiteSpace;

@end

@interface NSString (CY_Localized)

@property (nonatomic, strong, readonly) NSString *cc_localizedString;

- (NSString *)cc_localizedStringWithConmment:(NSString *)comment;

@end
