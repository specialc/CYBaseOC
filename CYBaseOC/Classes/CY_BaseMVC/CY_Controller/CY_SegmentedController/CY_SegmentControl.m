//
//  CY_SegmentControl.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_SegmentControl.h"
#import <objc/runtime.h>

@interface CY_SegmentControl ()
@property (nonatomic, copy) CY_SegmentControlIndexChangeBlock impl_indexChangeBlock;
@end

@implementation CY_SegmentControl

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        self.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        self.selectionIndicatorHeight = 2.0f;
        self.selectionIndicatorColor = @"#999999".cc_color;
        self.borderColor = @"#ECEEF0".cc_color;
        self.borderType = HMSegmentedControlBorderTypeBottom;
        self.borderWidth = 0.5;
        self.titleTextAttributes = @{NSForegroundColorAttributeName : @"#999999".cc_color, NSFontAttributeName : @"15px".cc_font};
        self.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : @"#333333".cc_color, NSFontAttributeName : @"15px".cc_font};
    }
    return self;
}

- (NSInteger)cc_selectedSegmentIndex {
    return self.selectedSegmentIndex;
}

- (void)setCc_selectedSegmentIndex:(NSInteger)cc_selectedSegmentIndex {
    self.selectedSegmentIndex = cc_selectedSegmentIndex;
}

- (void)setCc_selectedSegmentIndex:(NSInteger)cc_selectedSegmentIndex animated:(BOOL)animated {
    [self setSelectedSegmentIndex:cc_selectedSegmentIndex animated:animated];
}

- (CY_SegmentControlIndexChangeBlock)cc_IndexChangeBlock {
    return self.impl_indexChangeBlock;
}

- (void)setCc_IndexChangeBlock:(CY_SegmentControlIndexChangeBlock)cc_IndexChangeBlock {
    self.impl_indexChangeBlock = cc_IndexChangeBlock;
    
    weakify_self
    self.indexChangeBlock = ^(NSInteger index) {
        strongify_self
        if (self.impl_indexChangeBlock) {
            self.impl_indexChangeBlock(index);
        }
    };
}

- (NSArray<NSString *> *)cc_sectionTitles {
    return self.sectionTitles;
}

- (void)setCc_sectionTitles:(NSArray<NSString *> *)cc_sectionTitles {
    self.sectionTitles = cc_sectionTitles;
}


@end
