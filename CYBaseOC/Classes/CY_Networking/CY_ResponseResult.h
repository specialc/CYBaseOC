//
//  CY_ResponseResult.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  数据请求实体
 */

#import <Foundation/Foundation.h>

#pragma mark - CY_ResponseResult

typedef NS_ENUM(NSInteger, CY_ResponseStatus) {
    CY_ResponseStatus_Unknown,         // 未知
    CY_ResponseStatus_Success,         // 成功
    CY_ResponseStatus_Failure,         // 失败
    CY_ResponseStatus_SessionTimeout,  // Session过期
    CY_ResponseStatus_ServerUpgrading, // 服务器升级
};

@interface CY_ResponseResult : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) NSTimeInterval serverTime;
@property (nonatomic, assign, readonly) CY_ResponseStatus status;
@property (nonatomic, assign, readonly) BOOL success;
@property (nonatomic, copy, readonly) NSString *errorMessage;

// 数据
@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSArray *data_array;
@property (nonatomic, copy) NSDictionary *data_dictionary;
@property (nonatomic, copy) NSString *data_string;
@property (nonatomic, strong) id data_entity;

// 原始数据
@property (nonatomic, strong) id responseObject;

// 缓存
@property (nonatomic, assign) BOOL isCache;

#pragma mark -
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong, readonly) NSError *error;

@end
