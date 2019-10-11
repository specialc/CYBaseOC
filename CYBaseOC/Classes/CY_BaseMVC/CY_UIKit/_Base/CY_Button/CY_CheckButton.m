//
//  CY_CheckButton.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_CheckButton.h"

@interface CY_CheckButton ()

@end

@implementation CY_CheckButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (BOOL)isChecked {
    return self.selected;
}

- (void)setCc_checked:(BOOL)cc_checked {
    self.selected = cc_checked;
}

- (UIImage *)cc_checkedImage {
    return self.cc_selectedImage;
}

- (void)setCc_checkedImage:(UIImage *)cc_checkedImage {
    self.cc_selectedImage = cc_checkedImage;
}

- (UIImage *)cc_uncheckedImage {
    return self.cc_normalImage;
}

- (void)setCc_uncheckedImage:(UIImage *)cc_uncheckedImage {
    self.cc_normalImage = cc_uncheckedImage;
}

- (void)handleTouchUpInside:(CY_CheckButton *)sender {
    sender.selected = !sender.selected;
}

@end
