//
//  CY_WexSegmentedCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/25.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_WexSegmentedCell.h"

@interface CY_WexSegmentedCell ()

@end

@implementation CY_WexSegmentedCell

- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.selectionStyle = 0;
    
    _selectedFont = @"15px".cc_font;
    _selectedColor = @"#FFB524".cc_color;
    
    _normalFont = @"15px".cc_font;
    _normalColor = @"#666666".cc_color;
    
    _selectionIndicatorColor = @"#FFB824".cc_color;
    
    {
        HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] init];
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        segmentedControl.selectionIndicatorHeight = 2;
        segmentedControl.borderWidth = 0.5;
        segmentedControl.borderColor = @"#ECEEF0".cc_color;
        segmentedControl.borderType = HMSegmentedControlBorderTypeBottom;
        [self.contentView addSubview:segmentedControl];
        self.cc_segmentedControl = segmentedControl;
        
        [self setStyle];
    }
}

- (void)cc_layoutConstraints {
    [self.cc_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.mas_equalTo(44).priorityHigh();
    }];
}

- (NSArray *)cc_sectionTitles {
    return self.cc_segmentedControl.sectionTitles;
}

- (void)setCc_sectionTitles:(NSArray *)cc_sectionTitles {
    self.cc_segmentedControl.sectionTitles = cc_sectionTitles;
}

- (IndexChangeBlock)indexChangeBlock {
    return self.cc_segmentedControl.indexChangeBlock;
}

- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock {
    self.cc_segmentedControl.indexChangeBlock = indexChangeBlock;
}

- (void)setStyle {
    self.cc_segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:self.normalColor, NSFontAttributeName:self.normalFont};
    self.cc_segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:self.selectedColor, NSFontAttributeName:self.selectedFont};
    self.cc_segmentedControl.selectionIndicatorColor = self.selectionIndicatorColor;
}

- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    [self setStyle];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [self setStyle];
}

- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
    [self setStyle];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    [self setStyle];
}

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
    _selectionIndicatorColor = selectionIndicatorColor;
    [self setStyle];
}

@end
