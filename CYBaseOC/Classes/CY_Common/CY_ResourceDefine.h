//
//  CY_ResourceDefine.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/23.
//  Copyright © 2019 CY. All rights reserved.
//

#ifndef CY_ResourceDefine_h
#define CY_ResourceDefine_h

#define ANGLE_TO_RADIAN(angle) ((angle) / 180.0 * M_PI)
#define CC_BlackColorAlpha(alpha) @"#000000".cc_colorWithAlpha(alpha)
#define CC_WhiteColorAlpha(alpha) @"#FFFFFF".cc_colorWithAlpha(alpha)

// 主色
#define CC_Color_Main @"#FF3D72".cc_color
// 分割线颜色
#define CC_Color_Separator @"#E6E6E6".cc_color
// 主背景色
#define CC_Color_Background @"#FFFFFF".cc_color
// 灰背景色/占位图背景色
#define CC_Color_Background_Gray @"#F8F8F8".cc_color
// 弹窗蒙版颜色
#define CC_Color_Mask @"#000000".cc_colorWithAlpha(0.46)
// 提示小圆点颜色
#define CC_Color_Badge @"#E85151".cc_color


// 文本颜色
// 标题色/输入文字颜色
#define CC_Color_Title @"#2C2C2C".cc_color;
// 文本内容颜色
#define CC_Color_Content @"#4C4C4C".cc_color;
// 普通文本颜色
#define CC_Color_Normal @"#777777".cc_color;
// 不可点击态颜色/占位符颜色
#define CC_Color_Disabled @"#999999".cc_color;
// 次要辅助颜色（eg：时间戳）
#define CC_Color_Second @"#AAAAAA".cc_color;


//
#define CC_Gradient_Image(imageSize) [UIImage cc_linearGradientWithInputPoints:@[@(CGPointMake(0, 0)), @(CGPointMake(1, 0))] inputColors:@[@"#FE665E".cc_color, @"#FF297C".cc_color] size:imageSize]

// 紫色按钮
#define CC_NormalButtonTitleColor UIColor.whiteColor
#define CC_NormalButtonImage CC_Color_Main.solidImage


// 字体大小
#define CC_Font8  @"8px".cc_font
#define CC_Font9  @"9px".cc_font
#define CC_Font10 @"10px".cc_font
#define CC_Font11 @"11px".cc_font
#define CC_Font12 @"12px".cc_font
#define CC_Font13 @"13px".cc_font
#define CC_Font14 @"14px".cc_font
#define CC_Font15 @"15px".cc_font
#define CC_Font16 @"16px".cc_font
#define CC_Font17 @"17px".cc_font
#define CC_Font18 @"18px".cc_font

#define CC_Font8Bold  @"8px-bold".cc_font
#define CC_Font9Bold  @"9px-bold".cc_font
#define CC_Font10Bold @"10px-bold".cc_font
#define CC_Font11Bold @"11px-bold".cc_font
#define CC_Font12Bold @"12px-bold".cc_font
#define CC_Font13Bold @"13px-bold".cc_font
#define CC_Font14Bold @"14px-bold".cc_font
#define CC_Font15Bold @"15px-bold".cc_font
#define CC_Font16Bold @"16px-bold".cc_font
#define CC_Font17Bold @"17px-bold".cc_font
#define CC_Font18Bold @"18px-bold".cc_font

#endif /* CY_ResourceDefine_h */
