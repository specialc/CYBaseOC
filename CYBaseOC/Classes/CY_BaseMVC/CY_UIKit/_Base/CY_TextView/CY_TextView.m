//
//  CY_TextView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TextView.h"

#pragma mark - CY_TextViewHelper

@interface CY_TextViewHelper () <UITextViewDelegate>
@property (nonatomic, weak) CY_TextView *textView;
@end

@implementation CY_TextViewHelper

- (instancetype)initWithTextView:(CY_TextView *)textView {
    self = [super init];
    if (self) {
        self.textView = textView;
        self.textView.delegate = self;
    }
    return self;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [pDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    // 判断是否达到输入上限
    CY_TextView *cc_TextView = (CY_TextView *)textView;
    // 达到上限就禁止继续输入
    if ([cc_TextView cc_isReachMaxLengthWithCharactersInRange:range replacementString:text]) {
        return NO;
    }
    return YES;
}

// 下面函数都是转发UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [pDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [pDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [pDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [pDelegate textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [pDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [pDelegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [pDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    id<UITextViewDelegate> pDelegate = ((CY_TextView *)textView).cc_TextViewDelegate;
    if ([pDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        return [pDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

@end

#pragma mark - CY_TextView

@interface CY_TextView ()
@property (nonatomic, strong) CY_TextViewHelper *helper;
@end

@implementation CY_TextView

+ (CY_TextView *)cc_textView {
    CY_TextView *textView = [[CY_TextView alloc] init];
    [textView setBackgroundColor:UIColor.clearColor];
//    [textView setTextColor:UIColor.lightGrayColor];
    [textView addObserver];
    return textView;
}

+ (CY_TextView *)cc_textViewWithDelegate:(id)delegate {
    CY_TextView *textView = [CY_TextView cc_textView];
    textView.cc_TextViewDelegate = delegate;
    [textView setBackgroundColor:UIColor.clearColor];
    [textView addObserver];
    return textView;
}

// 是否达到输入的上限
- (BOOL)cc_isReachMaxLengthWithCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *aString = [self.text stringByReplacingCharactersInRange:range withString:string];
    if (self.cc_maxLength) {
        return (aString.length > self.cc_maxLength);
    }
    else if (self.cc_maxLengthOfUTF8) {
        const char *utf8_string = [aString UTF8String];
        unsigned long utf8_str_len = strlen(utf8_string);
        return utf8_str_len > self.cc_maxLengthOfUTF8;
    }
    else if (self.cc_maxLengthOfASCII) {
        const char *ascii_string = [aString cStringUsingEncoding:NSASCIIStringEncoding];
        unsigned long ascii_str_len = strlen(ascii_string);
        return ascii_str_len > self.cc_maxLengthOfASCII;
    }
    return NO;
}

#pragma mark - 注册通知

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

#pragma mark - 移除通知

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 开始编辑

- (void)textDidBeginEditing:(NSNotification *)notification {
    if ([super.text isEqualToString:_cc_placeholder]) {
        super.text = @"";
//        [super setTextColor:UIColor.blackColor];
        [super setTextColor:_cc_colorText];
    }
}

#pragma mark - 结束编辑

- (void)textDidEndEditing:(NSNotification *)notification {
    if (super.text.length == 0) {
        super.text = _cc_placeholder;
        // 如果文本框内是原来的提示文字，则显示灰色字体
        [super setTextColor:UIColor.lightGrayColor];
    }
}

#pragma mark - 重写setPlaceholder方法

- (void)setCc_placeholder:(NSString *)cc_placeholder {
    _cc_placeholder = cc_placeholder;
    [self textDidEndEditing:nil];
}

#pragma mark - 重写getText方法

- (NSString *)text {
    NSString *text = [super text];
    if ([text isEqualToString:_cc_placeholder]) {
        return @"";
    }
    return text;
}

@end
