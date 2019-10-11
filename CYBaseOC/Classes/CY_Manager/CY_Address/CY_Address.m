//
//  CY_Address.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_Address.h"

@implementation CY_Address

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadAddress];
    }
    return self;
}

- (void)loadAddress {
    NSString *addressBundlePath = [[NSBundle mainBundle] pathForResource:@"CY_Address" ofType:@"bundle"];
    NSString *addressFilePath = [[NSBundle bundleWithPath:addressBundlePath] pathForResource:@"address" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:addressFilePath];
    NSArray *dbProvinces = dict[@"provinces"];
    NSMutableArray *provinces = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dbProvince in dbProvinces) {
        CY_AddressProvince *province = [[CY_AddressProvince alloc] init];
        province.code = dbProvince[@"code"];
        province.name = dbProvince[@"name"];
        NSMutableArray *citys = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dbCity in dbProvince[@"citys"]) {
            CY_AddressCity *city = [[CY_AddressCity alloc] init];
            city.province = province;
            city.code = dbCity[@"code"];
            city.name = dbCity[@"name"];
            
            NSMutableArray *areas = [[NSMutableArray alloc] init];
            for (NSDictionary *dbArea in dbCity[@"areas"]) {
                CY_AddressArea *area = [[CY_AddressArea alloc] init];
                area.city = city;
                area.code = dbArea[@"code"];
                area.name = dbArea[@"name"];
                [areas addObject:area];
            }
            city.areas = [areas copy];
            [citys addObject:city];
        }
        province.citys = [citys copy];
        [provinces addObject:province];
    }
    self.provinces = [provinces copy];
}

- (void)setCurrentAddressWithProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex {
    _provinceIndex = provinceIndex;
    _cityIndex = cityIndex;
    _areaIndex = areaIndex;
}

- (NSString *)addressDescription {
    NSString *provinceName = self.provinceName;
    NSString *cityName = self.cityName;
    NSString *areaName = self.areaName;
    
    if (provinceName && cityName && areaName) {
        NSMutableString *title = [[NSMutableString alloc] init];
        [title appendString:provinceName];
        [title appendString:@" "];
        [title appendString:cityName];
        [title appendString:@" "];
        [title appendString:areaName];
        return title;
    }
    
    return @"";
}

- (NSString *)provinceName {
    CY_AddressProvince *province = self.provinces[self.provinceIndex];
    return province.name;
}

- (NSString *)cityName {
    CY_AddressCity *city = self.provinces[self.provinceIndex].citys[self.cityIndex];
    return city.name;
}

- (NSString *)areaName {
    CY_AddressArea *area = self.provinces[self.provinceIndex].citys[self.cityIndex].areas[self.areaIndex];
    return area.name;
}

- (void)setCurrentAddressWithProvinceName:(NSString *)provinceName cityName:(NSString *)cityName areaName:(NSString *)areaName {
    NSInteger provinceIndex = -1;
    NSInteger cityIndex = -1;
    NSInteger areaIndex = -1;
    
    for (int i = 0; i < self.provinces.count; i++) {
        CY_AddressProvince *province = self.provinces[i];
        if ([province.name isEqualToString:provinceName]) {
            provinceIndex = i;
            break;
        }
    }
    if (provinceIndex < 0) {
        return;
    }
    
    for (int i = 0; i < self.provinces[provinceIndex].citys.count; i++) {
        CY_AddressCity *city = self.provinces[provinceIndex].citys[i];
        if ([city.name isEqualToString:cityName]) {
            cityIndex = i;
            break;
        }
    }
    if (cityIndex < 0) {
        return;
    }
    
    for (int i = 0; i < self.provinces[provinceIndex].citys[cityIndex].areas.count; i++) {
        CY_AddressArea *area = self.provinces[provinceIndex].citys[cityIndex].areas[i];
        if ([area.name isEqualToString:areaName]) {
            areaIndex = i;
            break;
        }
    }
    if (areaIndex < 0) {
        return;
    }
    
    _provinceIndex = provinceIndex;
    _cityIndex = cityIndex;
    _areaIndex = areaIndex;
}

- (NSString *)provinceCode {
    return self.provinces[self.provinceIndex].code;
}

- (NSString *)cityCode {
    return self.provinces[self.provinceIndex].citys[self.cityIndex].code;
}

- (NSString *)areaCode {
    return self.provinces[self.provinceIndex].citys[self.cityIndex].areas[self.areaIndex].code;
}

- (void)setCurrentAddressWithProvinceCode:(NSString *)provinceCode cityCode:(NSString *)cityCode areaCode:(NSString *)areaCode {
    NSInteger provinceIndex = -1;
    NSInteger cityIndex = -1;
    NSInteger areaIndex = -1;
    
    for (int i = 0; i < self.provinces.count; i++) {
        CY_AddressProvince *province = self.provinces[i];
        if ([province.code isEqualToString:provinceCode]) {
            provinceIndex = i;
            break;
        }
    }
    if (provinceIndex < 0) {
        return;
    }
    
    for (int i = 0; i < self.provinces[provinceIndex].citys.count; i++) {
        CY_AddressCity *city = self.provinces[provinceIndex].citys[i];
        if ([city.code isEqualToString:cityCode]) {
            cityIndex = i;
            break;
        }
    }
    if (cityIndex < 0) {
        return;
    }
    
    for (int i = 0; i < self.provinces[provinceIndex].citys[cityIndex].areas.count; i++) {
        CY_AddressArea *area = self.provinces[provinceIndex].citys[cityIndex].areas[i];
        if ([area.code isEqualToString:areaCode]) {
            areaIndex = i;
            break;
        }
    }
    if (areaIndex < 0) {
        return;
    }
    
    _provinceIndex = provinceIndex;
    _cityIndex = cityIndex;
    _areaIndex = areaIndex;
}

@end


@implementation CY_AddressProvince
@end

@implementation CY_AddressCity
@end

@implementation CY_AddressArea
@end
