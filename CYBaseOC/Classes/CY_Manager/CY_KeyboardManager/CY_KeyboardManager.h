//
//  CY_KeyboardManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  很好用的键盘监听对象
 */

#import <Foundation/Foundation.h>

@class CY_KeyboardManager;
@protocol CY_KeyboardManagerDelegate <NSObject>

@optional
- (void)cc_keyboardManager:(CY_KeyboardManager *)keyboardManager showWithFrame:(CGRect)keyboardFrame duration:(NSTimeInterval)duration;
- (void)cc_keyboardManager:(CY_KeyboardManager *)keyboardManager hideWithFrame:(CGRect)keyboardFrame duration:(NSTimeInterval)duration;

@end

@interface CY_KeyboardManager : NSObject
@property (nonatomic, weak) id<CY_KeyboardManagerDelegate> delegate;

- (instancetype)initWithDelegate:(id<CY_KeyboardManagerDelegate>)delegate;
- (void)cc_addKeyboardObserver;
- (void)cc_removeKeyboardObserver;
@end

