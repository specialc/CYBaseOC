//
//  NSError+CY_Net.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/3.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSError+CY_Net.h"

@implementation NSError (CY_Net)

+ (instancetype)errorWithCode:(NSInteger)code msg:(NSString *)msg {
    id err = [[self alloc] initWithDomain:kPythiaURLErrorDomain code:code userInfo:@{@"msg": msg ?: @""}];
    return err;
}

+ (instancetype)errorWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data {
    id err = [[self alloc] initWithDomain:kPythiaURLErrorDomain code:code userInfo:@{@"msg": msg ?: @"", @"data": data ?: @""}];
    return err;
}

- (NSString *)msg {
    return self.userInfo[@"msg"];
}

- (id)data {
    return self.userInfo[@"data"];
}

@end
