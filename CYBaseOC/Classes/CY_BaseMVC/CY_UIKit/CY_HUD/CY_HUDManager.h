//
//  CY_HUDManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_InfoHUDView.h"
#import "SVProgressHUD.h"

@interface CY_HUDManager : NSObject

+ (void)cc_showWaitHUD;
+ (void)cc_showWaitHUDWithStatus:(NSString *)status;

+ (void)cc_mustShowWaitHUD;
+ (void)cc_mustShowWaitHUDWithStatus:(NSString *)status;

+ (void)cc_showErrorHUD;
+ (void)cc_showErrorHUDWithStatus:(NSString *)status;

+ (void)cc_showSuccessHUD;
+ (void)cc_showSuccessHUDWithStatus:(NSString *)status;
+ (void)cc_showSuccessHUDWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;

+ (void)cc_showProgress:(float)progress;
+ (void)cc_showProgress:(float)progress status:(NSString *)status;

+ (void)cc_dismiss;

+ (void)cc_showInfo:(NSString *)info;
+ (void)cc_showInfo:(NSString *)info duration:(NSTimeInterval)duration;

@end


static void inline ShowWaitHUD() {
    [CY_HUDManager cc_showWaitHUD];
}

static void inline ShowWaitHUDWithStatus(NSString *status) {
    [CY_HUDManager cc_showWaitHUDWithStatus:status];
}

static void inline MustShowWaitHUD() {
    [CY_HUDManager cc_mustShowWaitHUD];
}

static void inline MustShowWaitHUDWithStatus(NSString *status) {
    [CY_HUDManager cc_mustShowWaitHUDWithStatus:status];
}

static void inline ShowErrorHUD() {
    [CY_HUDManager cc_showErrorHUD];
}

static void inline ShowErrorHUDWithStatus(NSString *status) {
    [CY_HUDManager cc_showErrorHUDWithStatus:status];
}

static void inline ShowSuccessHUD() {
    [CY_HUDManager cc_showSuccessHUD];
}

static void inline ShowSuccessHUDWithStatus(NSString *status) {
    [CY_HUDManager cc_showSuccessHUDWithStatus:status];
}

static void inline ShowProgressHUD(float progress) {
    [CY_HUDManager cc_showProgress:progress];
}

static void inline ShowProgressHUDWithStatus(float progress, NSString *status) {
    [CY_HUDManager cc_showProgress:progress status:status];
}

static void inline DismissHUD() {
    [CY_HUDManager cc_dismiss];
}

static void inline ShowInfoHUD(NSString *info) {
    // [lsg_HandleUtil showMessage:info status:false];
    [CY_HUDManager cc_showInfo:info];
}

static void inline ShowInfoHUDWithDuration(NSString *info, NSTimeInterval duration) {
    [CY_HUDManager cc_showInfo:info duration:duration];
}

