//
//  CY_RequestCache.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_RequestCache.h"

@interface CY_RequestCache ()
@property (nonatomic, strong) NSMutableArray *adapterArray;
@property (nonatomic) BOOL bGlobalException;
@end

@implementation CY_RequestCache

+ (CY_RequestCache *)sharedCache {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (NSString *)userID {
    return @"";
}

+ (BOOL)storeData:(NSDictionary *)data forKey:(NSString *)key {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *memid = [NSString cc_isNullOrWhiteSpace:self.userID] ? @"unknown" : self.userID;
        NSString *rkey = [NSString stringWithFormat:@"CY_RequestCache/%@_%@_%@", key, memid, [CY_APPInfo appVersion]].cc_md5;
        NSMutableData *rdata = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:rdata];
        [archiver encodeObject:data forKey:@"_rdata"];
        [archiver finishEncoding];
        return [CY_FileStorage storeFile:rdata fileName:rkey];
    }
    return NO;
}

+ (NSDictionary *)dataForKey:(NSString *)key {
    NSString *memid = [NSString cc_isNullOrWhiteSpace:self.userID] ? @"unknown" : self.userID;
    NSString *rkey = [NSString stringWithFormat:@"CY_RequestCache/%@_%@_%@", key, memid, [CY_APPInfo appVersion]].cc_md5;
    NSData *rdata = [CY_FileStorage dataForFileName:rkey];
    if (rdata) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:rdata];
        NSDictionary *data = [unarchiver decodeObjectForKey:@"_rdata"];
        [unarchiver finishDecoding];
        return data;
    }
    return nil;
}

@end
