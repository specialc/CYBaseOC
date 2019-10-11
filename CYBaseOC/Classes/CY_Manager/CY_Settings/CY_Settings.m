//
//  CY_Settings.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_Settings.h"

#define CY_UserDefault [NSUserDefaults standardUserDefaults]

@implementation CY_Settings

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)setObject:(id)object forKey:(NSString *)key {
    [CY_UserDefault setObject:object forKey:key];
    [CY_UserDefault synchronize];
}

+ (id)objectForKey:(NSString *)key {
    return [CY_UserDefault objectForKey:key];
}

+ (BOOL)boolForKey:(NSString *)key {
    if ([CY_UserDefault objectForKey:key] == nil) {
        [CY_UserDefault setBool:false forKey:key];
        [CY_UserDefault synchronize];
        return false;
    }
    else {
        return [CY_UserDefault boolForKey:key];
    }
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key {
    [CY_UserDefault setBool:value forKey:key];
    [CY_UserDefault synchronize];
}

// 服务器时间
- (NSDate *)serverDate {
    return [NSDate dateWithTimeIntervalSince1970:self.serverTimeIntervar];
}

@end
