//
//  CY_JSFunction.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/13.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  能够直接运行JS代码的对象
 */

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface CY_JSFunction : NSObject
+ (NSString *)createFunctionWithBody:(NSString *)body argsName:(NSString *)argsName, ...;
+ (JSValue *)runFunction:(NSString *)function withArgs:(NSString *)args, ...;
@end
