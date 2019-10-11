//
//  CY_AlertManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_AlertManager.h"

static CY_AlertManager *currentAlertViewCommon = nil;

@interface CY_AlertManager () <UIAlertViewDelegate>
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIAlertController *alertViewController;

@property (nonatomic, copy) void(^cancelButtonClicked)(void);
@property (nonatomic, copy) void(^otherHandler1)(void);
@property (nonatomic, copy) void(^otherHandler2)(void);
@end

@implementation CY_AlertManager

- (void)showAlertViewInViewController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle cancelButtonClicked:(void(^)(void))cancelButtonClicked confirmButtonClicked:(void(^)(void))confirmButtonClicked {
    [self showAlertViewInViewController:controller title:title message:message cancelButton:cancelButtonTitle otherButton1:confirmButtonTitle otherButton2:nil cancelHandler:cancelButtonClicked otherHandler1:confirmButtonClicked otherHandler2:nil];
}

- (void)showAlertViewInViewController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton otherButton1:(NSString *)otherButton1 otherButton2:(NSString *)otherButton2 cancelHandler:(void(^)(void))cancelHandler otherHandler1:(void(^)(void))otherHandler1 otherHandler2:(void(^)(void))otherHandler2 {
    self.cancelButtonClicked = cancelHandler;
    self.otherHandler1 = otherHandler1;
    self.otherHandler2 = otherHandler2;
    
    if (title == nil) {
        title = @"";
    }
    
    if (iOS8_Or_Later) {
        self.alertViewController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        CC_WeakSelf
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf cancelButtonClick:self.alertViewController.view.tag];
        }];
        [self.alertViewController addAction:cancelAction];
        
        if (otherButton1 != nil) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButton1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf otherButton1Clicked:self.alertViewController.view.tag];
            }];
            [self.alertViewController addAction:otherAction];
        }
        if (otherButton2 != nil) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButton2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf otherButton2Clicked:self.alertViewController.view.tag];
            }];
            [self.alertViewController addAction:otherAction];
        }
        
        currentAlertViewCommon = self;
        [controller presentViewController:self.alertViewController animated:YES completion:nil];
    }
    else {
        self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:otherButton1 otherButtonTitles:otherButton2, nil];
        currentAlertViewCommon = self;
        [self.alertView show];
    }
}

+ (void)showTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton confirmButton:(NSString *)confirmButton cancelHandler:(void (^)(void))cancelHandler confirmHandler:(void (^)(void))confirmHandler {
    [[[CY_AlertManager alloc] init] showAlertViewInViewController:CC_RootVC title:title message:message cancelButtonTitle:cancelButton confirmButtonTitle:confirmButton cancelButtonClicked:cancelHandler confirmButtonClicked:confirmHandler];
}

+ (void)showMessage:(NSString *)message cancelButton:(NSString *)cancelButton confirmButton:(NSString *)confirmButton cancelHandler:(void (^)(void))cancelHandler confirmHandler:(void (^)(void))confirmHandler {
    [[[CY_AlertManager alloc] init] showAlertViewInViewController:CC_RootVC title:kCY_AlertNormalTitle message:message cancelButtonTitle:cancelButton confirmButtonTitle:confirmButton cancelButtonClicked:cancelHandler confirmButtonClicked:confirmHandler];
}

+ (void)showTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton otherButton1:(NSString *)otherButton1 otherButton2:(NSString *)otherButton2 cancelHandler:(void (^)(void))cancelHandler otherHandler1:(void (^)(void))otherHandler1 otherHandler2:(void (^)(void))otherHandler2 {
    [[[CY_AlertManager alloc] init] showAlertViewInViewController:CC_RootVC title:title message:message cancelButton:cancelButton otherButton1:otherButton1 otherButton2:otherButton2 cancelHandler:cancelHandler otherHandler1:otherHandler1 otherHandler2:otherHandler2];
}

+ (void)showMessage:(NSString *)message cancelButton:(NSString *)cancelButton otherButton1:(NSString *)otherButton1 otherButton2:(NSString *)otherButton2 cancelHandler:(void (^)(void))cancelHandler otherHandler1:(void (^)(void))otherHandler1 otherHandler2:(void (^)(void))otherHandler2 {
    [[[CY_AlertManager alloc] init] showAlertViewInViewController:CC_RootVC title:kCY_AlertNormalTitle message:message cancelButton:cancelButton otherButton1:otherButton1 otherButton2:otherButton2 cancelHandler:cancelHandler otherHandler1:otherHandler1 otherHandler2:otherHandler2];
}

+ (void)cc_closeCurrentAlertView {
    if (iOS8_Or_Later) {
        [currentAlertViewCommon.alertViewController dismissViewControllerAnimated:NO completion:^{
            
        }];
    }
    else {
        [currentAlertViewCommon.alertView dismissWithClickedButtonIndex:-1 animated:NO];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    CC_WeakSelf
    if (buttonIndex == 0) {
        [weakSelf cancelButtonClick:alertView.tag];
    }
    else if (buttonIndex == 1) {
        [weakSelf otherButton1Clicked:alertView.tag];
    }
    else {
        [weakSelf otherButton2Clicked:alertView.tag];
    }
}

- (void)cancelButtonClick:(NSInteger)tag {
    if (self.cancelButtonClicked) {
        self.cancelButtonClicked();
    }
}

- (void)otherButton1Clicked:(NSInteger)tag {
    if (self.otherHandler1) {
        self.otherHandler1();
    }
}

- (void)otherButton2Clicked:(NSInteger)tag {
    if (self.otherHandler2) {
        self.otherHandler2();
    }
}

@end
