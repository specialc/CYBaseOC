//
//  CY_FileStorage.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/9.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_FileStorage.h"

#define CY_FSPrintRestoreSuccess LogSuccess(@"读取成功");
#define CY_FSPrintRestoreFailure LogFailure(@"读取失败");
#define CY_FSPrintStoreSuccess() LogSuccess(@"保存成功");
#define CY_FSPrintStoreFailure(msg) LogFailure(@"保存失败：%@", msg);

static inline NSString *DocumentDirectoryPath() {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
}

static inline NSString *FileStoragePath() {
    return [DocumentDirectoryPath() stringByAppendingPathComponent:@"CY_FileStorage"];
}

@interface CY_FileStorage ()

@end

@implementation CY_FileStorage

+ (BOOL)storeFile:(id)file fileName:(NSString *)fileName {
    NSString *fileFullPathName = [self fileFullPathNameWithFileName:fileName];
    [self createDirectory:fileFullPathName];
    
    NSError *error = nil;
    if ([file isKindOfClass:[NSData class]]) {
        NSData *aData = file;
        [aData writeToFile:fileFullPathName options:NSDataWritingAtomic error:&error];
    }
    else if ([file isKindOfClass:[NSDictionary class]]) {
        NSDictionary *aData = file;
        BOOL flag = [aData writeToFile:fileFullPathName atomically:YES];
        if (!flag) {
            error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"未知错误"}];
        }
    }
    else if ([file isKindOfClass:[NSArray class]]) {
        NSArray *aData = file;
        BOOL flag = [aData writeToFile:fileFullPathName atomically:YES];
        if (!flag) {
            error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:@"未知错误"}];
        }
    }
    else if ([file isKindOfClass:[NSString class]]) {
        NSString *aData = file;
        [aData writeToFile:fileFullPathName atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    if (error == nil) {
        CY_FSPrintStoreSuccess();
    }
    else {
        CY_FSPrintStoreFailure(error.localizedDescription);
    }
    return error == nil;
}

+ (BOOL)storeData:(NSData *)data fileName:(NSString *)fileName {
    return [self storeFile:data fileName:fileName];
}

+ (BOOL)storeString:(NSString *)string fileName:(NSString *)fileName {
    return [self storeFile:string fileName:fileName];
}

+ (BOOL)storeDictionary:(NSDictionary *)dict fileName:(NSString *)fileName {
    return [self storeFile:dict fileName:fileName];
}

+ (BOOL)storeArray:(NSArray *)array fileName:(NSString *)fileName {
    return [self storeFile:array fileName:fileName];
}

+ (id)fileForFileName:(NSString *)fileName fileClass:(Class)fileClass {
    NSString *fileFullPathName = [self fileFullPathNameWithFileName:fileName];
    // 查无此文件
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileFullPathName]) {
        LogFailure(@"无此文件");
        return nil;
    }
    
    id aData = nil;
    if (fileClass == [NSData class]) {
        aData = [NSData dataWithContentsOfFile:fileFullPathName];
    }
    else if (fileClass == [NSDictionary class]) {
        aData = [NSDictionary dictionaryWithContentsOfFile:fileFullPathName];
    }
    else if (fileClass == [NSArray class]) {
        aData = [NSArray arrayWithContentsOfFile:fileFullPathName];
    }
    else if (fileClass == [NSString class]) {
        aData = [NSString stringWithContentsOfFile:fileFullPathName encoding:NSUTF8StringEncoding error:NULL];
    }
    
    if (aData) {
        CY_FSPrintRestoreSuccess
    }
    else {
        CY_FSPrintRestoreFailure;
    }
    return aData;
}

+ (NSData *)dataForFileName:(NSString *)fileName {
    return [self fileForFileName:fileName fileClass:[NSData class]];
}

+ (NSDictionary *)dictionaryForFileName:(NSString *)fileName {
    return [self fileForFileName:fileName fileClass:[NSDictionary class]];
}

+ (NSArray *)arrayForFileName:(NSString *)fileName {
    return [self fileForFileName:fileName fileClass:[NSArray class]];
}

+ (NSString *)stringForFileName:(NSString *)fileName {
    return [self fileForFileName:fileName fileClass:[NSString class]];
}

+ (BOOL)removeFileForFileName:(NSString *)fileName {
    return [[NSFileManager defaultManager] removeItemAtPath:[self fileFullPathNameWithFileName:fileName] error:nil];
}

+ (NSString *)fileFullPathNameWithFileName:(NSString *)fileName {
    return [FileStoragePath() stringByAppendingPathComponent:fileName];
}

+ (void)createDirectory:(NSString *)fileName {
    NSString *filePath = [fileName stringByDeletingLastPathComponent];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:NULL error:NULL];
    }
}

@end
