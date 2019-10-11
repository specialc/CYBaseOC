//
//  CY_Address.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CY_AddressProvince, CY_AddressCity, CY_AddressArea;


// 地址
@interface CY_Address : NSObject
@property (nonatomic, strong) NSArray<CY_AddressProvince *> *provinces;
@property (nonatomic, assign, readonly) NSInteger provinceIndex;
@property (nonatomic, assign, readonly) NSInteger cityIndex;
@property (nonatomic, assign, readonly) NSInteger areaIndex;
@property (nonatomic, copy) NSString *addressDescription;
- (void)setCurrentAddressWithProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex;

@property (nonatomic, copy, readonly) NSString *provinceName;
@property (nonatomic, copy, readonly) NSString *cityName;
@property (nonatomic, copy, readonly) NSString *areaName;
- (void)setCurrentAddressWithProvinceName:(NSString *)provinceName cityName:(NSString *)cityName areaName:(NSString *)areaName;

@property (nonatomic, copy, readonly) NSString *provinceCode;
@property (nonatomic, copy, readonly) NSString *cityCode;
@property (nonatomic, copy, readonly) NSString *areaCode;
- (void)setCurrentAddressWithProvinceCode:(NSString *)provinceCode cityCode:(NSString *)cityCode areaCode:(NSString *)areaCode;

@end


// 省
@interface CY_AddressProvince : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<CY_AddressCity *> *citys;
@end


// 市
@interface CY_AddressCity : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<CY_AddressArea *> *areas;
@property (nonatomic, weak) CY_AddressProvince *province;
@end


// 区
@interface CY_AddressArea : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, weak) CY_AddressCity *city;
@end
