//
//  CY_TextView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Helper

@interface CY_TextViewHelper : NSObject

@end

#pragma mark - CY_TextView

@interface CY_TextView : UITextView

// iOS文字长度
@property (nonatomic, assign) NSInteger cc_maxLength;
// UTF8字节长度
@property (nonatomic, assign) unsigned long cc_maxLengthOfUTF8;
// 允许最大的ASCII字节长度
@property (nonatomic, assign) unsigned long cc_maxLengthOfASCII;

// 灰色提示文字
@property (nonatomic, strong) NSString *cc_placeholder;
@property (nonatomic, strong) UIColor *cc_colorText;

@property (nonatomic, weak) id<UITextViewDelegate> cc_TextViewDelegate;

+ (CY_TextView *)cc_textView;
+ (CY_TextView *)cc_textViewWithDelegate:(id)delegate;

// 是否达到输入的上限
- (BOOL)cc_isReachMaxLengthWithCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
