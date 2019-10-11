//
//  CY_PythiaTierCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaTierCell.h"

@interface CY_PythiaTierCell ()

@end

@implementation CY_PythiaTierCell

- (void)cc_loadViews {
    [super cc_loadViews];
    
    {
        CY_BaseLabel *label = [[CY_BaseLabel alloc] init];
        label.font = @"15px".cc_font;
        label.textColor = @"#383838".cc_color;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    {
        CY_BaseLabel *label = [[CY_BaseLabel alloc] init];
        label.font = @"15px".cc_font;
        label.textColor = @"#383838".cc_color;
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    {
        CY_BaseLabel *label = [[CY_BaseLabel alloc] init];
        label.font = @"13px".cc_font;
        label.textColor = @"#999999".cc_color;
        label.numberOfLines = 0;
        label.minimumScaleFactor = 0.8;
        label.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:label];
        _descLabel = label;
    }
}

- (void)cc_layoutConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(12);
        make.left.equalTo(15);
        make.width.equalTo(ScreenWidth - 15 - 120);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(12);
        make.right.equalTo(-15);
        make.cc_hugging.cc_priorityRequired();
        make.cc_compression.cc_priorityRequired();
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.width.equalTo(ScreenWidth - 30);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
        make.bottom.equalTo(-12);
    }];
}

@end
