//
//  UIButton+CY_Category.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface UIButton (CY_Category)

@property (nonatomic, strong) UIFont *cc_font;

@property (nonatomic, copy) NSString *cc_normalTitle;
@property (nonatomic, strong) UIColor *cc_normalTitleColor;
@property (nonatomic, strong) UIImage *cc_normalImage;
@property (nonatomic, strong) UIImage *cc_normalBackgroundImage;

@property (nonatomic, copy) NSString *cc_highlightedTitle;
@property (nonatomic, strong) UIColor *cc_highlightedTitleColor;
@property (nonatomic, strong) UIImage *cc_highlightedImage;
@property (nonatomic, strong) UIImage *cc_highlightedBackgroundImage;

@property (nonatomic, copy) NSString *cc_selectedTitle;
@property (nonatomic, strong) UIColor *cc_selectedTitleColor;
@property (nonatomic, strong) UIImage *cc_selectedImage;
@property (nonatomic, strong) UIImage *cc_selectedBackgroundImage;

@property (nonatomic, copy) NSString *cc_selectedHighlightedTitle;
@property (nonatomic, strong) UIColor *cc_selectedHighlightedTitleColor;
@property (nonatomic, strong) UIImage *cc_selectedHighlightedImage;
@property (nonatomic, strong) UIImage *cc_selectedHighlightedBackgroundImage;

@property (nonatomic, copy) NSString *cc_disabledTitle;
@property (nonatomic, strong) UIColor *cc_disabledTitleColor;
@property (nonatomic, strong) UIImage *cc_disabledImage;
@property (nonatomic, strong) UIImage *cc_disabledBackgroundImage;

@end

