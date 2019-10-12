//
//  CY_RequestManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_RequestManager.h"

#define CY_Cookies_Key @"CY_Cookies_Key"

@interface CY_RequestManager ()

@end

@implementation CY_RequestManager

#pragma mark -

- (instancetype)init {
    self = [super init];
    if (self) {
        _status = CY_RequestManagerStatus_Idle;
        _requestManager = [AFHTTPSessionManager manager];
        _requestPath = @"";
        _requestURLString = [CY_RequestManager CY_DefaultRequestURLString];
        _timeoutInterval = 60.0;
        _parametersManager = [[CY_RequestParameters alloc] init];
        
        // 缓存对象
        _cacheObj = [[CY_RequestCache alloc] init];
        _cacheObj.open = false;
        _responseHandler = [CY_RequestManagerResponseHandler handler];
        self.responseClass = [NSDictionary class];
        _isPrintLog = true;
    }
    return self;
}

+ (instancetype)adapter {
    return [[self alloc] init];
}

#pragma mark - Getter & Setter

- (Class)responseClass {
    return self.responseHandler.responseClass;
}

- (void)setResponseClass:(Class)responseClass {
    self.responseHandler.responseClass = responseClass;
}

- (NSDictionary *)parameters {
    return self.parametersManager.parameters;
}

- (void)setParameters:(NSDictionary *)parameters {
    self.parametersManager.parameters = parameters;
}

- (NSString *)key {
    NSMutableString *key = [[NSMutableString alloc] init];
    [key appendString:self.requestPath];
    [key appendString:@"?"];
    if (self.parameters) {
        [key appendString:self.parameters.query];
    }
    return key.copy;
}

#pragma mark - 请求

- (NSURLSessionDataTask *)POST:(CY_RequestManagerCompleted)completed {
    return [self requestWithMethod:CY_RequestMethod_POST success:^(CY_ResponseResult *result) {
        if (completed) {
            completed(result);
        }
    } failure:^(CY_ResponseResult *result) {
        if (completed) {
            completed(result);
        }
    }];
}

- (NSURLSessionDataTask *)GET:(CY_RequestManagerCompleted)completed {
    return [self requestWithMethod:CY_RequestMethod_GET success:^(CY_ResponseResult *result) {
        if (completed) {
            completed(result);
        }
    } failure:^(CY_ResponseResult *result) {
        if (completed) {
            completed(result);
        }
    }];
}

- (NSURLSessionDataTask *)UPLOAD:(CY_RequestManagerCompleted)completed {
    return [self requestWithMethod:CY_RequestMethod_UPLOAD success:^(CY_ResponseResult *result) {
        if (completed) {
            completed(result);
        }
    } failure:^(CY_ResponseResult *result) {
        if (completed) {
            completed(result);
        }
    }];
}

#pragma mark - Methods

- (NSURLSessionDataTask *)requestWithMethod:(CY_RequestMethod)method success:(CY_RequestManagerCompleted)success failure:(CY_RequestManagerFailure)failure {
    if (self.isPrintLog) {
//        LogBackTrace(@"请求调用堆栈");
    }
    
    // 如果有缓存
    if (self.cacheObj.open) {
        @try {
            NSString *key = [self key];
            NSDictionary *cacheResponseObj = [CY_RequestCache dataForKey:key];
            if (cacheResponseObj) {
                if (self.isPrintLog) {
//                    LogDebug(@"\n获取缓存内容：%@", self.requestPath);
                }
                [self POSTSuccessFinish:nil response:cacheResponseObj success:success failure:failure];
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    _status = CY_RequestManagerStatus_Run;
    [CY_RequestManager postRequestStartNotification];
    
    NSString *URLString = [self.requestURLString stringByAppendingPathComponent:self.requestPath];
    NSString *requestPath = self.requestPath;
    NSDictionary *requestParameters = self.parametersManager.requestParameters;
    NSTimeInterval timeoutInterval = self.timeoutInterval;
    
    if (self.isPrintLog) {
//        LogWarning(@"请求者：[%@.m:0]", NSStringFromClass([self class]));
//        LogWarning(@"反射类：[%@.m:0]", self.responseClass);
//        LogWarning(@"URL：%@", URLString);
//        LogWarning(@"Full URL：%@?%@", URLString, [requestParameters query]);
//        LogWarning(@"\n requestPath：%@ \n 请求方式：%@ \n Parameters：%@", requestPath, method == CY_RequestMethod_GET ? @"GET" : @"POST", requestParameters);
    }
    
    self.requestManager.requestSerializer.timeoutInterval = timeoutInterval;
    if ([self.requestManager.responseSerializer isKindOfClass:[AFJSONResponseSerializer class]]) {
        ((AFJSONResponseSerializer *)self.requestManager.responseSerializer).removesKeysWithNullValues = true;
    }
    
    void(^SuccessBlock)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject) {
        @try {
            if (self.isPrintLog) {
//                LogSuccess(@"\n 请求成功 \n 地址：%@ \n requestPath：%@ \n Response：%@", URLString, requestPath, responseObject);
                [CY_RequestManager postRequestOverNotification];
                [self POSTSuccessFinish:task response:responseObject success:success failure:failure];
            }
        } @catch (NSException *exception) {
            @try {
                if (self.isPrintLog) {
//                    LogSuccess(@"\n 接口请求成功了，但是Crash了：%@", exception);
                }
                NSError *error = [NSError cc_errorWithCode:0 msg:@"Crash"];
                [self POSTFailureFinish:task error:error failureBlock:failure];
            } @catch (NSException *exception) {
                if (self.isPrintLog) {
//                    LogSuccess(@"\n 请求代码崩溃，返回代码也崩溃了：%@", exception);
                }
            } @finally {
                
            }
        } @finally {
            
        }
    };
    
    void(^FailureBlock)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error) {
        @try {
            if (self.isPrintLog) {
//                LogFailure(@"\n 接口请求失败 \n 地址：%@ \n requestPath：%@ \n Error：%@", URLString, requestPath, error);
            }
            [CY_RequestManager postRequestOverNotification];
            [self POSTFailureFinish:task error:error failureBlock:failure];
        } @catch (NSException *exception) {
            if (self.isPrintLog) {
//                LogSuccess(@"\n 接口请求失败，代码Crash：%@", exception);
            }
        } @finally {
            
        }
    };
    
    NSURLSessionDataTask *task = nil;
    switch (method) {
        // GET请求
        case CY_RequestMethod_GET:
        {
            task = [self.requestManager GET:URLString parameters:requestParameters progress:^(NSProgress * _Nonnull downloadProgress) {
                if (self.uploadProgress) {
                    self.uploadProgress(downloadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SuccessBlock(task, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                FailureBlock(task, error);
            }];
        }
            break;
        
        // UPLOAD请求
        case CY_RequestMethod_UPLOAD:
        {
            // POST上传
            task = [self.requestManager POST:URLString parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                for (NSDictionary *upload in self.parametersManager.uploads) {
                    NSData *uploadData = upload[CY_RequestParametersUploadKeyData];
                    NSString *uploadName = upload[CY_RequestParametersUploadKeyName];
                    NSString *uploadFileName = upload[CY_RequestParametersUploadKeyFileName];
                    NSString *uploadMimeType = upload[CY_RequestParametersUploadKeyMimeType];
                    if (uploadData && uploadName && uploadFileName && uploadMimeType) {
                        [formData appendPartWithFileData:uploadData name:uploadName fileName:uploadFileName mimeType:uploadMimeType];
                    }
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                if (self.uploadProgress) {
                    self.uploadProgress(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SuccessBlock(task, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                FailureBlock(task, error);
            }];
        }
            break;
        
        
        // POST请求
        case CY_RequestMethod_POST:
        default:
        {
            task = [self.requestManager POST:URLString parameters:requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
                if (self.uploadProgress) {
                    self.uploadProgress(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SuccessBlock(task, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                FailureBlock(task, error);
            }];
        }
            break;
    }
}

#pragma mark - 处理返回结果

- (void)POSTSuccessFinish:(NSURLSessionDataTask *)task response:(id)responseObject success:(CY_RequestManagerCompleted)success failure:(CY_RequestManagerFailure)failure {
    
    _status = CY_RequestManagerStatus_Idle;
    // 处理返回结果
    self.responseHandler.task = task;
    
    CY_ResponseResult *result = [self.responseHandler handleSuccessResponseObject:responseObject];
    result.isCache = (task == nil);
    
    // 服务器升级
    if (result.status == CY_ResponseStatus_ServerUpgrading) {
        if (self.isPrintLog) {
//            LogError(@">>>>>>>>>>>>>>>> 服务器升级");
        }
        [CY_RequestManager postServerUpgradingNotificationWithMessage:result.message];
    }
    else {
        [CY_RequestManager postServerNormalNotification];
    }
    
    // 成功状态
    if (result.status == CY_ResponseStatus_Success) {
        if (self.isPrintLog) {
//            LogError(@">>>>>>>>>>>>>>>> 返回成功");
        }
        
        // 保存缓存
        if (self.cacheObj.open) {
            NSString *key = [self key];
            [CY_RequestCache storeData:responseObject forKey:key];
            if (self.isPrintLog) {
//                LogSuccess(@"接口缓存成功：%@", self.requestPath);
            }
        }
        if (success) {
            success(result);
        }
        return;
    }
    // Session过期
    else if (result.status == CY_ResponseStatus_SessionTimeout) {
        if (self.isPrintLog) {
//            LogError(@">>>>>>>>>>>>>>>> Session过期");
        }
        // 通知Session过期
        [CY_RequestManager postSessionTimeoutNotification];
    }
    // 失败状态
    else if (result.status == CY_ResponseStatus_Failure) {
        if (self.isPrintLog) {
//            LogError(@">>>>>>>>>>>>>>>> 返回失败");
        }
    }
    // 接口调用情况不明
    else {
        if (self.isPrintLog) {
//            LogError(@">>>>>>>>>>>>>>>> 接口调用情况不明%ld", result.code);
        }
    }
    
    // 回调
    if (failure) {
        failure(result);
    }
}

- (void)POSTFailureFinish:(NSURLSessionDataTask *)operation error:(NSError *)error failureBlock:(CY_RequestManagerFailure)failure {
    _status = CY_RequestManagerStatus_Idle;
    
    // 处理错误
    self.responseHandler.task = operation;
    CY_ResponseResult *errorResult = [self.responseHandler handleFailureError:error];
    // 回调
    if (failure) {
        failure(errorResult);
    }
}

#pragma mark - 操作

- (void)cancelAllOperations {
    [self.requestManager.operationQueue cancelAllOperations];
}

#pragma mark - 通知尚未完成

// 请求开始
+ (void)postRequestStartNotification {
    
}

// 请求结束
+ (void)postRequestOverNotification {
    
}

// Session过期
+ (void)postSessionTimeoutNotification {
    
}

// 服务器升级
+ (void)postServerUpgradingNotificationWithMessage:(NSString *)message {
    
}

// 服务器正常
+ (void)postServerNormalNotification {
    
}

#pragma mark - URL

// 当前URL
+ (NSString *)CY_DefaultRequestURLString {
    NSString *url = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CY_ReqeustManagerURL"] ?: @"";
    return url;
}

#pragma mark - Cookies相关（用户恢复登录状态）

// 保存Cookies
+ (void)saveNetCookies {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = cookieStorage.cookies;
    
    // 将cookie值转为Data数据保存
    NSMutableArray *dataCookieArray = [[NSMutableArray alloc] init];
    for (NSHTTPCookie *cookie in cookies) {
        NSDictionary *dic = [cookie properties];
        [dataCookieArray addObject:dic];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dataCookieArray forKey:CY_Cookies_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 恢复Cookies
+ (void)restoreNetCookies {
    NSArray *cookies = [[NSUserDefaults standardUserDefaults] objectForKey:CY_Cookies_Key];
    if (cookies && [cookies count] > 0) {
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSDictionary *dict in cookies) {
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dict];
            [cookieStorage setCookie:cookie];
        }
    }
}

// 删除保存的Cookies
+ (void)deleteSavedNetCookies {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CY_Cookies_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        [cookieStorage deleteCookie:cookie];
    }
}

@end
