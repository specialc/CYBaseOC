//
//  CY_ButtonBar.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseView.h"
#import "CY_Lib.h"

@interface CY_ButtonBar : CY_BaseView

+ (CY_ButtonBar *)cc_createButtonBarInView:(UIView *)view;

@property (nonatomic, weak) UIView *cc_contentView;
// iPhone(Normal)的EdgeInset，默认UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets edgeInsetForiPhoneNormal;
// iPhoneX的EdgeInset，默认UIEdgeInsetsMake(15, 15, -15, 15)
@property (nonatomic, assign) UIEdgeInsets edgeInsetForiPhoneX;
// iPhoneX状态下的圆角
@property (nonatomic, assign) CGFloat cornerRadiusForiPhoneX;

@end

