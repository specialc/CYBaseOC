//
//  CY_NavBarManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CY_NavBarManager : NSObject

+ (CY_NavBar *)cc_installNavBarInView:(UIView *)parentView;
+ (void)cc_initNavBar:(CY_NavBar *)navBar type:(CY_NavBarType)type;
+ (void)cc_initNavBar:(CY_NavBar *)navBar title:(NSString *)title;
+ (void)cc_initNavBar:(CY_NavBar *)navBar leftButtonType:(CY_NavBarLeftButtonType)leftButtonType;
+ (void)cc_initNavBar:(CY_NavBar *)navBar leftButtonTitle:(NSString *)title;
+ (void)cc_initNavBar:(CY_NavBar *)navBar leftSecondButtonTitle:(NSString *)title;
+ (void)cc_initNavBar:(CY_NavBar *)navBar rightButtonType:(CY_NavBarRightButtonType)rightButtonType;
+ (void)cc_initNavBar:(CY_NavBar *)navBar rightButtonTitle:(NSString *)title;

@end
