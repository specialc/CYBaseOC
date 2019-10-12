//
//  CY_Settings.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/13.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  简单的NSUserDefault封装
 */

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

@interface CY_Settings : NSObject
+ (instancetype)shared;
+ (id)objectForKey:(NSString *)key;
+ (void)setObject:(id)object forKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;
@property (nonatomic, assign) NSTimeInterval serverTimeIntervar;
@property (nonatomic, strong, readonly) NSDate *serverDate;
@end
