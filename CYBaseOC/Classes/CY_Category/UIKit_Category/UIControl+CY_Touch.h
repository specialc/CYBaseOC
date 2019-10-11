//
//  UIControl+CY_Touch.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (CY_Touch)
@property (nonatomic, copy) void(^touchUpInsideAction)(UIButton *sender);
- (void)addTouchUpInsideAction:(void(^)(UIButton *sender))action;
@end

