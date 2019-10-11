//
//  CY_PythiaSeparatorLayerCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/25.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaSeparatorLayerCell.h"

@interface CY_PythiaSeparatorLayerCell ()
@property (nonatomic, weak) CY_BaseView *separatorView;
@end

@implementation CY_PythiaSeparatorLayerCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadSeparator];
    }
    return self;
}

- (instancetype)initWithCellHeight:(CGFloat)height {
    self = [self init];
    if (self) {
        self.cc_cellHeight = height;
    }
    return self;
}

- (void)loadSeparator {
    CY_BaseView *view = [[CY_BaseView alloc] init];
    [self.contentView addSubview:view];
    self.separatorView = view;
    
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.right.equalTo(0);
        make.height.mas_equalTo(10).priorityHigh();
    }];
}

- (void)setCc_cellHeight:(CGFloat)cc_cellHeight {
    if (self->_cc_cellHeight != cc_cellHeight) {
        self->_cc_cellHeight = cc_cellHeight;
        [self.separatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(cc_cellHeight).priorityHigh();
        }];
    }
}

- (UIColor *)cc_layoutColor {
    return self.contentView.backgroundColor;
}

- (void)setCc_layoutColor:(UIColor *)cc_layoutColor {
    self.contentView.backgroundColor = cc_layoutColor;
}

@end
