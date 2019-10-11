//
//  CY_NavigationProtocol.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/29.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 * 操作导航控制器或者Modal的协议，非常好用
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CY_NavigationProtocol <NSObject>

// MARK:resetRootViewController

// 重设keyWindow的RootViewController
- (void)cc_resetRootViewController:(UIViewController *)viewController;


// MARK: - viewControllers

// The current view model stack
@property (nonatomic, copy, readonly) NSArray<__kindof UIViewController *> *cc_viewControllers;

// Set view models
- (void)setCc_ViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;

// MARK: - Push


/**
 * Push到@viewController
 * 原生
 */
- (void)cc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;


/**
 * Push到@viewController，但会将@fromViewController之上的所有控制器从栈中移除
 * 假设
 * A | B | C | D
 * viewController     = E
 * fromViewController = B
 * 执行结果
 * A | B | E
 */
- (void)cc_pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated;


/**
 * Push到@viewController，但会将@excludeViewController及之上的所有控制器从栈中移除
 * 假设
 * A | B | C | D
 * viewController        = E
 * excludeViewController = B
 * 执行结果
 * A | E
 */
- (void)cc_pushViewController:(UIViewController *)viewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated;


/**
 * 原生
 */
- (void)cc_showViewController:(UIViewController *)vc sender:(nullable id)sender;


// MARK: - pop


/**
 * pop到「栈顶控制器」的「前一个控制器」
 * 原生
 */
- (nullable UIViewController *)cc_popViewControllerAnimated:(BOOL)animated;


/**
 * pop到@viewController
 * 原生
 */
- (nullable NSArray<__kindof UIViewController *> *)cc_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;


/**
 * pop到「根控制器」
 * 原生
 */
- (nullable NSArray<__kindof UIViewController *> *)cc_popToRootViewControllerAnimated:(BOOL)animated;


// MARK: Custom


/**
 * pop到栈顶开始数第一个与@aClass类名相同的控制器，如果没有找到，则不pop，并且返回nil
 */
- (nullable NSArray<__kindof UIViewController *> *)cc_popToViewControllerClass:(Class)aClass animated:(BOOL)animated;


/**
 * pop到一个不在栈中的@externalViewController，直到pop掉@excludeViewController
 * 假设
 * A | B | C | D
 * externalViewController = E
 * excludeViewController  = B
 * 执行结果
 * A | E
 */
- (nullable NSArray<__kindof UIViewController *> *)cc_popToExternalViewController:(UIViewController *)externalViewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated;


/**
 * pop到一个不在栈中的@externalViewController，保留@toViewController
 * 假设
 * A | B | C | D
 * externalViewController = E
 * toViewController       = B
 * 执行结果
 * A | B | E
 */
- (nullable NSArray<__kindof UIViewController *> *)cc_popToExternalViewController:(UIViewController *)externalViewController toViewController:(UIViewController *)toViewController animated:(BOOL)animated;



/**
 * pop到@viewController之前的控制器
 * 假设
 * A | B | C | D
 * viewController = C
 * 执行结果
 * A | B
 */
- (nullable NSArray<__kindof UIViewController *> *)cc_popToPreviousViewControllerForViewController:(UIViewController *)viewController animated:(BOOL)animated;



/**
 * pop到一个不在栈中的根控制器
 * 适用于无闪切换根控制器，例如根控制器原本是登录页，登录完成之后执行-popToViewControllerPowerful:animated:，则可以pop到首页
 * 假设
 * A | B | C | D
 * viewController = E
 * 执行结果
 * E
 */
- (nullable NSArray<__kindof UIViewController *> *)cc_popToViewControllerPowerful:(UIViewController *)viewController animated:(BOOL)animated;


// MARK: - Present

- (void)cc_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

- (void)cc_dismissViewControllerAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;


// MARK: -
- (UINavigationController *)cc_requireNavigationController;

@property (nullable, nonatomic, strong, readonly) UIViewController *cc_topViewController;
@property (nullable, nonatomic, strong, readonly) UIViewController *cc_visibleViewController;



/**
 * 获取@viewController之后的所有控制器
 */
- (NSArray<UIViewController *> *)cc_tailViewControllersWithoutViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
