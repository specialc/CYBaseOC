//
//  CY_AlertManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCY_AlertNormalTitle @"温馨提示"

@interface CY_AlertManager : NSObject

+ (void)cc_closeCurrentAlertView;

+ (void)showTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton confirmButton:(NSString *)confirmButton cancelHandler:(void (^)(void))cancelHandler confirmHandler:(void (^)(void))confirmHandler;

+ (void)showMessage:(NSString *)message cancelButton:(NSString *)cancelButton confirmButton:(NSString *)confirmButton cancelHandler:(void (^)(void))cancelHandler confirmHandler:(void (^)(void))confirmHandler;

+ (void)showTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton otherButton1:(NSString *)otherButton1 otherButton2:(NSString *)otherButton2 cancelHandler:(void (^)(void))cancelHandler otherHandler1:(void (^)(void))otherHandler1 otherHandler2:(void (^)(void))otherHandler2;

+ (void)showMessage:(NSString *)message cancelButton:(NSString *)cancelButton otherButton1:(NSString *)otherButton1 otherButton2:(NSString *)otherButton2 cancelHandler:(void (^)(void))cancelHandler otherHandler1:(void (^)(void))otherHandler1 otherHandler2:(void (^)(void))otherHandler2;

@end


static void inline AlertTA(NSString *title, NSString *message, NSString *aButton, void(^aHandler)(void)) {
    [CY_AlertManager showTitle:title message:message cancelButton:aButton confirmButton:nil cancelHandler:aHandler confirmHandler:NULL];
}

static void inline AlertA(NSString *message, NSString *aButton, void(^aHandler)(void)) {
    [CY_AlertManager showMessage:message cancelButton:aButton confirmButton:nil cancelHandler:aHandler confirmHandler:NULL];
}

static void inline AlertTB(NSString *title, NSString *message, NSString *cancelButton, NSString *confirmButton, void(^cancelHandler)(void), void(^confirmHandler)(void)) {
    [CY_AlertManager showTitle:title message:message cancelButton:cancelButton otherButton1:confirmButton otherButton2:nil cancelHandler:cancelHandler otherHandler1:confirmHandler otherHandler2:NULL];
}

static void inline AlertB(NSString *message, NSString *cancelButton, NSString *confirmButton, void(^cancelHandler)(void), void(^confirmHandler)(void)) {
    [CY_AlertManager showMessage:message cancelButton:cancelButton otherButton1:confirmButton otherButton2:nil cancelHandler:cancelHandler otherHandler1:confirmHandler otherHandler2:NULL];
}

static void inline AlertC(NSString *message, NSString *cancelButton, NSString *otherButton1, NSString *otherButton2, void(^cancelHandler)(void), void(^otherHandler1)(void), void(^otherHandler2)(void)) {
    [CY_AlertManager showMessage:message cancelButton:cancelButton otherButton1:otherButton1 otherButton2:otherButton2 cancelHandler:cancelHandler otherHandler1:otherHandler1 otherHandler2:otherHandler2];
}
