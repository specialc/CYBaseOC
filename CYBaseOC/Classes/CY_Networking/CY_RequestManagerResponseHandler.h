//
//  CY_RequestManagerResponseHandler.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  数据请求返回值处理器
 */

#import <Foundation/Foundation.h>
#import "CY_ResponseResult.h"

@interface CY_RequestManagerResponseHandler : NSObject

+ (instancetype)handler;

@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) Class responseClass;

- (id)handleSuccessResponseObject:(id)responseObject;
- (id)handleFailureError:(NSError *)error;

@end
