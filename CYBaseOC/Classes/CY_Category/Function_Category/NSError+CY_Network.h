//
//  NSError+CY_Network.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

static NSString *kPythiaURLErrorDomain = @"com.weicaifu.wcf";
static NSInteger kURLNormalErrorCode = -9;

@interface NSError (CY_Network)

+ (instancetype)cc_errorWithCode:(NSInteger)code msg:(NSString *)msg;
+ (instancetype)cc_errorWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data;

@property (nonatomic, copy, readonly) NSString *msg;
@property (nonatomic, strong, readonly) id data;

@end

