//
//  CY_FileStorage.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/9.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  将文件储存到APP沙盒的对象
 */

#import <Foundation/Foundation.h>

@interface CY_FileStorage : NSObject

+ (BOOL)storeFile:(id)file fileName:(NSString *)fileName;
+ (BOOL)storeData:(NSData *)data fileName:(NSString *)fileName;
+ (BOOL)storeDictionary:(NSDictionary *)dict fileName:(NSString *)fileName;
+ (BOOL)storeArray:(NSArray *)array fileName:(NSString *)fileName;
+ (BOOL)storeString:(NSString *)string fileName:(NSString *)fileName;

+ (id)fileForFileName:(NSString *)fileName fileClass:(Class)fileClass;
+ (NSData *)dataForFileName:(NSString *)fileName;
+ (NSDictionary *)dictionaryForFileName:(NSString *)fileName;
+ (NSArray *)arrayForFileName:(NSString *)fileName;
+ (NSString *)stringForFileName:(NSString *)fileName;

+ (BOOL)removeFileForFileName:(NSString *)fileName;
+ (NSString *)fileFullPathNameWithFileName:(NSString *)fileName;

@end

