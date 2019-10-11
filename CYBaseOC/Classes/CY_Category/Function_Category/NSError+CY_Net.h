//
//  NSError+CY_Net.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/3.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kPythiaUrlErrorDomain = @"com.weicaifu.wcf";
static NSInteger kUrlNormalErrorDode = -9;

@interface NSError (CY_Net)
+ (instancetype)errorWithCode:(NSInteger)code msg:(NSString *)msg;
+ (instancetype)errorWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data;
@property (nonatomic, copy, readonly) NSString *msg;
@property (nonatomic, strong, readonly) id data;
@end
