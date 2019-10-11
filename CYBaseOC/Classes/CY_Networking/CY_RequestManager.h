//
//  CY_RequestManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  数据请求通用对象
 */

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "CY_RequestCache.h"
#import "CY_RequestManagerResponseHandler.h"
#import "CY_RequestParameters.h"
#import "CY_ResponseResult.h"

typedef NS_ENUM(NSUInteger, CY_RequestManagerStatus) {
    CY_RequestManagerStatus_Run,  // 接口调用中
    CY_RequestManagerStatus_Idle, // 接口空闲
};

typedef NS_ENUM(NSUInteger, CY_RequestMethod) {
    CY_RequestMethod_GET,
    CY_RequestMethod_POST,
    CY_RequestMethod_UPLOAD,
};

typedef void (^CY_ErrorBlock)(NSString *error);

#pragma mark - 调用接口

typedef void (^CY_RequestManagerCompleted)(CY_ResponseResult *result);
typedef void (^CY_RequestManagerProgress)(NSProgress *progress);
typedef void (^CY_RequestManagerFailure)(CY_ResponseResult *result);

@interface CY_RequestManager : NSObject

+ (instancetype)adapter;

@property (nonatomic, strong) AFHTTPSessionManager *requestManager;

#pragma mark - 参数


/**
 请求的URL，默认使用info.plist中的CY_RequestManagerURL
 */
@property (nonatomic, strong) NSString *requestURLString;


/**
 请求的接口路径，名称。例如：/pwd/salt，默认值：@""空白字符串
 */
@property (nonatomic, copy) NSString *requestPath;


/**
 接口超时时间，默认值：60.0
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;


/**
 参数，默认值：nil
 */
@property (nonatomic, strong) NSDictionary *parameters;


/**
 参数管理
 */
@property (nonatomic, strong) CY_RequestParameters *parametersManager;


/**
 当前接口的状态
 */
@property (nonatomic, assign, readonly) CY_RequestManagerStatus status;


/**
 响应对象处理器
 */
@property (nonatomic, strong) CY_RequestManagerResponseHandler *responseHandler;


/**
 响应对象类，默认值：[NSDictionary class]
 */
@property (nonatomic, strong) Class responseClass;


/**
 上传进度条
 */
@property (nonatomic, copy) CY_RequestManagerProgress uploadProgress;


/**
 缓存对象
 */
@property (nonatomic, strong) CY_RequestCache *cacheObj;


/**
 是否打印日志
 */
@property (nonatomic, assign) BOOL isPrintLog;


/**
 POST/GET/UPLOAD(POST)请求
 */
- (NSURLSessionDataTask *)POST:(CY_RequestManagerCompleted)completed;
- (NSURLSessionDataTask *)GET:(CY_RequestManagerCompleted)completed;
- (NSURLSessionDataTask *)UPLOAD:(CY_RequestManagerCompleted)completed;


/**
 取消当前队列的任务
 */
- (void)cancelAllOperations;

#pragma mark - Notification

// 请求开始
+ (void)postRequestStartNotification;
// 请求结束
+ (void)postRequestOverNotification;
// Session过期
+ (void)postSessionTimeoutNotification;
// 服务器升级
+ (void)postServerUpgradingNotificationWithMessage:(NSString *)message;
// 服务器正常
+ (void)postServerNormalNotification;

#pragma mark - 公用参数

// 请求URL
+ (NSString *)CY_DefaultRequestURLString;

#pragma mark - Cookies相关（用于恢复登录状态）

// 保存Cookies
+ (void)saveNetCookies;
/// 恢复Cookies
+ (void)restoreNetCookies;
// 删除保存的Cookies
+ (void)deleteSavedNetCookies;


@end
