//
//  CY_PythiaMultiLineCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaMultiLineCell.h"

@implementation CY_PythiaMultiLineCell

- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.selectionStyle = 0;
    {
        CY_BaseLabel *label = [[CY_BaseLabel alloc] init];
        label.font = @"15px".cc_font;
        label.textColor = rgba(35, 37, 45, 1);
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    {
        CY_BaseLabel *label = [[CY_BaseLabel alloc] init];
        label.font = @"15px".cc_font;
        label.textColor = rgba(165, 165, 165, 1);
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
}

- (void)cc_layoutConstraints {
    [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.bottom.lessThanOrEqualTo(-10);
        make.left.equalTo(15);
        make.cc_hugging.cc_priorityRequired();
        make.cc_compression.cc_priorityRequired();
    }];
    
    [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.bottom.lessThanOrEqualTo(-10);
        make.right.equalTo(-15);
        make.centerY.equalTo(0);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(8);
    }];
}

@end
