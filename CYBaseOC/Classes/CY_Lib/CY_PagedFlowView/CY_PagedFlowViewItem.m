//
//  CY_PagedFlowViewItem.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PagedFlowViewItem.h"

@implementation CY_PagedFlowViewItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
    }
    return self;
}

- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
//        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}

@end
