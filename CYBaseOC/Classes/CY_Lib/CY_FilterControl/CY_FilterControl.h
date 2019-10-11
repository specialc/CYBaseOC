//
//  CY_FilterControl.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_FilterPointer.h"

@interface CY_FilterControl : UIControl
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, assign, getter=isAllowSlide) BOOL allowSlide;
@property (nonatomic, assign) NSInteger selectedIndex;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
- (void)setTitlesColor:(UIColor *)color;
- (void)setTitlesFont:(UIFont *)font;
- (void)setPointerColor:(UIColor *)color;
@end
