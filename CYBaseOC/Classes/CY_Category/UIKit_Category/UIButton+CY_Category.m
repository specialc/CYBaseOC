//
//  UIButton+CY_Category.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIButton+CY_Category.h"

@implementation UIButton (CY_Category)

- (UIFont *)cc_font {
    return self.titleLabel.font;
}

- (void)setCc_font:(UIFont *)cc_font {
    self.titleLabel.font = cc_font;
}

#pragma mark - normal

- (NSString *)cc_normalTitle {
    return [self titleForState:UIControlStateNormal];
}

- (void)setCc_normalTitle:(NSString *)cc_normalTitle {
    [self setTitle:cc_normalTitle forState:UIControlStateNormal];
}

- (UIColor *)cc_normalTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setCc_normalTitleColor:(UIColor *)cc_normalTitleColor {
    [self setTitleColor:cc_normalTitleColor forState:UIControlStateNormal];
}

- (UIImage *)cc_normalImage {
    return [self imageForState:UIControlStateNormal];
}

- (void)setCc_normalImage:(UIImage *)cc_normalImage {
    [self setImage:cc_normalImage forState:UIControlStateNormal];
}

- (UIImage *)cc_normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setCc_normalBackgroundImage:(UIImage *)cc_normalBackgroundImage {
    [self setBackgroundImage:cc_normalBackgroundImage forState:UIControlStateNormal];
}

#pragma mark - hignlighted

- (NSString *)cc_highlightedTitle {
    return [self titleForState:UIControlStateHighlighted];
}

- (void)setCc_highlightedTitle:(NSString *)cc_highlightedTitle {
    [self setTitle:cc_highlightedTitle forState:UIControlStateHighlighted];
}

- (UIColor *)cc_highlightedTitleColor {
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setCc_highlightedTitleColor:(UIColor *)cc_highlightedTitleColor {
    [self setTitleColor:cc_highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIImage *)cc_highlightedImage {
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setCc_highlightedImage:(UIImage *)cc_highlightedImage {
    [self setImage:cc_highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)cc_highlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setCc_highlightedBackgroundImage:(UIImage *)cc_highlightedBackgroundImage {
    [self setBackgroundImage:cc_highlightedBackgroundImage forState:UIControlStateHighlighted];
}

#pragma mark - selected

- (NSString *)cc_selectedTitle {
    return [self titleForState:UIControlStateSelected];
}

- (void)setCc_selectedTitle:(NSString *)cc_selectedTitle {
    [self setTitle:cc_selectedTitle forState:UIControlStateSelected];
}

- (UIColor *)cc_selectedTitleColor {
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setCc_selectedTitleColor:(UIColor *)cc_selectedTitleColor {
    [self setTitleColor:cc_selectedTitleColor forState:UIControlStateSelected];
}

- (UIImage *)cc_selectedImage {
    return [self imageForState:UIControlStateSelected];
}

- (void)setCc_selectedImage:(UIImage *)cc_selectedImage {
    [self setImage:cc_selectedImage forState:UIControlStateSelected];
}

- (UIImage *)cc_selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setCc_selectedBackgroundImage:(UIImage *)cc_selectedBackgroundImage {
    [self setBackgroundImage:cc_selectedBackgroundImage forState:UIControlStateSelected];
}

#pragma mark - selectedHighlighted

- (NSString *)cc_selectedHighlightedTitle {
    return [self titleForState:UIControlStateSelected | UIControlStateHighlighted];
}

- (void)setCc_selectedHighlightedTitle:(NSString *)cc_selectedHighlightedTitle {
    [self setTitle:cc_selectedHighlightedTitle forState:UIControlStateSelected | UIControlStateHighlighted];
}

- (UIColor *)cc_selectedHighlightedTitleColor {
    return [self titleColorForState:UIControlStateSelected | UIControlStateHighlighted];
}

- (void)setCc_selectedHighlightedTitleColor:(UIColor *)cc_selectedHighlightedTitleColor {
    [self setTitleColor:cc_selectedHighlightedTitleColor forState:UIControlStateSelected | UIControlStateHighlighted];
}

- (UIImage *)cc_selectedHighlightedImage {
    return [self imageForState:UIControlStateSelected | UIControlStateHighlighted];
}

- (void)setCc_selectedHighlightedImage:(UIImage *)cc_selectedHighlightedImage {
    [self setImage:cc_selectedHighlightedImage forState:UIControlStateSelected | UIControlStateHighlighted];
}

- (UIImage *)cc_selectedHighlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected | UIControlStateHighlighted];
}

- (void)setCc_selectedHighlightedBackgroundImage:(UIImage *)cc_selectedHighlightedBackgroundImage {
    [self setBackgroundImage:cc_selectedHighlightedBackgroundImage forState:UIControlStateSelected | UIControlStateHighlighted];
}

#pragma mark - disabled

- (NSString *)cc_disabledTitle {
    return [self titleForState:UIControlStateDisabled];
}

- (void)setCc_disabledTitle:(NSString *)cc_disabledTitle {
    [self setTitle:cc_disabledTitle forState:UIControlStateDisabled];
}

- (UIColor *)cc_disabledTitleColor {
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setCc_disabledTitleColor:(UIColor *)cc_disabledTitleColor {
    [self setTitleColor:cc_disabledTitleColor forState:UIControlStateDisabled];
}

- (UIImage *)cc_disabledImage {
    return [self imageForState:UIControlStateDisabled];
}

- (void)setCc_disabledImage:(UIImage *)cc_disabledImage {
    [self setImage:cc_disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)cc_disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setCc_disabledBackgroundImage:(UIImage *)cc_disabledBackgroundImage {
    [self setBackgroundImage:cc_disabledBackgroundImage forState:UIControlStateDisabled];
}

@end
