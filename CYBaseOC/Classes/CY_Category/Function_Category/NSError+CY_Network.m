//
//  NSError+CY_Network.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSError+CY_Network.h"

@implementation NSError (CY_Network)

+ (instancetype)cc_errorWithCode:(NSInteger)code msg:(NSString *)msg {
    id err = [[self alloc] initWithDomain:kPythiaURLErrorDomain code:code userInfo:@{@"msg": msg ?: @""}];
    return err;
}

+ (instancetype)cc_errorWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data {
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
