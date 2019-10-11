//
//  CY_NavBar.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_NavBar.h"

@interface CY_NavBar () {}

@end

@implementation CY_NavBar

#pragma mark - 页面

- (void)cc_loadViews {
    [super cc_loadViews];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    self.cc_backgroundImgView = imgView;
    
    {
        CY_BaseView *navView = [[CY_BaseView alloc] init];
        [self addSubview:navView];
        self.cc_navigationView = navView;
    }
    {
        self.cc_titleLabel = [[CY_BaseLabel alloc] init];
        self.cc_titleLabel.font = @"17px-bold".cc_font;
        self.cc_titleLabel.numberOfLines = 1;
        self.cc_titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.cc_navigationView addSubview:self.cc_titleLabel];
    }
    {
        self.cc_leftButton = [[UIButton alloc] init];
        [self.cc_leftButton addTarget:self action:@selector(didClickCC_LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        self.cc_leftButton.hidden = YES;
        [self.cc_navigationView addSubview:self.cc_leftButton];
    }
    {
        self.cc_leftSecondButton = [[UIButton alloc] init];
        [self.cc_leftSecondButton addTarget:self action:@selector(didClickCC_LeftSecondButton:) forControlEvents:UIControlEventTouchUpInside];
        self.cc_leftSecondButton.hidden = YES;
        [self.cc_navigationView addSubview:self.cc_leftSecondButton];
    }
    {
        self.cc_rightButton = [[UIButton alloc] init];
        [self.cc_rightButton addTarget:self action:@selector(didClickCC_RightButton:) forControlEvents:UIControlEventTouchUpInside];
        self.cc_rightButton.hidden = YES;
        [self.cc_navigationView addSubview:self.cc_rightButton];
    }
    {
        self.cc_separator = [[CY_BaseView alloc] init];
        self.cc_separator.backgroundColor = @"#e4e4e4".cc_color;
        self.cc_separator.hidden = NO;
        [self.cc_navigationView addSubview:self.cc_separator];
    }
}

- (void)cc_layoutConstraints {
    [self.cc_backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    // Navigation
    {
        [self.cc_navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(StatusBarHeight);
            make.height.equalTo(44);
            make.left.right.bottom.equalTo(0);
        }];
        
        [self.cc_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.centerY.equalTo(0);
            make.left.equalTo(self.cc_leftSecondButton.mas_right).offset(8);
            make.right.equalTo(self.cc_rightButton.mas_left).offset(-8);
            make.cc_hugging.cc_priorityRequired();
            make.cc_compression.cc_priorityLow();
        }];
        
        [self.cc_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.height.equalTo(44);
            make.width.equalTo(44);
            make.cc_hugging.cc_priorityRequired();
            make.cc_compression.cc_priorityRequired();
        }];
        
        [self.cc_leftSecondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cc_leftButton.mas_right).equalTo(8);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.cc_hugging.cc_priorityRequired();
            make.cc_compression.cc_priorityRequired();
        }];
        
        [self.cc_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.cc_hugging.cc_priorityRequired();
            make.cc_compression.cc_priorityRequired();
        }];
        
        [self.cc_separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(0.5);
        }];
    }
}

#pragma mark - Setter

- (void)setCc_type:(CY_NavBarType)cc_type {
    _cc_type = cc_type;
    [self cc_clearBackground];
    
    if (cc_type == CY_NavBarTypeClear) {
        self.cc_backgroundColor = UIColor.clearColor;
        self.tintColor = @"#23252D".cc_color;
        self.cc_titleLabel.font = @"17px-bold".cc_font;
        self.cc_titleLabel.textColor = self.tintColor;
        self.cc_separator.hidden = YES;
    }
    else if (cc_type == CY_NavBarTypeLight) {
        self.cc_backgroundColor = @"#FFFFFF".cc_color;
        self.tintColor = @"#23252D".cc_color;
        self.cc_titleLabel.font = @"17px-bold".cc_font;
        self.cc_titleLabel.textColor = self.tintColor;
        self.cc_separator.hidden = NO;
    }
    
    //
    else if (cc_type == CY_NavBarTypeDark) {
        self.cc_backgroundColor = @"#333333".cc_color;
        self.cc_backgroundImage = @"#333333".cc_color.cc_solidImage;
        self.tintColor = @"#FFFFFF".cc_color;
        self.cc_titleLabel.font = @"18px-bold".cc_font;
        self.cc_titleLabel.textColor = self.tintColor;
        self.cc_separator.hidden = YES;
    }
    
    [self setCc_leftButtonType:self.cc_leftButtonType];
    [self setCc_rightButtonType:self.cc_rightButtonType];
}

- (void)setCc_leftButtonType:(CY_NavBarLeftButtonType)cc_leftButtonType {
    _cc_leftButtonType = cc_leftButtonType;
    
    [self cc_clearLeftButton];
    
    self.cc_leftButton.cc_normalTitleColor = self.tintColor;
    self.cc_leftButton.cc_highlightedTitleColor = self.tintColor.cc_colorWithAlpha(0.7);
    
    NSBundle *bundle = [NSBundle bundleForClass:[CY_NavBar class]];
    NSString *path = [bundle pathForResource:@"CY_NavBar" ofType:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:path];
    UIImage *back_image = [UIImage imageNamed:@"cy_navbar_back" inBundle:imageBundle compatibleWithTraitCollection:nil];
    
    if (cc_leftButtonType == CY_NavBarLeftButtonTypeBack) {
        self.cc_leftButton.hidden = NO;
        self.cc_leftButton.userInteractionEnabled = YES;
        self.cc_leftButton.cc_normalImage = back_image.cc_templateImage;
        switch (self.cc_type) {
            case CY_NavBarTypeClear:
            case CY_NavBarTypeLight:
                {
                    self.cc_leftButton.tintColor = @"#999999".cc_color;
                    self.cc_leftButton.cc_normalTitleColor = @"#999999".cc_color;
                    self.cc_leftButton.cc_highlightedTitleColor = @"#999999".cc_color.cc_colorWithAlpha(0.7);
                }
                break;
                
            case CY_NavBarTypeDark:
                {
                    self.cc_leftButton.tintColor = self.tintColor;
                    self.cc_leftButton.cc_normalTitleColor = self.tintColor;
                    self.cc_leftButton.cc_highlightedTitleColor = self.tintColor.cc_colorWithAlpha(0.7);
                }
                break;
                
            default:
                break;
        }
    }
    else if (cc_leftButtonType == CY_NavBarLeftButtonTypeCancel) {
        self.cc_leftButton.hidden = NO;
        self.cc_leftButton.userInteractionEnabled = YES;
        self.cc_leftButton.cc_font = @"15px".cc_font;
        self.cc_leftButton.cc_normalTitle = [self constructTitle:@"取消"];
    }
    else {
        self.cc_leftButton.hidden = YES;
        self.cc_leftButton.userInteractionEnabled = NO;
    }
    
    //
    switch (self.cc_type) {
        case CY_NavBarTypeClear:
        case CY_NavBarTypeLight:
            {
//                self.cc_leftButton.tintColor = @"#999999".cc_color;
                self.cc_leftButton.cc_normalTitleColor = @"#999999".cc_color;
                self.cc_leftButton.cc_highlightedTitleColor = @"#999999".cc_color.cc_colorWithAlpha(0.7);
            }
            break;
            
        case CY_NavBarTypeDark:
            {
//                self.cc_leftButton.tintColor = self.tintColor;
                self.cc_leftButton.cc_normalTitleColor = self.tintColor;
                self.cc_leftButton.cc_highlightedTitleColor = self.tintColor.cc_colorWithAlpha(0.7);
            }
            break;
            
        default:
            break;
    }
}

- (void)setCc_rightButtonType:(CY_NavBarRightButtonType)cc_rightButtonType {
    _cc_rightButtonType = cc_rightButtonType;
    [self cc_clearRightButton];
    
    self.cc_rightButton.hidden = NO;
    self.cc_rightButton.userInteractionEnabled = YES;
    
    if (cc_rightButtonType == CY_NavBarRightButtonTypeShare) {
        self.cc_rightButton.cc_normalImage = @"wcf_navbar_btn_share".cc_image.cc_templateImage;
        self.cc_rightButton.cc_highlightedImage = @"wcf_navbar_btn_share".cc_image.cc_imageWithAlpha(0.7).cc_templateImage;
    }
    else if (cc_rightButtonType == CY_NavBarRightButtonTypeDetail) {
        self.cc_rightButton.cc_normalImage = @"wcf_navbar_btn_detail".cc_image.cc_templateImage;
        self.cc_rightButton.cc_highlightedImage = @"wcf_navbar_btn_detail".cc_image.cc_imageWithAlpha(0.7).cc_templateImage;
    }
    else if (cc_rightButtonType == CY_NavBarRightButtonTypeSearch) {
        self.cc_rightButton.cc_normalImage = @"wcf_navbar_btn_search".cc_image.cc_templateImage;
        self.cc_rightButton.cc_highlightedImage = @"wcf_navbar_btn_search".cc_image.cc_imageWithAlpha(0.7).cc_templateImage;
    }
    else if (cc_rightButtonType == CY_NavBarRightButtonTypeSort) {
        self.cc_rightButton.cc_normalImage = @"wcf_navbar_btn_sort".cc_image.cc_templateImage;
        self.cc_rightButton.cc_highlightedImage = @"wcf_navbar_btn_sort".cc_image.cc_imageWithAlpha(0.7).cc_templateImage;
    }
    else if (cc_rightButtonType == CY_NavBarRightButtonTypeMore) {
        self.cc_rightButton.cc_normalImage = @"wcf_navbar_btn_more".cc_image.cc_templateImage;
        self.cc_rightButton.cc_highlightedImage = @"wcf_navbar_btn_more".cc_image.cc_imageWithAlpha(0.7).cc_templateImage;
    }
    else {
        self.cc_rightButton.hidden = YES;
        self.cc_rightButton.userInteractionEnabled = NO;
    }
    
    switch (self.cc_type) {
        case CY_NavBarTypeClear:
        case CY_NavBarTypeLight:
            {
                self.cc_rightButton.tintColor = @"#999999".cc_color;
                self.cc_rightButton.cc_normalTitleColor = @"#999999".cc_color;
                self.cc_rightButton.cc_highlightedTitleColor = @"#999999".cc_color.cc_colorWithAlpha(0.7);
            }
            break;
            
        case CY_NavBarTypeDark:
            {
                self.cc_rightButton.tintColor = self.tintColor;
                self.cc_rightButton.cc_normalTitleColor = self.tintColor;
                self.cc_rightButton.cc_highlightedTitleColor = self.tintColor.cc_colorWithAlpha(0.7);
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getter

- (NSString *)cc_title {
    return [self.cc_titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)cc_leftButtonTitle {
    return [self.cc_leftButton.cc_normalTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)cc_leftSecondButtonTitle {
    return [self.cc_leftSecondButton.cc_normalTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)cc_rightButtonTitle {
    return [self.cc_rightButton.cc_normalTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - Setter

- (void)setCc_title:(NSString *)cc_title {
    self.cc_titleLabel.text = cc_title;
}

- (void)setCc_leftButtonTitle:(NSString *)cc_leftButtonTitle {
    [self cc_clearLeftButton];
    
    cc_leftButtonTitle = [self constructTitle:cc_leftButtonTitle];
    self.cc_leftButton.hidden = NO;
    self.cc_leftButton.userInteractionEnabled = YES;
    self.cc_leftButton.cc_font = @"15px".cc_font;
    self.cc_leftButton.cc_normalTitleColor = self.tintColor;
    self.cc_leftButton.cc_highlightedTitleColor = self.tintColor.cc_colorWithAlpha(0.7);
    self.cc_leftButton.cc_normalTitle = cc_leftButtonTitle;
}

- (void)setCc_leftSecondButtonTitle:(NSString *)cc_leftSecondButtonTitle {
    [self cc_clearLeftSecondButton];
    
    self.cc_leftSecondButton.hidden = NO;
    self.cc_leftSecondButton.userInteractionEnabled = YES;
    self.cc_leftSecondButton.cc_font = @"15px".cc_font;
    self.cc_leftSecondButton.cc_normalTitleColor = self.tintColor;
    self.cc_leftSecondButton.cc_highlightedTitleColor = self.tintColor.cc_colorWithAlpha(0.7);
    self.cc_leftSecondButton.cc_normalTitle = cc_leftSecondButtonTitle;
}

- (void)setCc_rightButtonTitle:(NSString *)cc_rightButtonTitle {
    [self cc_clearRightButton];
    cc_rightButtonTitle = [self constructTitle:cc_rightButtonTitle];
    
    self.cc_rightButton.hidden = NO;
    self.cc_rightButton.userInteractionEnabled = YES;
    self.cc_rightButton.cc_font = @"15px".cc_font;
    self.cc_rightButton.cc_normalTitle = cc_rightButtonTitle;
    self.cc_rightButton.cc_normalTitleColor = self.tintColor;
    self.cc_rightButton.cc_highlightedTitleColor = self.tintColor.cc_colorWithAlpha(0.7);
    
    switch (self.cc_type) {
        case CY_NavBarTypeClear:
        case CY_NavBarTypeLight:
            {
                self.cc_rightButton.cc_normalTitleColor = @"#999999".cc_color;
                self.cc_rightButton.cc_highlightedTitleColor = @"#999999".cc_color.cc_colorWithAlpha(0.7);
            }
            break;
            
        case CY_NavBarTypeDark:
            {
                self.cc_rightButton.cc_normalTitleColor = self.tintColor;
                self.cc_rightButton.cc_highlightedTitleColor = self.tintColor.cc_colorWithAlpha(0.7);
            }
            break;
            
        default:
            break;
    }
}

- (NSString *)constructTitle:(NSString *)title {
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [NSString stringWithFormat:@"  %@  ", title];
}

#pragma mark - Self Getter & Setter

- (void)cc_clearBackground {
    self.cc_backgroundImgView.backgroundColor = UIColor.clearColor;
    self.cc_backgroundImgView.image = nil;
}

- (UIColor *)cc_backgroundColor {
    return self.cc_backgroundImgView.backgroundColor;
}

- (void)setCc_backgroundColor:(UIColor *)cc_backgroundColor {
    self.cc_backgroundImgView.backgroundColor = cc_backgroundColor;
}

- (UIImage *)cc_backgroundImage {
    return self.cc_backgroundImgView.image;
}

- (void)setCc_backgroundImage:(UIImage *)cc_backgroundImage {
    self.cc_backgroundImgView.image = cc_backgroundImage;
}

#pragma mark - Left Button Setup

- (void)cc_clearLeftButton {
    [self.cc_leftButton setTitle:nil forState:UIControlStateNormal];
    [self.cc_leftButton setTitleColor:nil forState:UIControlStateNormal];
    [self.cc_leftButton setImage:nil forState:UIControlStateNormal];
    [self.cc_leftButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.cc_leftButton.hidden = YES;
}

- (void)cc_clearLeftSecondButton {
    [self.cc_leftSecondButton setTitle:nil forState:UIControlStateNormal];
    [self.cc_leftSecondButton setTitleColor:nil forState:UIControlStateNormal];
    [self.cc_leftSecondButton setImage:nil forState:UIControlStateNormal];
    [self.cc_leftSecondButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.cc_leftSecondButton.hidden = YES;
}

- (void)cc_clearRightButton {
    [self.cc_rightButton setTitle:nil forState:UIControlStateNormal];
    [self.cc_rightButton setTitleColor:nil forState:UIControlStateNormal];
    [self.cc_rightButton setImage:nil forState:UIControlStateNormal];
    [self.cc_rightButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.cc_rightButton.hidden = YES;
}

#pragma mark - 按钮事件

- (void)didClickCC_LeftButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_navBarLeftButtonClicked:)]) {
        [self.delegate cc_navBarLeftButtonClicked:sender];
    }
}

- (void)didClickCC_LeftSecondButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_navBarLeftSecondButtonClicked:)]) {
        [self.delegate cc_navBarLeftSecondButtonClicked:sender];
    }
}

- (void)didClickCC_RightButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_navBarRightButtonClicked:)]) {
        [self.delegate cc_navBarRightButtonClicked:sender];
    }
}

@end
