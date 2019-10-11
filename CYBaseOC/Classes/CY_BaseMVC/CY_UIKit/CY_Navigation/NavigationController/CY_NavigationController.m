//
//  CY_NavigationController.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_NavigationController.h"

@interface CY_NavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSDate *lastInputDate;
@property (nonatomic, assign) BOOL isPush;

@end

@implementation CY_NavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setNavigationBarHidden:YES animated:NO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super setViewControllers:viewControllers animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    // 在VC栈中
    if ([self.viewControllers containsObject:viewController]) {
        return [super popToViewController:viewController animated:animated];
    }
    // vc.tabbBarController在VC栈中
    if (viewController.tabBarController && [self.viewControllers containsObject:viewController.tabBarController]) {
        return [super popToViewController:viewController.tabBarController animated:animated];
    }
    // 都不在不允许pop
    return nil;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if (!self.isPush) {
    }
    self.isPush = NO;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.isPush = YES;
    }
    else {
        self.isPush = NO;
    }
    return nil;
}

#pragma mark - UINavigationControllerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count <= 1 || self.visibleViewController == self.viewControllers.firstObject) {
            return NO;
        }
        if ([self.visibleViewController conformsToProtocol:@protocol(CY_NavigationControllerDelegate)]) {
            id<CY_NavigationControllerDelegate> delegate = (id)self.visibleViewController;
            if ([delegate respondsToSelector:@selector(cc_popGestureEnabled)]) {
                return [delegate cc_popGestureEnabled];
            }
        }
    }
    return YES;
}

@end
