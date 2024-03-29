//
//  UIButton+CY_ImageTitleStyle.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIButton+CY_ImageTitleStyle.h"

@implementation UIButton (CY_ImageTitleStyle)

- (void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding {
    if (self.imageView.image != nil && self.titleLabel.text != nil) {
        // 先还原
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;
        // CYTest Padding是否应该*2
        CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        switch (style) {
            case ButtonImageTitleStyle_Left:
                if (padding != 0) {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, padding / 2, 0, -padding / 2);
                    self.imageEdgeInsets = UIEdgeInsetsMake(0, -padding / 2, 0, padding / 2);
                }
                break;
            case ButtonImageTitleStyle_Right:
            {
                //图片在右，文字在左
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.size.width + padding / 2), 0, (imageRect.size.width + padding / 2));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleRect.size.width + padding / 2), 0, -(titleRect.size.width + padding / 2));
            }
                break;
            case ButtonImageTitleStyle_Top:
            {
                //图片在上，文字在下
                self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y), (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width / 2), -((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y), -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width / 2));
                self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight) / 2 - imageRect.origin.y), (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), -((selfHeight - totalHeight) / 2 - imageRect.origin.y), -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyle_Bottom:
            {
                //图片在下，文字在上。
                self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight) / 2 - titleRect.origin.y), (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, -((selfHeight - totalHeight) / 2 - titleRect.origin.y), -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width / 2));
                self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y), (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), -((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y), -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyle_CenterTop:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y - padding), (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width / 2), (titleRect.origin.y - padding), -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), 0, -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyle_CenterBottom:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake((selfHeight - padding - titleRect.origin.y - titleRect.size.height), (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, -(selfHeight - padding - titleRect.origin.y - titleRect.size.height), -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), 0, -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyle_CenterUp:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding), (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding), -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), 0, -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyle_CenterDown:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake((imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding), (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding), -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), 0, -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyle_RightLeft:
            {
                //图片在右，文字在左，距离按钮两边边距
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(titleRect.origin.x - padding), 0, (titleRect.origin.x - padding));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth - padding - imageRect.origin.x - imageRect.size.width), 0, -(selfWidth - padding - imageRect.origin.x - imageRect.size.width));
            }
                break;
            case ButtonImageTitleStyle_LeftRight:
            {
                //图片在左，文字在右，距离按钮两边边距
                self.titleEdgeInsets = UIEdgeInsetsMake(0, (selfWidth - padding - titleRect.origin.x - titleRect.size.width), 0, -(selfWidth - padding - titleRect.origin.x - titleRect.size.width));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.origin.x - padding), 0, (imageRect.origin.x - padding));
            }
                break;
                
            default:
                break;
        }
    }
    else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

@end
