//
//  CY_BaseViewController.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_LoadingManager.h"
#import "CY_NavigationControllerServices.h"
#import "CY_NavigationController.h"
#import "CY_KeyboardManager.h"
#import "CY_NavBar.h"
#import "CY_ButtonBar.h"
#import "CY_Lib.h"

@class CY_BaseViewController;

@protocol CY_BaseViewControllerDataDelegate <NSObject>

- (instancetype)cc_initWithViewController:(CY_BaseViewController *)viewController;

// 通用刷新页面
- (void)cc_viewController:(CY_BaseViewController *)viewController loadingWithParameters:(id)parameters;

// 通用获取数据
- (void)cc_viewController:(CY_BaseViewController *)viewController fetchDataForKey:(NSString *)key parameters:(id)parameters complete:(void(^)(id data, NSError *error))complete;

@end

@interface CY_BaseViewController : UIViewController <CY_NavBarDelegate, CY_LoadingDelegate, CY_KeyboardManagerDelegate, CY_NavigationControllerDelegate>

// 数据代理
@property (nonatomic, strong) id <CY_BaseViewControllerDataDelegate> dataDelegate;

- (BOOL)cc_popGestureEnabled;


/**
 * 1：加载navBar，重写该函数应调用[super cc_loadNavigationBar];
 */
- (void)cc_loadNavigationBar;


/**
 * 2：加载View，在[self cc_loadNavigationBar]后调用，重写该函数应调用[super cc_loadViews];
 */
- (void)cc_loadViews;


/**
 * 2.1：适配 iPhone X 的ButtonBar
 */
- (void)cc_loadButtonBar;


/**
 * 3：对view进行布局，在[self cc_loadViews]后调用，重写该函数应调用[super cc_layoutConstraints]
 */
- (void)cc_layoutConstraints;


#pragma mark - 导航栏 NavigationBar

@property (nonatomic, weak) CY_NavBar *cc_navBar;

- (void)cc_setNavBarType:(CY_NavBarType)type;
- (void)cc_setNAVBarLeftButtonType:(CY_NavBarLeftButtonType)leftButtonType;
- (void)cc_setNavBarLeftSecondButtonTitle:(NSString *)title;
- (void)cc_setNavBarRightButtonType:(CY_NavBarRightButtonType)rightButtonType;
- (void)cc_setNavBarRightButtonTitle:(NSString *)title;
- (void)cc_setNavBarRightImage:(UIImage *)image;
- (void)cc_setNavBarTitle:(NSString *)title;
- (void)cc_setNavBarHidden:(BOOL)hidden;

@property (nonatomic, strong) CY_ButtonBar *cc_buttonBar;


#pragma mark - 键盘处理

// 键盘Manager
@property (nonatomic, strong) CY_KeyboardManager *cc_keyboardManager;

// 是否启用键盘默认处理逻辑，默认启用
- (BOOL)cc_isUseDefaultKeyboardManager;


#pragma mark - 页面刷新

// 刷新控件
@property (nonatomic, strong, readonly) CY_LoadingManager *cc_loadingManager;

// 刷新触发
- (void)cc_loadingAction;

// 刷新页面点击返回
- (void)cc_loadingGoBackClicked;


#pragma mark - 页面数据

// 页面数据源
@property (nonatomic, strong) id cc_viewData;

// 给页面赋值
- (void)cc_setLoadingSuccess:(id)data;

// 加载出错
- (void)cc_setLoadingFailure:(NSError *)error;

@end

