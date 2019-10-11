//
//  CY_NavigationControllerServicesImpl.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_NavigationControllerServicesImpl.h"

@interface CY_NavigationControllerServicesImpl ()
@property (nonatomic, strong) NSMutableArray<UINavigationController *> *navigationControllers;
@property (nonatomic, weak, readonly) UINavigationController *topNavigationController;
@end

@implementation CY_NavigationControllerServicesImpl

- (instancetype)init {
    self = [super init];
    if (self) {
        _navigationControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) {
        return;
    }
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

#pragma mark - Getter

- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}

- (UINavigationController *)cc_requireNavigationController {
    return self.topNavigationController;
}

- (UIViewController *)cc_topViewController {
    return self.topNavigationController.topViewController;
}

- (UIViewController *)cc_visibleViewController {
    return self.topNavigationController.visibleViewController;
}

#pragma mark - ResetRootViewController

- (void)cc_resetRootViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:UINavigationController.class]) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self pushNavigationController:navigationController];
        UIApplication.sharedApplication.delegate.window.rootViewController = navigationController;
    }
    else {
        [self pushNavigationController:(UINavigationController *)viewController];
        UIApplication.sharedApplication.delegate.window.rootViewController = viewController;
    }
    [UIApplication.sharedApplication.delegate.window makeKeyAndVisible];
}

#pragma mark - viewControllers

- (NSArray<UIViewController *> *)cc_viewControllers {
    return self.topNavigationController.viewControllers;
}

- (void)setCc_ViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [self.topNavigationController setViewControllers:viewControllers animated:animated];
}

#pragma mark - Push

- (void)cc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.topNavigationController pushViewController:viewController animated:animated];
}

- (void)cc_pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated {
    NSMutableArray *vcsM = [[NSMutableArray alloc] init];
    for (UIViewController *controller in self.cc_viewControllers) {
        [vcsM addObject:controller];
        if ([controller isEqual:fromViewController]) {
            break;
        }
    }
    [vcsM addObject:viewController];
    [self setCc_ViewControllers:[vcsM copy] animated:animated];
}

- (void)cc_pushViewController:(UIViewController *)viewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated {
    NSMutableArray *vcsM = [[NSMutableArray alloc] init];
    for (UIViewController *controller in self.cc_viewControllers) {
        if ([controller isEqual:excludeViewController]) {
            break;
        }
        [vcsM addObject:controller];
    }
    [vcsM addObject:viewController];
    [self setCc_ViewControllers:[vcsM copy] animated:animated];
}

- (void)cc_showViewController:(UIViewController *)vc sender:(id)sender {
    [self.topNavigationController showViewController:vc sender:sender];
}

#pragma mark - 原有pop

- (UIViewController *)cc_popViewControllerAnimated:(BOOL)animated {
    return [self.topNavigationController popViewControllerAnimated:YES];
}

- (NSArray<UIViewController *> *)cc_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self.topNavigationController popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)cc_popToRootViewControllerAnimated:(BOOL)animated {
    return [self.topNavigationController popToRootViewControllerAnimated:animated];
}

#pragma mark - 自定义pop

- (NSArray<UIViewController *> *)cc_popToViewControllerClass:(Class)aClass animated:(BOOL)animated {
    for (UIViewController *viewController in self.cc_viewControllers) {
        if ([viewController isMemberOfClass:aClass]) {
            return [self cc_popToViewController:viewController animated:animated];
        }
    }
    return nil;
}

- (NSArray<UIViewController *> *)cc_popToExternalViewController:(UIViewController *)externalViewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated {
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (UIViewController *vc in self.cc_viewControllers) {
        if (vc == excludeViewController) {
            break;
        }
        [vcs addObject:vc];
    }
    
    [vcs addObject:externalViewController];
    [vcs addObject:excludeViewController];
    [self setCc_ViewControllers:vcs.copy animated:NO];
    
    [vcs removeLastObject];
    [self setCc_ViewControllers:vcs.copy animated:animated];
    
    return self.cc_viewControllers;
}

- (NSArray<UIViewController *> *)cc_popToExternalViewController:(UIViewController *)externalViewController toViewController:(UIViewController *)toViewController animated:(BOOL)animated {
    if (self.cc_viewControllers.lastObject == toViewController) {
        NSAssert(NO, @"调用popToExternalViewController:toViewController:animated:时，当前栈顶控制器不能是toViewController");
    }
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (UIViewController *vc in self.cc_viewControllers) {
        if (vc == toViewController) {
            [vcs addObject:vc];
            break;
        }
        [vcs addObject:vc];
    }
    [vcs addObject:externalViewController];
    [vcs addObject:self.cc_viewControllers.lastObject];
    [self setCc_ViewControllers:vcs.copy animated:NO];
    
    [vcs removeLastObject];
    [self setCc_ViewControllers:vcs.copy animated:animated];
    return self.cc_viewControllers;
}

- (NSArray<UIViewController *> *)cc_popToPreviousViewControllerForViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL continued = NO;
    for (UIViewController *vc in self.cc_viewControllers.reverseObjectEnumerator.allObjects) {
        if (vc == viewController) {
            continued = YES;
            continue;
        }
        if (continued) {
            return [self cc_popToViewController:vc animated:animated];
        }
    }
    return nil;
}

- (NSArray<UIViewController *> *)cc_popToViewControllerPowerful:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *displayVC = self.cc_viewControllers.lastObject;
    [self setCc_ViewControllers:@[viewController, displayVC] animated:NO];
    [self setCc_ViewControllers:@[viewController] animated:animated];
    return self.cc_viewControllers;
}

#pragma mark - Present

- (void)cc_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^)(void))completion {
    UINavigationController *presentingViewController = self.topNavigationController;
    if (![viewControllerToPresent isKindOfClass:UINavigationController.class]) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewControllerToPresent];
        [self pushNavigationController:navigationController];
        [presentingViewController presentViewController:navigationController animated:animated completion:completion];
    }
    else {
        [self pushNavigationController:(UINavigationController *)viewControllerToPresent];
        [presentingViewController presentViewController:viewControllerToPresent animated:animated completion:completion];
    }
}

- (void)cc_dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self popNavigationController];
    [self.topNavigationController dismissViewControllerAnimated:animated completion:completion];
}

- (NSArray<UIViewController *> *)cc_tailViewControllersWithoutViewController:(UIViewController *)viewController {
    NSMutableArray *arr_m = [[NSMutableArray alloc] init];
    for (UIViewController *vc in self.cc_viewControllers) {
        if (vc != viewController && arr_m.count == 0) {
            continue;
        }
        [arr_m addObject:vc];
    }
    if (arr_m.count) {
        [arr_m removeObjectAtIndex:0];
    }
    return arr_m;
}

@end
