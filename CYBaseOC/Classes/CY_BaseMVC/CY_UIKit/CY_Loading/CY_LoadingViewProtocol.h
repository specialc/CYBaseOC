//
//  CY_LoadingViewProtocol.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/29.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

@protocol CY_LoadingViewProtocol <NSObject>

@property (nonatomic, assign) BOOL goBackHidden;

// 加载中
- (void)cc_setLoading:(NSString *)title;

// 加载失败 - 其他
- (void)cc_setLoadingFailureNormal:(NSString *)title;

// 加载失败 - 断网
- (void)cc_setLoadingFailureNetwork:(NSString *)title;

// 返回按钮是否可见
- (void)setGoBackHidden:(BOOL)hidden;

// 添加错误页点击事件
- (void)cc_addFailureTouchHandlerWithTarget:(id)target action:(SEL)action;

// 添加返回事件
- (void)cc_addGoBackButtonHandlerWithTarget:(id)target action:(SEL)action;

@end


