//
//  CY_SeparatorLayerCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_SeparatorLayerCell.h"

@interface CY_SeparatorLayerCell ()
@property (nonatomic, weak) CY_BaseView *separatorView;
@end

@implementation CY_SeparatorLayerCell

- (instancetype)initWithFrame:(CGRect)frame     {
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
    CY_BaseView *separatorView = [[CY_BaseView alloc] init];
    [self.contentView addSubview:separatorView];
    self.separatorView = separatorView;
    
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
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

- (UIColor *)cc_layerColor {
    return self.contentView.backgroundColor;
}

- (void)setCc_layerColor:(UIColor *)cc_layerColor {
    self.contentView.backgroundColor = cc_layerColor;
}

@end
