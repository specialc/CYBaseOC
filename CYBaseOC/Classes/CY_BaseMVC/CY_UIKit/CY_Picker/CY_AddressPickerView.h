//
//  CY_AddressPickerView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BlurView.h"
#import "CY_Address.h"

@class CY_AddressPickerView;

@protocol CY_AddressPickerViewDelegate <NSObject>

@optional
- (void)cc_addressPickerViewDidCancel:(CY_AddressPickerView *)pickerView;
- (void)cc_addressPickerView:(CY_AddressPickerView *)pickerView didSelectDoneWithAddress:(CY_Address *)address;

@end

@interface CY_AddressPickerView : CY_BlurView
@property (nonatomic, weak) id<CY_AddressPickerViewDelegate> delegate;
@property (nonatomic, strong) UIButton *cc_saveButton;
@property (nonatomic, strong) UIPickerView *cc_pickerView;
@property (nonatomic, strong) CY_Address *address;

- (instancetype)initWithAddress:(CY_Address *)address;
- (void)selectAddressWithProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex;
- (void)showInView:(UIView *)view;
- (void)dismiss;
@end

