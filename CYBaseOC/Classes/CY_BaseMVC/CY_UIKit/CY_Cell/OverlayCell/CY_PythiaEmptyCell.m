//
//  CY_PythiaEmptyCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaEmptyCell.h"

@interface CY_PythiaEmptyCell ()

@end

@implementation CY_PythiaEmptyCell

- (void)cc_loadViews {
    [super cc_loadViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _cc_topMargin = 88;
    
    {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = @"icon_trade_record_empty".cc_image;
        [self.contentView addSubview:imgV];
        self.iconImageView = imgV;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.font = @"15px".cc_font;
        label.textColor = rgba(165, 165, 165, 1);
        [self.contentView addSubview:label];
        self.titleLabel = label;
    }
}

- (void)cc_layoutConstraints {
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_cc_topMargin);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
        make.bottom.equalTo(-15);
    }];
}

- (void)setCc_topMargin:(CGFloat)cc_topMargin {
    _cc_topMargin = cc_topMargin;
    [self cc_layoutConstraints];
}

@end
