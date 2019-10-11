//
//  CY_InfoHUDView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_InfoHUDView.h"

@interface CY_InfoHUDView ()
@property (nonatomic, strong) CY_BaseLabel *titleLabel;
@property (nonatomic, assign) CGFloat duration;
@end

@implementation CY_InfoHUDView

+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

+ (void)handleKeyboardShow:(NSNotification *)notification {
    NSValue *Keyboard_rect_value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboard_rect = Keyboard_rect_value.CGRectValue;
    [[NSUserDefaults standardUserDefaults] setDouble:keyboard_rect.size.height forKey:@"HUD.KEYBOARD.HEIGHT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)handleKeyboardHide:(NSNotification *)notification {
    [[NSUserDefaults standardUserDefaults] setDouble:0 forKey:@"HUD.KEYBOARD.HEIGHT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)cc_showTitle:(NSString *)title {
    [self cc_showTitle:title duration:2.0];
}

+ (void)cc_showTitle:(NSString *)title duration:(NSTimeInterval)duration {
    [self showTitle:title duration:duration inView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration inView:(UIView *)view {
    if ([NSString cc_isNullOrEmpty:title]) {
        return;
    }
    if (!view) {
        return;
    }
    
    CY_InfoHUDView *hudView = [[CY_InfoHUDView alloc] init];
    hudView.duration = duration;
    [hudView showTitle:title inView:view];
}

- (void)showTitle:(NSString *)title inView:(UIView *)view {
    [view addSubview:self];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    // 设置圆角
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    
    // _titleLabel
    [self addSubview:self.titleLabel];
    self.titleLabel.text = title;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.lessThanOrEqualTo([UIScreen mainScreen].bounds.size.width - 60);
        make.height.greaterThanOrEqualTo(30);
        
        CGFloat height = [[NSUserDefaults standardUserDefaults] doubleForKey:@"HUD.KEYBOARD.HEIGHT"];
        if (height) {
            make.bottom.equalTo(-50 - height);
        }
        else {
            make.bottom.equalTo(-130);
        }
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(6, 12, 6, 12));
    }];
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.duration];
}

- (void)dismiss {
    weakify_self
    [UIView animateWithDuration:0.5 animations:^{
        strongify_self
        self.alpha = 0;
    } completion:^(BOOL finished) {
        strongify_self
        [self removeFromSuperview];
    }];
}

#pragma mark - Getter

- (CY_BaseLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[CY_BaseLabel alloc] init];
        _titleLabel.textColor = rgba(255, 255, 255, 1);
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
