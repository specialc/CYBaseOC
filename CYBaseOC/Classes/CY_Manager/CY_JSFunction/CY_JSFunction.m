//
//  CY_JSFunction.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_JSFunction.h"

@implementation CY_JSFunction

+ (NSString *)createFunctionWithBody:(NSString *)body argsName:(NSString *)argsName, ... {
    NSMutableArray *argsNameM = [[NSMutableArray alloc] init];
    if (argsName) {
        [argsNameM addObject:argsName];
        va_list arglist;
        va_start(arglist, argsName);
        while (YES) {
            NSString *str = va_arg(arglist, NSString *);
            if (str == nil) {
                break;
            }
            [argsNameM addObject:str];
        }
        va_end(arglist);
    }
    
    NSMutableString *functionStr = [argsNameM componentsJoinedByString:@","].mutableCopy;
    [functionStr insertString:@"function _func(" atIndex:0];
    [functionStr appendString:@") {"];
    [functionStr appendString:body];
    [functionStr appendString:@"}"];
    return functionStr.copy;
}
    
+ (JSValue *)runFunction:(NSString *)function withArgs:(NSString *)args, ... {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if (args) {
        [arr addObject:args];
        va_list arglist;
        va_start(arglist, args);
        while (YES) {
            NSString *str = va_arg(arglist, NSString *);
            if (str == nil) {
                break;
            }
            [arr addObject:str];
        }
        va_end(arglist);
    }
    
    NSMutableString *outStr = [arr componentsJoinedByString:@","].mutableCopy;
    [outStr insertString:@"_func(" atIndex:0];
    [outStr appendString:@");"];
    JSContext *ctx = [[JSContext alloc] init];
    return [ctx evaluateScript:[function stringByAppendingString:outStr.copy]];
}

@end
