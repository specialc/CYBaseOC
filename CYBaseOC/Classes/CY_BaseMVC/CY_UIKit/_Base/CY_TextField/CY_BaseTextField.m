//
//  CY_BaseTextField.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseTextField.h"

@implementation CY_BaseTextField

- (void)setCc_placeHolderFont:(UIFont *)cc_placeHolderFont {
    cc_placeHolderFont = cc_placeHolderFont;
    [self cc_setPlaceholder];
}

- (void)setCc_placeHolderColor:(UIColor *)cc_placeHolderColor {
    _cc_placeHolderColor = cc_placeHolderColor;
    [self cc_setPlaceholder];
}

- (void)cc_setPlaceholder {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.placeholder ?: @""];
    if (self.cc_placeHolderFont) {
        [attr addAttribute:NSFontAttributeName value:self.cc_placeHolderFont range:[attr.string rangeOfString:attr.string]];
    }
    if (self.cc_placeHolderColor) {
        [attr addAttribute:NSForegroundColorAttributeName value:self.cc_placeHolderColor range:[attr.string rangeOfString:attr.string]];
    }
    self.attributedPlaceholder = attr.copy;
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    if (self.cc_placeHolderFont && self.cc_placeHolderColor) {
        [self cc_setPlaceholder];
    }
}

@end
