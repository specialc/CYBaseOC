//
//  CY_MD5Kit.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/13.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 * 能够获取NSData、NSString、file的MD5
 */

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

#define FileHashDefaultChunkSizeForReadingData 1024*8 // 8k

@interface CY_MD5Kit : NSObject
// 计算NSData的MD5值
+ (NSString *)MD5WithData:(NSData *)data;
    
// 计算字符串的MD5值
+ (NSString *)MD5WithString:(NSString *)string;
    
// 计算大文件的MD5值
+ (NSString *)MD5WithFilePath:(NSString *)path;
    
@end
