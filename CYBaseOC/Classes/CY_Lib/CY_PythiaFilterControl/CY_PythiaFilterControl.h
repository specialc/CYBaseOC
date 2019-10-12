//
//  CY_PythiaFilterControl.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_PythiaFilterPointer.h"
#import "CY_Lib.h"

@interface CY_PythiaFilterControl : UIControl

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
- (void)setSelectedIndex:(NSInteger)selectedIndex;
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@property (nonatomic, weak) CY_PythiaFilterPointer *pointer;
// 允许滑动
@property (nonatomic, assign) BOOL allowSlide;
// 线颜色
@property (nonatomic, strong) UIColor *baselineColor;
// 线边缘是否隐藏，默认：true
@property (nonatomic, assign) BOOL baselineEdgeHidden;
// 线高，默认：1
@property (nonatomic, assign) CGFloat baselineHeight;
// 指示器颜色
@property (nonatomic, strong) UIColor *pointerColor;
// 指示器图标
@property (nonatomic, strong) UIImage *pointerImage;
@property (nonatomic, assign) CGSize pointerSize;
// 锚点颜色
@property (nonatomic, strong) UIColor *anchorsColor;
// 锚点图标
@property (nonatomic, strong) UIImage *anchorsImage;
@property (nonatomic, assign) CGSize anchorsSize;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *unselectedTitleColor;
@property (nonatomic, strong) UIFont *selectedTitleFont;
@property (nonatomic, strong) UIFont *unselectedTitleFont;
@property (nonatomic, assign) BOOL titleHidden;

@end


/* 用法
 
 StarFilterControl *filterControl = [[StarFilterControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
 [self.contentView addSubview:filterControl];
 self.filterControl = filterControl;
 filterControl.titles        = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
 filterControl.baselineHeight= 2;
 filterControl.pointerColor  = nil;
 filterControl.pointerImage  = @"icon_six_selected".xc_image;
 filterControl.anchorsImage  = @"icon_six_unselected".xc_image;
 filterControl.pointerSize   = filterControl.pointerImage.size;
 filterControl.anchorsSize   = filterControl.anchorsImage.size;
 filterControl.titleHidden   = true;
 
 
 */
