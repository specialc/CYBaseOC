//
//  CY_ResourceManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CY_ResourceManager : NSObject

+ (CY_ResourceManager *)cc_sharedInstance;

// 允许资源管理器
- (void)cc_run;

- (UIColor *)cc_colorWithKey:(NSString *)colorKey;
- (UIFont *)cc_fontWithKey:(NSString *)fontKey;
- (UIFont *)cc_systemFontWithKey:(NSString *)fontkey;
- (UIImage *)cc_imageWithKey:(NSString *)imageKey;

@end

NS_ASSUME_NONNULL_END
