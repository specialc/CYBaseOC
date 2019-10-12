//
//  UIView+CY_Category.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/8.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  可以获取并设置x,y,width,height,centerX,centerY,boundsCenter,maxY,maxX,size,origin，可以修改当前view的层级等
 */

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface UIView (CY_Category)

@end


@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign, readonly) CGPoint boundsCenter;

@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, copy, readonly) UIView *(^cc_backgroundColor)(UIColor *color);

@end


// 层级
@interface UIView (Hierarchy)

- (void)bringToFront;
- (void)sendToBack;
- (void)removeSubview:(UIView *)view;
- (void)removeAllSubviews;

@end


@interface UIView (CY_Behavior)
@property (nonatomic, assign, getter=isDisplay) BOOL display;
@end
