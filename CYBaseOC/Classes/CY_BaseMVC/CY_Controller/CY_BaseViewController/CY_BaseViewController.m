//
//  CY_BaseViewController.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseViewController.h"

@interface CY_BaseViewController ()
@property (nonatomic, assign) CY_NavBarLeftButtonType leftButtonType;
@end

@implementation CY_BaseViewController

- (void)dealloc {
//    LogSuccess(@"%@ [%@.m:0] Dealloc.", self, NSStringFromClass([self class]));
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *className = NSStringFromClass([self class]);
//    LogSuccess(@"%@ [%@.m:0] viewDidLoad.", self, className);
    
    [self cc_loadNavigationBar];
    [self cc_loadViews];
    [self cc_layoutConstraints];
    
    _cc_loadingManager = [[CY_LoadingManager alloc] initWithHandleView:self.view delegate:self];
    self.cc_keyboardManager = [[CY_KeyboardManager alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 页面状态

- (BOOL)cc_popGestureEnabled {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (!self.cc_navBar) {
        return UIStatusBarStyleDefault;
    }
    
    switch (self.cc_navBar.cc_type) {
        case CY_NavBarTypeDark:
        {
            return UIStatusBarStyleLightContent;
        }
            break;
            
        default:
        {
            return UIStatusBarStyleDefault;
        }
            break;
    }
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - 加载

- (void)cc_loadNavigationBar {
    CY_NavBar *navBar = [CY_NavBarManager cc_installNavBarInView:self.view];
    self.cc_navBar = navBar;
    self.cc_navBar.delegate = self;
    [self cc_setNavBarTitle:self.title];
    [self cc_setNavBarType:CY_NavBarTypeLight];
    [self cc_setNAVBarLeftButtonType:CY_NavBarLeftButtonTypeBack];
}

- (void)cc_loadViews {
    self.view.backgroundColor = UIColor.whiteColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)cc_loadButtonBar {
    self.cc_buttonBar = [CY_ButtonBar cc_createButtonBarInView:self.view];
}

- (void)cc_layoutConstraints {
    
}

#pragma mark - NavBar

- (void)cc_setNavBarType:(CY_NavBarType)type {
    [CY_NavBarManager cc_initNavBar:self.cc_navBar type:type];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)cc_setNAVBarLeftButtonType:(CY_NavBarLeftButtonType)leftButtonType {
    [CY_NavBarManager cc_initNavBar:self.cc_navBar leftButtonType:leftButtonType];
    self.leftButtonType = leftButtonType;
}

- (void)cc_setNavBarLeftSecondButtonTitle:(NSString *)title {
    [CY_NavBarManager cc_initNavBar:self.cc_navBar leftSecondButtonTitle:title];
}

- (void)cc_setNavBarRightButtonType:(CY_NavBarRightButtonType)rightButtonType {
    [CY_NavBarManager cc_initNavBar:self.cc_navBar rightButtonType:rightButtonType];
}

- (void)cc_setNavBarRightButtonTitle:(NSString *)title {
    [CY_NavBarManager cc_initNavBar:self.cc_navBar rightButtonTitle:title];
}

- (void)cc_setNavBarRightImage:(UIImage *)image {
    [self.cc_navBar cc_clearRightButton];
    self.cc_navBar.cc_rightButton.hidden = NO;
    self.cc_navBar.cc_rightButton.userInteractionEnabled = YES;
    self.cc_navBar.cc_rightButton.cc_font = @"15px".cc_font;
    self.cc_navBar.cc_rightButton.cc_normalImage = image;
    self.cc_navBar.cc_rightButton.cc_normalBackgroundImage = [UIImage cc_imageWithColor:[UIColor clearColor] size:CGSizeMake(50, 44)];
}

- (void)cc_setNavBarTitle:(NSString *)title {
    self.title = title;
}

- (void)cc_setNavBarHidden:(BOOL)hidden {
    self.cc_navBar.hidden = hidden;
}

- (void)setTitle:(NSString *)title {
    super.title = title;
    [CY_NavBarManager cc_initNavBar:self.cc_navBar title:title];
}

#pragma mark - CY_NarBarDelegate

- (void)cc_navBarLeftButtonClicked:(id)sender {
    if (self.leftButtonType == CY_NavBarLeftButtonTypeBack || self.leftButtonType == CY_NavBarLeftButtonTypeCancel || self.cc_navBar.cc_leftButtonType == CY_NavBarLeftButtonTypeBack) {
        [self.navigationServices cc_popViewControllerAnimated:YES];
    }
}

- (void)cc_navBarLeftSecondButtonClicked:(id)sender {
    
}

- (void)cc_navBarRightButtonClicked:(id)sender {
    
}

#pragma mark - 键盘处理逻辑

// 是否启用键盘默认处理逻辑，默认启用
- (BOOL)cc_isUseDefaultKeyboardManager {
    return YES;
}

- (void)cc_keyboardManager:(CY_KeyboardManager *)keyboardManager showWithFrame:(CGRect)keyboardFrame duration:(NSTimeInterval)duration {
    
}

- (void)cc_keyboardManager:(CY_KeyboardManager *)keyboardManager hideWithFrame:(CGRect)keyboardFrame duration:(NSTimeInterval)duration {
    
}

#pragma mark - loading delegate

- (void)cc_loadingAction {
    if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(cc_viewController:loadingWithParameters:)]) {
        [self.dataDelegate cc_viewController:self loadingWithParameters:nil];
    }
}

- (void)cc_loadingGoBackClicked {
    [self.navigationServices cc_popViewControllerAnimated:YES];
}

#pragma mark - loading 赋值

- (void)cc_setLoadingSuccess:(id)data {
    _cc_viewData = data;
    if ([self.cc_loadingManager cc_isLoading]) {
        [self.cc_loadingManager cc_endLoading];
    }
}

- (void)cc_setLoadingFailure:(NSError *)error {
    NSString *msg = error.msg ?: @"数据加载失败，请稍后再试";
    // 如果没有数据
    if (!self.cc_viewData) {
        // 网络错误 <= NSURLErrorCancelled
        if (error.code < 0) {
            [self.cc_loadingManager cc_loadingFailureNetwork];
            ShowInfoHUD(msg);
        }
        // 服务器错误
        else {
            [self.cc_loadingManager cc_loadingFailureNormal:msg];
        }
    }
    // 如果有数据
    else {
        [self.cc_loadingManager cc_endLoading];
        ShowInfoHUD(msg);
    }
}


@end
