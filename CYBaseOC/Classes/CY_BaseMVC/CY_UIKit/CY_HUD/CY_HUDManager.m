//
//  CY_HUDManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_HUDManager.h"

@implementation CY_HUDManager

+ (void)config {
    [SVProgressHUD setFadeInAnimationDuration:0.15];
    [SVProgressHUD setFadeOutAnimationDuration:0.15];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

+ (void)cc_showWaitHUD {
    [self cc_showWaitHUDWithStatus:@"加载中，请稍候..."];
}

// 实
+ (void)cc_showWaitHUDWithStatus:(NSString *)status {
    [self config];
    
    [SVProgressHUD showWithStatus:status];
}

+ (void)cc_mustShowWaitHUD {
    [self cc_mustShowWaitHUDWithStatus:@"加载中，请稍候..."];
}

// 实
+ (void)cc_mustShowWaitHUDWithStatus:(NSString *)status {
    [self config];
    
    [SVProgressHUD setFadeOutAnimationDuration:0];
    [SVProgressHUD setFadeInAnimationDuration:0];
    [SVProgressHUD showWithStatus:status];
}

+ (void)cc_showErrorHUD {
    [self cc_showWaitHUDWithStatus:@"很抱歉>_<服务器开小差了..."];
}

// 实
+ (void)cc_showErrorHUDWithStatus:(NSString *)status {
    [self config];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)cc_showSuccessHUD {
    [self cc_showSuccessHUDWithStatus:@""];
}

+ (void)cc_showSuccessHUDWithStatus:(NSString *)status {
    [self cc_showSuccessHUDWithStatus:status maskType:SVProgressHUDMaskTypeNone];
}

// 实
+ (void)cc_showSuccessHUDWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [self config];
    
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)cc_showInfo:(NSString *)info {
    [CY_InfoHUDView cc_showTitle:info];
}

// 实
+ (void)cc_showInfo:(NSString *)info duration:(NSTimeInterval)duration {
    [CY_InfoHUDView cc_showTitle:info duration:duration];
}

+ (void)cc_showProgress:(float)progress {
    [self cc_showProgress:progress status:nil];
}

// 实
+ (void)cc_showProgress:(float)progress status:(NSString *)status {
    [self config];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showProgress:progress status:status];
}

// 实
+ (void)cc_dismiss {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismiss];
}



@end
