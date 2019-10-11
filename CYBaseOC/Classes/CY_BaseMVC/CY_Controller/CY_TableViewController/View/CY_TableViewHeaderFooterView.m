//
//  CY_TableViewHeaderFooterView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewHeaderFooterView.h"

@implementation CY_TableViewHeaderFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self cc_loadViews];
    [self cc_layoutConstraints];
}

#pragma mark - 构造函数

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self cc_loadViews];
        [self cc_layoutConstraints];
    }
    return self;
}

#pragma mark - Subview处理函数

- (void)cc_loadViews {
    self.contentView.backgroundColor = UIColor.clearColor;
    
    _cc_separatorColor = [UIColor cc_colorWithRGB:0xF4F4F4];
    _cc_separatorEdgeInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _cc_separatorHeight = 1.f;
    
    CY_ImageView *separator = [[CY_ImageView alloc] init];
    [self.contentView addSubview:separator];
    _cc_separator = separator;
    _cc_separator.image = self.cc_separatorColor.cc_solidImage;
    [self.cc_separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cc_separatorEdgeInset.left);
        make.right.equalTo(-self.cc_separatorEdgeInset.right);
        make.bottom.equalTo(-self.cc_separatorEdgeInset.bottom);
        make.height.equalTo(self.cc_separatorHeight).priorityHigh();
    }];
    
    self.cc_separatorHidden = YES;
}

- (void)cc_layoutConstraints {
    
}

#pragma mark - Getter Setter

- (UIColor *)cc_backgroundColor {
    return self.contentView.backgroundColor;
}

- (void)setCc_backgroundColor:(UIColor *)cc_backgroundColor {
    self.contentView.backgroundColor = cc_backgroundColor;
}

- (void)setCc_separatorHidden:(BOOL)cc_separatorHidden {
    self->_cc_separatorHidden = cc_separatorHidden;
    self.cc_separator.hidden = cc_separatorHidden;
}

- (void)setCc_separatorEdgeInset:(UIEdgeInsets)cc_separatorEdgeInset {
    _cc_separatorEdgeInset = cc_separatorEdgeInset;
    [self.cc_separator updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cc_separatorEdgeInset.left);
        make.right.equalTo(-cc_separatorEdgeInset.right);
        make.bottom.equalTo(-cc_separatorEdgeInset.bottom);
    }];
}

- (void)setCc_separatorHeight:(CGFloat)cc_separatorHeight {
    _cc_separatorHeight = cc_separatorHeight;
    [self.cc_separator updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.cc_separatorHeight).priorityHigh();
    }];
}

- (void)setCc_separatorColor:(UIColor *)cc_separatorColor {
    _cc_separatorColor = cc_separatorColor;
    self.cc_separator.image = cc_separatorColor.cc_solidImage;
}

@end
