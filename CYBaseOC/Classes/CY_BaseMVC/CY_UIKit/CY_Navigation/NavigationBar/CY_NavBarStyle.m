//
//  CY_NavBarStyle.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_NavBarStyle.h"

@implementation CY_NavBarStyle

+ (instancetype)cc_sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
