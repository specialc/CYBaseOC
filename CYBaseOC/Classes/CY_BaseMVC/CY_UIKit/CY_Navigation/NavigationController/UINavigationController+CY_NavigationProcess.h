//
//  UINavigationController+CY_NavigationProcess.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface UINavigationController (CY_NavigationProcess)


/**
 强大的Pop，就算是RootViewController也能调用，执行完后，栈中只有viewController

 @param viewController 需要pop的控制器，将会成为根控制器
 @param animated 动画
 @return 结果控制器栈（注：将会是@[viewController]）
 */
- (NSArray<__kindof UIViewController *> *)powerfulPopToViewController:(UIViewController *)viewController animated:(BOOL)animated;


/**
 Pop到栈顶第一个指定Class的viewController，如果没找到则不跳转

 @param class 需要跳转的控制器类型
 @param animated 动画
 @return 结果控制器栈
 */
- (NSArray<__kindof UIViewController *> *)popToViewControllerClass:(Class)class animated:(BOOL)animated;


/**
 pop到Sender的前一个控制器，如果是根部控制器

 @param sender 发送的控制器
 @param animated 动画
 @return 结果控制器栈
 */
- (NSArray<__kindof UIViewController *> *)popToPreviousViewControllerFromSender:(UIViewController *)sender animated:(BOOL)animated;

- (NSArray<__kindof UIViewController *> *)popToPreviousViewControllerForViewController:(UIViewController *)viewController animated:(BOOL)animated;


/**
 将fromViewController之后的控制器从栈中移除，再Push到viewController
 
 例如：vc1 | vc2 | vc3
 vc2控制器Push vc4
 结果：vc1 | vc2 | vc4

 @param viewController <#viewController description#>
 @param senderViewController <#senderViewController description#>
 */
- (void)directPushViewController:(UIViewController *)viewController fromSenderViewController:(UIViewController *)senderViewController;
- (void)pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated;


/**
 将excludeViewController、及之后的控制器从栈中移除，再Push到viewController
 
 例如：vc1 | vc2 | vc3
 vc2 控制器Push vc4
 结果：vc1 | vc4

 @param viewController <#viewController description#>
 @param senderViewController <#senderViewController description#>
 */
- (void)pushViewController:(UIViewController *)viewController excludeSenderViewController:(UIViewController *)senderViewController;
- (void)pushViewController:(UIViewController *)viewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated;

@end

