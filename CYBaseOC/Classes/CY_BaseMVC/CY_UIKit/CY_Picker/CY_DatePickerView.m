//
//  CY_DatePickerView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_DatePickerView.h"

@interface CY_DatePickerView ()
@property (nonatomic, strong) CY_Control *backgroundOverlayView;
@property (nonatomic, strong) CY_BaseView *backView;
@end

@implementation CY_DatePickerView

#pragma mark - 页面构造

- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.dynamic = NO;
    self.blurRadius = 15;
    self.tintColor = UIColor.blackColor;
    
    {
        self.backgroundOverlayView = [[CY_Control alloc] init];
        [self addSubview:self.backgroundOverlayView];
        self.backgroundOverlayView.backgroundColor = @"system_alpha_color".cc_color;
        [self.backgroundOverlayView addTarget:self action:@selector(handleCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        self.backView = [[CY_BaseView alloc] init];
        [self addSubview:self.backView];
        self.backView.backgroundColor = UIColor.whiteColor;
    }
    {
        self.cc_datePicker = [[UIDatePicker alloc] init];
        [self.backView addSubview:self.cc_datePicker];
        self.cc_datePicker.datePickerMode = UIDatePickerModeDate;
        [self.cc_datePicker addTarget:self action:@selector(handleDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    {
        self.cc_saveButton = [[UIButton alloc] init];
        [self.backView addSubview:self.cc_saveButton];
        [self.cc_saveButton setTitle:@"保存".cc_localizedString forState:UIControlStateNormal];
        self.cc_saveButton.backgroundColor = @"button_yellow_color".cc_color;
        [self.cc_saveButton addTarget:self action:@selector(handleDone:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)cc_layoutConstraints {
    [self.backgroundOverlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(176);
    }];
    
    [self.cc_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.bottom.equalTo(self.cc_saveButton.mas_top);
        make.right.equalTo(0);
    }];
    
    [self.cc_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(44);
    }];
}

#pragma mark - Handle

- (void)handleDatePickerValueChanged:(UIDatePicker *)sender {
    // sender.date;
}

- (void)handleCancel:(CY_Control *)sender {
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerViewDidCancel:)]) {
        [self.delegate datePickerViewDidCancel:self];
    }
}

- (void)handleDone:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerView:didSelectDoneWithDate:)]) {
        [self.delegate datePickerView:self didSelectDoneWithDate:self.cc_datePicker.date];
    }
    
    if (self.didSelectDone) {
        self.didSelectDone(self.cc_datePicker.date);
        [self dismiss];
    }
}

#pragma mark - Action

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
