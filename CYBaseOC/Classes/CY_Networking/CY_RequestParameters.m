//
//  CY_RequestParameters.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_RequestParameters.h"

CY_RequestParametersUploadKey const CY_RequestParametersUploadKeyData = @"CY_RequestParametersUploadKeyData";
CY_RequestParametersUploadKey const CY_RequestParametersUploadKeyName = @"CY_RequestParametersUploadKeyName";
CY_RequestParametersUploadKey const CY_RequestParametersUploadKeyFileName = @"CY_RequestParametersUploadKeyFileName";
CY_RequestParametersUploadKey const CY_RequestParametersUploadKeyMimeType = @"CY_RequestParametersUploadKeyMimeType";

@implementation CY_RequestParameters

- (NSDictionary *)staticParameters {
    NSMutableDictionary *staticParam = [[NSMutableDictionary alloc] init];
    
//    NSString *deviceIdentifier = [StarApplicationInfo uniqueDeviceIdentifier];
//
//    // 默认参数
//    // 应用版本
//    [staticParameters setObject:[StarApplicationInfo appVersion] forKey:@"version"];
//    // 应用平台 1 iphone 2 android
//    [staticParameters setObject:@"1" forKey:@"platformType"];
//    // 应用类别 1 app
//    [staticParameters setObject:@"1" forKey:@"appType"];
//    // 设备唯一标识
//    [staticParameters setObject:deviceIdentifier forKey:@"deviceIdentify"];
//    // 客户端请求时间 客户端使用从1970-1-1 00:00:00到现在的毫秒数
//    [staticParameters setObject:[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000.] forKey:@"reqTime"];
//    // 本地化信息 目前客户端填写zh_CN, 目前的处理方法是,无论客户端填写什么都转成zh_CN
//    [staticParameters setObject:@"zh_CN" forKey:@"locale"];
//    // app下载渠道id
//    [staticParameters setObject:@"20" forKey:@"channelId"];
//    // 当前设备IP地址
//    [staticParameters setObject:[StarApplicationInfo IPAddress] forKey:@"clientIp"];
    
    return [staticParam copy];
}

- (NSDictionary *)requestParameters {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    // 静态参数
    NSDictionary *staticParameters = [self staticParameters];
    [parameters addEntriesFromDictionary:staticParameters];
    
    // 动态参数
    if (self.parameters) {
        [parameters addEntriesFromDictionary:self.parameters];
    }
    
    return [parameters copy];
}

@end
