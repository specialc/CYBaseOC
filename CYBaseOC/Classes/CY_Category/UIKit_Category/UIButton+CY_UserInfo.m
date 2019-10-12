//
//  UIButton+CY_UserInfo.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIButton+CY_UserInfo.h"
#import <objc/runtime.h>

@implementation UIButton (CY_UserInfo)

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, @selector(userInfo), userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, _cmd);
}

@end
