//
//  NSObject+CY_NavigationServices.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSObject+CY_NavigationServices.h"
#import "CY_NavigationControllerServicesImpl.h"

@interface CY_NavigationServiceJ : NSObject
@property (nonatomic, strong) id<CY_NavigationProtocol> navigationServices;
@end

@implementation CY_NavigationServiceJ

+ (instancetype)shared {
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
        _navigationServices = [[CY_NavigationControllerServicesImpl alloc] init];
    }
    return self;
}

@end


@implementation NSObject (CY_NavigationServices)

- (id<CY_NavigationProtocol>)navigationServices {
    return [CY_NavigationServiceJ shared].navigationServices;
}

+ (id<CY_NavigationProtocol>)navigationServices {
    return [CY_NavigationServiceJ shared].navigationServices;
}

@end
