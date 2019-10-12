//
//  CY_APPInfo.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/4.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  获取当前APP的各种信息
 */

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

@interface CY_APPInfo : NSObject

+ (NSString *)bundleName;
+ (NSString *)bundleDisplayName;

// 获取APP版本号
+ (NSString *)appVersion;
// 记录系统版本号
+ (void)saveUserAPPVersion:(NSString *)newVersion;

// 判断版本是否更新
+ (BOOL)isAppUpdate:(NSString *)newVersion;

// 得到WeiboPay设备唯一标识
+ (NSString *)uniqueDeviceIdentifier;

// 当前设备的型号
+ (NSString *)deviceModel;

// 当前系统版本
+ (NSString *)systemVersion;

// 当前系统版本 return -> float类型
+ (float)systemFloatVersion;
+ (NSString *)IPAddress;


+ (UIWindow *)keyWindow;
+ (CGFloat)KeyboardHeightFormKeyBoardType:(UIKeyboardType)keyboardType;

@end
