//
//  CY_RequestCache.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  数据请求缓存对象
 */

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

// 统一的接口缓存
@interface CY_RequestCache : NSObject

// 是否打开缓存
@property (nonatomic, assign) BOOL open;

// 缓存数据
+ (BOOL)storeData:(NSDictionary *)data forKey:(NSString *)key;

// 获取缓存数据
+ (NSDictionary *)dataForKey:(NSString *)key;

@end
