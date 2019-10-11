//
//  NSArray+CY_ShorthandAdditions.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSArray+CY_ShorthandAdditions.h"

@implementation NSArray (CY_ShorthandAdditions)

- (NSArray *)makeConstraints:(void (^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void (^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void (^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end
