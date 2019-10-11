//
//  CY_LabelCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_LabelCell.h"

@implementation CY_LabelCell

#pragma mark - 页面构造

// 创建控件
- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cc_backgroundColor = UIColor.whiteColor;
    
    _cc_minimumCellHeight = 44;
    _cc_leftPadding = 15;
    _cc_topPadding = 8;
    _cc_bottomPadding = 8;
    _cc_rightPadding = 15;
    
    {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.cc_bgView = view;
    }
    {
        CY_BaseLabel *label = [[CY_BaseLabel alloc] init];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = 0.8;
        [self.cc_bgView addSubview:label];
        self.cc_titleLabel = label;
    }
    
    self.cc_title = @"";
    self.cc_titleColor = @"label_strong_color".cc_color;
    self.cc_titleFont = @"label_17px_font".cc_font;
}

// 布局
- (void)cc_layoutConstraints {
    [super cc_layoutConstraints];
    
    [self.cc_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.height.greaterThanOrEqualTo(self.cc_minimumCellHeight).priorityHigh();
    }];
    
    [self.cc_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cc_leftPadding);
        make.right.equalTo(-self.cc_rightPadding);
        make.top.equalTo(self.cc_topPadding).priorityMedium();
        make.bottom.equalTo(-self.cc_bottomPadding).priorityMedium();
        make.centerY.equalTo(0).priorityLow();
    }];
}

#pragma mark - Getter and Setter

#pragma mark - 行

- (void)setCc_minimumCellHeight:(CGFloat)cc_minimumCellHeight {
    _cc_minimumCellHeight = cc_minimumCellHeight;
    [self cc_layoutConstraints];
}

#pragma mark - 外边框

- (void)setCc_topPadding:(CGFloat)cc_topPadding {
    self->_cc_topPadding = cc_topPadding;
    [self cc_layoutConstraints];
}

- (void)setCc_bottomPadding:(CGFloat)cc_bottomPadding {
    self->_cc_bottomPadding = cc_bottomPadding;
    [self cc_layoutConstraints];
}

- (void)setCc_leftPadding:(CGFloat)cc_leftPadding {
    self->_cc_leftPadding = cc_leftPadding;
    [self cc_layoutConstraints];
}

- (void)setCc_rightPadding:(CGFloat)cc_rightPadding {
    self->_cc_rightPadding = cc_rightPadding;
    [self cc_layoutConstraints];
}

- (void)setCc_edgeInsets:(UIEdgeInsets)cc_edgeInsets {
    self.cc_topPadding = cc_edgeInsets.top;
    self.cc_leftPadding = cc_edgeInsets.left;
    self.cc_bottomPadding = cc_edgeInsets.bottom;
    self.cc_rightPadding = cc_edgeInsets.right;
}

- (UIEdgeInsets)cc_edgeInsets {
    return UIEdgeInsetsMake(self.cc_topPadding, self.cc_leftPadding, self.cc_bottomPadding, self.cc_rightPadding);
}

#pragma mark - 属性

- (NSString *)cc_title {
    return self.cc_titleLabel.text;
}

- (void)setCc_title:(NSString *)cc_title {
    self.cc_titleLabel.text = cc_title;
}

- (UIColor *)cc_titleColor {
    return self.cc_titleLabel.textColor;
}

- (void)setCc_titleColor:(UIColor *)cc_titleColor {
    self.cc_titleLabel.textColor = cc_titleColor;
}

- (UIFont *)cc_titleFont {
    return self.cc_titleLabel.font;
}

- (void)setCc_titleFont:(UIFont *)cc_titleFont {
    self.cc_titleLabel.font = cc_titleFont;
}

@end
