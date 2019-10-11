//
//  CY_PythiaIconLabelCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaIconLabelCell.h"

@interface CY_PythiaIconLabelCell ()
@property (nonatomic, strong) MASConstraint *titleCenterXConstaint;
@end

@implementation CY_PythiaIconLabelCell

- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.cc_titleLabel.textAlignment = NSTextAlignmentLeft;
    CY_ImageView *cc_iconView = [[CY_ImageView alloc] init];
    [self.cc_bgView addSubview:cc_iconView];
    self.cc_iconView = cc_iconView;
    
    _cc_iconPosition = CY_IconPositionLeftMiddle;
    _cc_iconHorizontal = 0;
}

- (void)cc_layoutConstraints {
    [super cc_layoutConstraints];
    
    switch (self.cc_iconPosition) {
        case CY_IconPositionLeftTop:
            {
                [self.cc_iconView remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.greaterThanOrEqualTo(self.cc_leftPadding);
                    make.top.equalTo(self.cc_titleLabel.mas_top).offset(1);
                    if (!CGSizeEqualToSize(CGSizeZero, self.cc_iconSize)) {
                        make.size.equalTo(self.cc_iconSize);
                    }
                    make.cc_compression.cc_priorityRequired();
                    make.cc_hugging.cc_priorityHigh();
                }];
                [self.cc_titleLabel remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.cc_iconView.mas_right).offset(8);
                    make.right.equalTo(-self.cc_rightPadding);
                    make.top.equalTo(self.cc_topPadding);
                    make.bottom.equalTo(-self.cc_bottomPadding);
                    self.titleCenterXConstaint = make.centerX.equalTo(0);
                    make.centerY.equalTo(0).priorityLow();
                }];
            }
            break;
            
        case CY_IconPositionLeftMiddle:
        {
            [self.cc_iconView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(self.cc_leftPadding);
                make.centerY.equalTo(self.cc_titleLabel.mas_centerY).offset(0);
                if (!CGSizeEqualToSize(CGSizeZero, self.cc_iconSize)) {
                    make.size.equalTo(self.cc_iconSize);
                }
                make.cc_compression.cc_priorityRequired();
                make.cc_hugging.cc_priorityHigh();
            }];
            [self.cc_titleLabel remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cc_iconView.mas_right).offset(8);
                make.right.equalTo(-self.cc_rightPadding);
                make.top.equalTo(self.cc_topPadding);
                make.bottom.equalTo(-self.cc_bottomPadding);
                self.titleCenterXConstaint = make.centerX.equalTo(0);
                make.centerY.equalTo(0).priorityLow();
            }];
        }
            break;
            
        default:
            break;
    }
    
    if (self.cc_iconHorizontal) {
        [self.cc_iconView updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cc_iconHorizontal);
        }];
        self.cc_titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.titleCenterXConstaint uninstall];
    }
    else {
        [self.cc_iconView updateConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(self.cc_leftPadding);
        }];
        self.cc_titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleCenterXConstaint install];
    }
}

- (UIImage *)cc_icon {
    return self.cc_iconView.image;
}

- (void)setCc_icon:(UIImage *)cc_icon {
    self.cc_iconView.image = cc_icon;
    [self cc_layoutConstraints];
}

- (void)setCc_iconSize:(CGSize)cc_iconSize {
    _cc_iconSize = cc_iconSize;
    [self cc_layoutConstraints];
}

- (void)setCc_iconPosition:(CY_IconPosition)cc_iconPosition {
    self->_cc_iconPosition = cc_iconPosition;
    [self cc_layoutConstraints];
}

- (void)setCc_iconHorizontal:(CGFloat)cc_iconHorizontal {
    self->_cc_iconHorizontal = cc_iconHorizontal;
    [self cc_layoutConstraints];
}

@end
