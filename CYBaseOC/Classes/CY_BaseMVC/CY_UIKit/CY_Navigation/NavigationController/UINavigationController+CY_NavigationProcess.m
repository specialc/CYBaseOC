//
//  UINavigationController+CY_NavigationProcess.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UINavigationController+CY_NavigationProcess.h"

@implementation UINavigationController (CY_NavigationProcess)

- (NSArray<UIViewController *> *)powerfulPopToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *displayVC = self.viewControllers.lastObject;
    [self setViewControllers:@[viewController, displayVC] animated:NO];
    [self setViewControllers:@[viewController] animated:animated];
    return self.viewControllers;
}

- (NSArray<UIViewController *> *)popToViewControllerClass:(Class)class animated:(BOOL)animated {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isMemberOfClass:class]) {
            return [self popToViewController:viewController animated:animated];
        }
    }
    return nil;
}

- (NSArray<UIViewController *> *)popToPreviousViewControllerFromSender:(UIViewController *)sender animated:(BOOL)animated {
    BOOL continued = NO;
    for (UIViewController *viewController in self.viewControllers.reverseObjectEnumerator.allObjects) {
        if (viewController == sender) {
            continued = YES;
            continue;
        }
        if (continued) {
            return [self popToViewController:viewController animated:animated];
        }
    }
    return nil;
}

- (NSArray<UIViewController *> *)popToPreviousViewControllerForViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL continued = NO;
    for (UIViewController *vc in self.viewControllers.reverseObjectEnumerator.allObjects) {
        if (vc == viewController) {
            continued = YES;
            continue;
        }
        if (continued) {
            return [self popToViewController:vc animated:animated];
        }
    }
    return nil;
}

- (void)directPushViewController:(UIViewController *)viewController fromSenderViewController:(UIViewController *)senderViewController {
    NSMutableArray *vcsM = [[NSMutableArray alloc] init];
    for (UIViewController *controller in self.viewControllers) {
        [vcsM addObject:controller];
        if ([controller isEqual:senderViewController]) {
            break;
        }
    }
    [vcsM addObject:viewController];
    [self setViewControllers:[vcsM copy] animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated {
    NSMutableArray *vcsM = [[NSMutableArray alloc] init];
    for (UIViewController *controller in self.viewControllers) {
        [vcsM addObject:controller];
        if ([controller isEqual:fromViewController]) {
            break;
        }
    }
    [vcsM addObject:viewController];
    [self setViewControllers:[vcsM copy] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController excludeSenderViewController:(UIViewController *)senderViewController {
    NSMutableArray *vcsM = [[NSMutableArray alloc] init];
    for (UIViewController *controller in self.viewControllers) {
        if ([controller isEqual:senderViewController]) {
            break;
        }
        [vcsM addObject:controller];
    }
    [vcsM addObject:viewController];
    [self setViewControllers:[vcsM copy] animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated {
    NSMutableArray *vcsM = [[NSMutableArray alloc] init];
    for (UIViewController *controller in self.viewControllers) {
        if ([controller isEqual:excludeViewController]) {
            break;
        }
        [vcsM addObject:controller];
    }
    [vcsM addObject:viewController];
    [self setViewControllers:[vcsM copy] animated:animated];
}

@end
