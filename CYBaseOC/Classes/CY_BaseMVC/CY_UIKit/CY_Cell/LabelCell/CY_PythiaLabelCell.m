//
//  CY_PythiaLabelCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaLabelCell.h"

@implementation CY_PythiaLabelCell

#pragma mark - 页面构造
- (instancetype)init {
    self = [super init];
    if (self) {
        self.cc_backgroundColor = UIColor.clearColor;
        self.cc_minimumCellHeight = 0;
        self.cc_edgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        self.cc_title = @"";
        self.cc_titleColor = rgba(186, 186, 186, 1);
        self.cc_titleFont = @"13px".cc_font;
    }
    return self;
}

@end
