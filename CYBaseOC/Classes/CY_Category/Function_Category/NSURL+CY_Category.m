//
//  NSURL+CY_Category.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/3.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSURL+CY_Category.h"

@implementation NSURL (CY_Category)

- (NSDictionary *)dictionaryFromQueryUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary *pairs = [[NSMutableDictionary alloc] init];
    NSScanner *scanner = [[NSScanner alloc] initWithString:self.query];
    
    while (![scanner isAtEnd]) {
        NSString *pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray *kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString *key = [[kvPair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString *value = [[kvPair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [pairs copy];
}

- (NSDictionary *)queryDictionary {
    return [self.query queryDictionary];
}

@end


@implementation NSString (Query)

- (NSDictionary *)queryDictionary {
    NSArray *keyValues = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] init];
    
    for (NSString *item in keyValues) {
        NSArray *keyValue = [item componentsSeparatedByString:@"="];
        NSString *key = keyValue[0];
        NSString *value = keyValue[1];
        [dictM setObject:value forKey:key];
    }
    return [dictM copy];
}

@end
