//
//  CY_PythiaPlainCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaPlainCell.h"

static void *PythiaPlainCellLeftImageChanged = &PythiaPlainCellLeftImageChanged;
static void *PythiaPlainCellRightImageChanged = &PythiaPlainCellRightImageChanged;

@interface CY_PythiaPlainCell ()

@end

@implementation CY_PythiaPlainCell

- (void)cc_loadViews {
    [super cc_loadViews];
    
    _cc_cellHeight = 44;
    _cc_rightSpace = 15;
    _cc_contentRightViewSpace = 8;
    
    {
        CY_ImageView *imgV = [[CY_ImageView alloc] init];
        [self.contentView addSubview:imgV];
        _leftImageView = imgV;
    }
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
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    {
        CY_ImageView *imgV = [[CY_ImageView alloc] init];
        [self.contentView addSubview:imgV];
        _rightImageView = imgV;
    }
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:@"leftImageView.image" options:options context:PythiaPlainCellLeftImageChanged];
    [self addObserver:self forKeyPath:@"rightImageView.image" options:options context:PythiaPlainCellRightImageChanged];
}

- (void)cc_layoutConstraints {
    [self.contentView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.height.greaterThanOrEqualTo(self.cc_cellHeight);
        make.width.equalTo(self.contentView.superview);
    }];
    
    // 左侧
    [self.leftImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(15);
        make.cc_hugging.cc_compression.cc_priorityRequired();
    }];
    
    if (self.leftView) {
        self.leftView.hidden = NO;
        self.leftImageView.hidden = YES;
        [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftView.mas_right).offset(8);
            make.centerY.equalTo(0);
            make.cc_hugging.cc_compression.cc_priorityRequired();
        }];
        
        [self.leftView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
            make.cc_hugging.cc_compression.cc_priorityRequired();
        }];
    }
    else if (self.leftImageView.image) {
        self.leftView.hidden = YES;
        self.leftImageView.hidden = NO;
        [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImageView.mas_right).offset(8);
            make.centerY.equalTo(0);
            make.cc_hugging.cc_compression.cc_priorityRequired();
        }];
    }
    else {
        self.leftView.hidden = YES;
        self.leftImageView.hidden = YES;
        [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            make.cc_hugging.cc_compression.cc_priorityRequired();
        }];
    }
    
    // 右侧
    [self.rightImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-self.cc_rightSpace);
        make.cc_hugging.cc_compression.cc_priorityRequired();
    }];
    
    if (self.rightView) {
        self.rightImageView.hidden = YES;
        self.rightView.hidden = NO;
        [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(8);
            make.bottom.lessThanOrEqualTo(-8);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(15);
            make.centerY.equalTo(0);
            make.right.equalTo(self.rightView.mas_left).offset(-self.cc_contentRightViewSpace);
            make.cc_hugging.cc_compression.cc_priorityLow();
        }];
        
        [self.rightView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-self.cc_rightSpace);
            make.cc_hugging.cc_compression.cc_priorityRequired();
        }];
    }
    else if (self.rightImageView.image) {
        self.rightView.hidden = YES;
        self.rightImageView.hidden = NO;
        [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(8);
            make.bottom.lessThanOrEqualTo(-8);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(15);
            make.centerY.equalTo(0);
            make.right.equalTo(self.rightImageView.mas_left).offset(-self.cc_contentRightViewSpace);
            make.cc_hugging.cc_compression.cc_priorityLow();
        }];
    }
    else {
        self.rightView.hidden = YES;
        self.rightImageView.hidden = YES;
        [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(8);
            make.bottom.lessThanOrEqualTo(-8);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(15);
            make.centerY.equalTo(0);
            make.right.equalTo(-self.cc_rightSpace);
            make.cc_hugging.cc_compression.cc_priorityLow();
        }];
    }
}

- (void)setCc_cellHeight:(CGFloat)cc_cellHeight {
    _cc_cellHeight = cc_cellHeight;
    [self cc_layoutConstraints];
}

- (void)setCc_rightSpace:(CGFloat)cc_rightSpace {
    _cc_rightSpace = cc_rightSpace;
    [self cc_layoutConstraints];
}

- (void)setCc_contentRightViewSpace:(CGFloat)cc_contentRightViewSpace {
    _cc_contentRightViewSpace = cc_contentRightViewSpace;
    [self cc_layoutConstraints];
}

- (void)setLeftView:(UIView *)leftView {
    if (_leftView) {
        [_leftView removeFromSuperview];
    }
    
    _leftView = leftView;
    [self.contentView addSubview:leftView];
    [self cc_layoutConstraints];
}

- (void)setRightView:(UIView *)rightView {
    if (_rightView) {
        [_rightView removeFromSuperview];
    }
    
    _rightView = rightView;
    [self.contentView addSubview:rightView];
    [self cc_layoutConstraints];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == PythiaPlainCellLeftImageChanged || context == PythiaPlainCellRightImageChanged) {
        [self cc_layoutConstraints];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"leftImageView.image" context:PythiaPlainCellLeftImageChanged];
    [self removeObserver:self forKeyPath:@"rightImageView.image" context:PythiaPlainCellRightImageChanged];
}

@end
