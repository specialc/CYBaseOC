//
//  CY_PickerView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PickerView.h"

@interface CY_PickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) CY_Control *backgroundOverlayView;
@property (nonatomic, strong) CY_BaseView *backView;
@end

@implementation CY_PickerView

- (instancetype)initWithPickerModels:(NSArray<CY_PickerModel *> *)pickerModels {
    if (self = [self init]) {
        self.pickerModels = pickerModels;
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

#pragma mark - PickerDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerModels.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CY_PickerModel *pickerModel = self.pickerModels[row];
    return pickerModel.value;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger selectedIndex = [pickerView selectedRowInComponent:0];
    _selectIndex = selectedIndex;
}

#pragma mark - Handle

- (void)handleTouchCancel:(CY_Control *)sender {
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_pickerViewDidCancel:)]) {
        [self.delegate cc_pickerViewDidCancel:self];
    }
}

- (void)handleDone:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_pickerView:didSelectDoneWithIndex:)]) {
        [self.delegate cc_pickerView:self didSelectDoneWithIndex:self.selectIndex];
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

#pragma mark - Setter

- (void)setSelectIndex:(NSInteger)selectIndex {
    [self setSelectIndex:selectIndex animated:NO];
}

- (void)setSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated {
    self->_selectIndex = selectIndex;
    [self.cc_pickerView selectRow:selectIndex inComponent:0 animated:animated];
}


@end
