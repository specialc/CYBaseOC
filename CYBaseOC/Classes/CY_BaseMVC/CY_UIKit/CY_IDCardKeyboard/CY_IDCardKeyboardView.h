//
//  CY_IDCardKeyboardView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CY_IDCardKeyboardViewDelegate <NSObject>

- (void)numberKeyboardInput:(NSString *)number;
- (void)numberKeyboardBackspace;

@optional
- (void)changeKeyboardType;

@end


// 左下角带X的数字键盘
@interface CY_IDCardKeyboardView : UIView

@property (nonatomic, assign) id<CY_IDCardKeyboardViewDelegate> delegate;

@end


// textField扩展
@interface UITextField (ExtentRange)

/**
 获取选定范围
 */
- (NSRange)selectedRange;


/**
 设置选中范围
 */
- (void)setSelectedRange:(NSRange)range;


/**
 设置光标位置
 */
- (void)insertSelectedRange:(NSRange)range;

@end
