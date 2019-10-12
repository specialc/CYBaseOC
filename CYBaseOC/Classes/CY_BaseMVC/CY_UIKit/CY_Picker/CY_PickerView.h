//
//  CY_PickerView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BlurView.h"
#import "CY_Lib.h"

@class CY_PickerView;

@protocol CY_PickerViewDelegate <NSObject>

@optional
- (void)cc_pickerViewDidCancel:(CY_PickerView *)pickerView;
- (void)cc_pickerView:(CY_PickerView *)pickerView didSelectDoneWithIndex:(NSInteger)index;

@end

@interface CY_PickerView : CY_BlurView
@property (nonatomic, weak) id<CY_PickerViewDelegate> delegate;
@property (nonatomic, strong) UIButton *cc_saveButton;
@property (nonatomic, strong) UIPickerView *cc_pickerView;
@property (nonatomic, strong) NSArray<CY_PickerModel *> *pickerModels;
@property (nonatomic, assign) NSInteger selectIndex;

- (instancetype)initWithPickerModels:(NSArray<CY_PickerModel *> *)pickerModels;
- (void)setSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated;
- (void)showInView:(UIView *)view;
- (void)dismiss;
@end

