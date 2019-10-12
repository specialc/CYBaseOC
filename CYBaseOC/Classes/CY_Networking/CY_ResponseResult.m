//
//  CY_ResponseResult.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_ResponseResult.h"

@implementation CY_ResponseResult

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

- (CY_ResponseStatus)status {
    // 成功
    if (self.code == 2000) {
        return CY_ResponseStatus_Success;
    }
    // 其他都是失败
    return CY_ResponseStatus_Failure;
//    return CY_ResponseStatus_Unknown;
}

- (BOOL)success {
    return self.status == CY_ResponseStatus_Success;
}

- (NSString *)errorMessage {
    // 服务器升级
    if (self.status == CY_ResponseStatus_ServerUpgrading) {
        return @"";
    }
    // Session过期
    else if (self.status == CY_ResponseStatus_SessionTimeout) {
        return @"";
    }
    return self.message;
}

- (NSError *)error {
    return [NSError cc_errorWithCode:self.code msg:self.errorMessage];
}

@end
