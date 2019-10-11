//
//  CY_MD5Kit.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_MD5Kit.h"
#import <CommonCrypto/CommonDigest.h>

#define CY_MD5_Digest_Length 16

@implementation CY_MD5Kit
    
+ (NSString *)MD5WithData:(NSData *)data {
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CY_MD5_Digest_Length];
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(data.bytes, (CC_LONG)data.length, md5Buffer);
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CY_MD5_Digest_Length * 2];
    for (int i = 0; i< CY_MD5_Digest_Length; i++) {
        [output appendFormat:@"%02x", md5Buffer[i]];
    }
    return output;
}
    
+ (NSString *)MD5WithData_Failure:(NSData *)data {
    const char *original_str = (const char *)[data bytes];
    unsigned char digist[CY_MD5_Digest_Length];
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
    for (int i = 0; i < CY_MD5_Digest_Length; i++) {
        //小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
        [outPutStr appendFormat:@"%02x", digist[i]];
    }
    return [outPutStr lowercaseString];
}
    
+ (NSString *)MD5WithString:(NSString *)string {
    const char *original_str = [string UTF8String];
    unsigned char digist[CY_MD5_Digest_Length];
    //
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
    for (int i = 0; i < CY_MD5_Digest_Length; i++) {
        //小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
        [outPutStr appendFormat:@"%02x", digist[i]];
    }
    return [outPutStr lowercaseString];
}
    
+ (NSString *)MD5WithFilePath:(NSString *)path {
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FileHashDefaultChunkSizeForReadingData);
}
    
CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData) {
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)filePath, kCFURLPOSIXPathStyle, (Boolean)false);
    CC_MD5_CTX hashObject;
    bool hashMoreData = true;
    bool didSucceed;
    if (!fileURL) {
        goto done;
    }
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, (CFURLRef)fileURL);
    if (!readStream) {
        goto done;
    }
    didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) {
        goto done;
    }
    
    // Initialize the hash object
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    
    // Feed the data to the hash object
    while (hashMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCounnt = CFReadStreamRead(readStream, (UInt8 *)buffer, (CFIndex)sizeof(buffer));
        if (readBytesCounnt == -1) {
            break;
        }
        if (readBytesCounnt == 0) {
            hashMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject, (const void *)buffer, (CC_LONG)readBytesCounnt);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hashMoreData;
    
    // Compute the hash digest
    unsigned char digest[CY_MD5_Digest_Length];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) {
        goto done;
    }
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); i++) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault, (const char *)hash, kCFStringEncodingUTF8);
    
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

@end
