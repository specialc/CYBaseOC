//
//  CY_RequestParameters.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  数据请求的参数构造器
 */

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

typedef NSString *CY_RequestParametersUploadKey;

extern CY_RequestParametersUploadKey const CY_RequestParametersUploadKeyData;
extern CY_RequestParametersUploadKey const CY_RequestParametersUploadKeyName;
extern CY_RequestParametersUploadKey const CY_RequestParametersUploadKeyFileName;
extern CY_RequestParametersUploadKey const CY_RequestParametersUploadKeyMimeType;

@interface CY_RequestParameters : NSObject

// 参数
@property (nonatomic, strong) NSDictionary *parameters;

// 请求参数
@property (nonatomic, strong, readonly) NSDictionary *requestParameters;

// 请求上传图片
@property (nonatomic, strong) NSArray<NSDictionary<CY_RequestParametersUploadKey, NSString *> *> *uploads;

// 默认参数，子类重写
- (NSDictionary *)staticParameters;

@end
