//
//  UIButton+CY_ImageTitleStyle.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/4.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  图文各种样式布局的的UIButton
 */

#import <UIKit/UIKit.h>

/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, ButtonImageTitleStyle) {
    ButtonImageTitleStyle_Default = 0, // 图片在左，文字在右，整体居中。
    ButtonImageTitleStyle_Left = 0, // 图片在左，文字在右，整体居中。
    ButtonImageTitleStyle_Right = 2,// 图片在右，文字在左，整体居中。
    ButtonImageTitleStyle_Top = 3,// 图片在上，文字在下，整体居中。
    ButtonImageTitleStyle_Bottom = 4,// 图片在下，文字在上，整体居中。
    ButtonImageTitleStyle_CenterTop = 5,// 图片居中，文字在上，距离按钮顶部。
    ButtonImageTitleStyle_CenterBottom = 6,// 图片居中，文字在下，距离按钮底部。
    ButtonImageTitleStyle_CenterUp = 7,// 图片居中，文字在图片上面。
    ButtonImageTitleStyle_CenterDown = 8,// 图片居中，文字在图片下面。
    ButtonImageTitleStyle_RightLeft = 9,// 图片在右，文字在左，距离按钮两边边距。
    ButtonImageTitleStyle_LeftRight = 10,// 图片在左，文字在右，距离按钮两边边距。
};

@interface UIButton (CY_ImageTitleStyle)


/**
 调整按钮的文本和Image的布局，前提是Title和Image同时存在才会调整

 @param style 类型
 @param padding 调整布局时整个按钮和图文的间隔
 */
- (void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;

@end
