//
//  CY_PickerModel.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PickerModel.h"

@implementation CY_PickerModel

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
    }
    return self;
}

+ (instancetype)pickerModelWithKey:(NSString *)key value:(NSString *)value {
    return [[self alloc] initWithKey:key value:value];
}

@end
