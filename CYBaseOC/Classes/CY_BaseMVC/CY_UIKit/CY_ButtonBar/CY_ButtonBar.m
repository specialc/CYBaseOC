//
//  CY_ButtonBar.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_ButtonBar.h"

@implementation CY_ButtonBar

+ (CY_ButtonBar *)cc_createButtonBarInView:(UIView *)view {
    CY_ButtonBar *buttonBar = [[CY_ButtonBar alloc] init];
    buttonBar.frame = CGRectMake(0, 0, ScreenWidth, is_iPhoneX ? 78 : 44);
    [view addSubview:buttonBar];
    [buttonBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
    }];
    return buttonBar;
}

- (void)cc_loadViews {
    [super cc_loadViews];
    self.backgroundColor = @"#FFFFFF".cc_colorWithAlpha(0.7);
    
    {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        self.cc_contentView = view;
    }
    
    _edgeInsetForiPhoneNormal = UIEdgeInsetsZero;
    _edgeInsetForiPhoneX = UIEdgeInsetsMake(15, 15, 0, 15);
    _cornerRadiusForiPhoneX = 4;
}

- (void)cc_layoutConstraints {
    if (is_iPhoneX) {
        self.cc_contentView.layer.cornerRadius = self.cornerRadiusForiPhoneX;
        self.cc_contentView.layer.masksToBounds = YES;
    }
    
    UIEdgeInsets edgeNormal = self.edgeInsetForiPhoneNormal;
    UIEdgeInsets edgeiPhoneX = self.edgeInsetForiPhoneX;
    
    [self.cc_contentView remakeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(44);
        make.top.equalTo(is_iPhoneX ? edgeiPhoneX.top : edgeNormal.top);
        make.left.equalTo(is_iPhoneX ? edgeiPhoneX.left : edgeNormal.left);
        make.right.equalTo(is_iPhoneX ? -edgeiPhoneX.right : -edgeNormal.right);
        make.bottom.equalTo(is_iPhoneX ? -edgeiPhoneX.bottom - 34 : -edgeNormal.bottom);
    }];
}

#pragma mark - Setter

- (void)setEdgeInsetForiPhoneNormal:(UIEdgeInsets)edgeInsetForiPhoneNormal {
    _edgeInsetForiPhoneNormal = edgeInsetForiPhoneNormal;
    
    [self cc_layoutConstraints];
}

- (void)setEdgeInsetForiPhoneX:(UIEdgeInsets)edgeInsetForiPhoneX {
    _edgeInsetForiPhoneX = edgeInsetForiPhoneX;
    
    [self cc_layoutConstraints];
}

- (void)setCornerRadiusForiPhoneX:(CGFloat)cornerRadiusForiPhoneX {
    _cornerRadiusForiPhoneX = cornerRadiusForiPhoneX;
    
    [self cc_layoutConstraints];
}

@end
