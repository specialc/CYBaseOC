//
//  CY_AddressPickerView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_AddressPickerView.h"

@interface CY_AddressPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) CY_Control *backgroundOverlayView;
@property (nonatomic, strong) CY_BaseView *backView;
@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger areaIndex;
@property (nonatomic, assign) NSInteger priviousProvinceIndex;
@property (nonatomic, assign) NSInteger priviousCityIndex;
@property (nonatomic, assign) NSInteger priviousAreaIndex;
@end

@implementation CY_AddressPickerView

#pragma mark - 构造函数

- (instancetype)initWithAddress:(CY_Address *)address {
    self = [self init];
    if (self) {
        self.address = address;
    }
    return self;
}

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
        [self.backgroundOverlayView addTarget:self action:@selector(handleTouchCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        self.backView = [[CY_BaseView alloc] init];
        [self addSubview:self.backView];
        self.backView.backgroundColor = UIColor.whiteColor;
    }
    {
        self.cc_pickerView = [[UIPickerView alloc] init];
        [self.backView addSubview:self.cc_pickerView];
        self.cc_pickerView.delegate = self;
        self.cc_pickerView.dataSource = self;
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
    
    [self.cc_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(self.cc_saveButton.mas_top);
    }];
    
    [self.cc_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(44);
    }];
}

#pragma mark - PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    @try {
        // 省份
        if (component == 0) {
            return self.address.provinces.count;
        }
        // 城市
        else if (component == 1) {
            if (self.provinceIndex > self.address.provinces.count - 1) {
                self.provinceIndex = 0;
            }
            return self.address.provinces[self.provinceIndex].citys.count;
        }
        // 区
        else if (component == 2) {
            if (self.cityIndex > self.address.provinces[self.provinceIndex].citys.count - 1) {
                self.cityIndex = 0;
            }
            return self.address.provinces[self.provinceIndex].citys[self.cityIndex].areas.count;
        }
        else {
            return 0;
        }
    } @catch (NSException *exception) {
        LogError(@"%@", exception);
        return 0;
    } @finally {
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    @try {
        // TODO: 还有BUG没有处理完
        // 省份
        if (component == 0) {
            return self.address.provinces[row].name;
        }
        // 城市
        else if (component == 1) {
            return self.address.provinces[self.provinceIndex].citys[row].name;
        }
        // 区
        else if (component == 2) {
            return self.address.provinces[self.provinceIndex].citys[self.cityIndex].areas[row].name;
        }
        else {
            return @"出错".cc_localizedString;
        }
    } @catch (NSException *exception) {
        LogError(@"%@",exception);
        return @"出错".cc_localizedString;
    } @finally {
        
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // 省份
    if (component == 0) {
        if (self.provinceIndex != row) {
            self.provinceIndex = row;
            self.cityIndex = 0;
            self.areaIndex = 0;
            [self.cc_pickerView reloadAllComponents];
            [self.cc_pickerView selectRow:0 inComponent:1 animated:YES];
            [self.cc_pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    // 城市
    else if (component == 1) {
        if (self.cityIndex != row) {
            self.cityIndex = row;
            self.areaIndex = 0;
            [self.cc_pickerView reloadAllComponents];
            [self.cc_pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    // 区
    else if (component == 2) {
        self.areaIndex = row;
        [self.cc_pickerView reloadAllComponents];
    }
    
    [self.address setCurrentAddressWithProvinceIndex:self.provinceIndex cityIndex:self.cityIndex areaIndex:self.areaIndex];
}

#pragma mark - Touches

- (void)handleTouchCancel:(CY_Control *)sender {
    self.provinceIndex = self.priviousProvinceIndex;
    self.cityIndex = self.priviousCityIndex;
    self.areaIndex = self.priviousAreaIndex;
    [self.address setCurrentAddressWithProvinceIndex:self.provinceIndex cityIndex:self.cityIndex areaIndex:self.areaIndex];
    
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_addressPickerViewDidCancel:)]) {
        [self.delegate cc_addressPickerViewDidCancel:self];
    }
}

- (void)handleDone:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_addressPickerView:didSelectDoneWithAddress:)]) {
        [self.delegate cc_addressPickerView:self didSelectDoneWithAddress:self.address];
    }
}

- (void)selectAddressWithProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex {
    self.provinceIndex = provinceIndex;
    self.cityIndex = cityIndex;
    self.areaIndex = areaIndex;
    self.priviousProvinceIndex = provinceIndex;
    self.priviousCityIndex = cityIndex;
    self.priviousAreaIndex = areaIndex;
    
    // 很奇怪 以前没有这个问题。必须延迟以后再能选择第二个
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.cc_pickerView selectRow:provinceIndex inComponent:0 animated:YES];
        [self.cc_pickerView selectRow:cityIndex inComponent:1 animated:YES];
        [self.cc_pickerView selectRow:areaIndex inComponent:2 animated:YES];
    });
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
