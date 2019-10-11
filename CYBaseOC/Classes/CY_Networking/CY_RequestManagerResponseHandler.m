//
//  CY_RequestManagerResponseHandler.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_RequestManagerResponseHandler.h"

@interface CY_RequestManagerResponseHandler ()

@end

@implementation CY_RequestManagerResponseHandler

+ (instancetype)handler {
    return [[self alloc] init];
}

- (id)handleSuccessResponseObject:(id)responseObject {
    NSAssert(false, @"请在子类重写");
    return nil;
}

- (id)handleFailureError:(NSError *)error {
    NSAssert(false, @"请在子类重写");
    return nil;
}

@end
