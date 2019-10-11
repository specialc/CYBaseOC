//
//  CY_DatePickerView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BlurView.h"

@class CY_DatePickerView;

@protocol CY_DatePickerViewDelegate <NSObject>

@optional
- (void)datePickerViewDidCancel:(CY_DatePickerView *)pickerView;
- (void)datePickerView:(CY_DatePickerView *)pickerView didSelectDoneWithDate:(NSDate *)date;

@end

@interface CY_DatePickerView : CY_BlurView
@property (nonatomic, weak) id<CY_DatePickerViewDelegate> delegate;
@property (nonatomic, strong) UIButton *cc_saveButton;
// Default is UIDatePickerModeDate;
@property (nonatomic, strong) UIDatePicker *cc_datePicker;
@property (nonatomic, copy) void(^didSelectDone)(NSDate *date);

- (void)showInView:(UIView *)view;
- (void)dismiss;
@end
