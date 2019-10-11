//
//  CY_NavBarManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_NavBarManager.h"

@implementation CY_NavBarManager

+ (CY_NavBar *)cc_installNavBarInView:(UIView *)parentView {
    CY_NavBar *navBar = [[CY_NavBar alloc] init];
    navBar.cc_type = CY_NavBarTypeLight;
    navBar.cc_leftButtonType = CY_NavBarLeftButtonTypeBack;
    [parentView addSubview:navBar];
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
    }];
    
    return navBar;
}

+ (void)cc_initNavBar:(CY_NavBar *)navBar type:(CY_NavBarType)type {
    navBar.cc_type = type;
}

+ (void)cc_initNavBar:(CY_NavBar *)navBar title:(NSString *)title {
    navBar.cc_titleLabel.text = title;
}

+ (void)cc_initNavBar:(CY_NavBar *)navBar leftButtonType:(CY_NavBarLeftButtonType)leftButtonType {
    navBar.cc_leftButtonType = leftButtonType;
}

+ (void)cc_initNavBar:(CY_NavBar *)navBar leftButtonTitle:(NSString *)title {
    navBar.cc_leftButtonTitle = title;
}

+ (void)cc_initNavBar:(CY_NavBar *)navBar leftSecondButtonTitle:(NSString *)title {
    navBar.cc_leftSecondButtonTitle = title;
}

+ (void)cc_initNavBar:(CY_NavBar *)navBar rightButtonTitle:(NSString *)title {
    navBar.cc_rightButtonTitle = title;
}

+ (void)cc_initNavBar:(CY_NavBar *)navBar rightButtonType:(CY_NavBarRightButtonType)rightButtonType {
    navBar.cc_rightButtonType = rightButtonType;
}

+ (NSString *)constructTitle:(NSString *)title {
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [NSString stringWithFormat:@"  %@  ", title];
}

@end
