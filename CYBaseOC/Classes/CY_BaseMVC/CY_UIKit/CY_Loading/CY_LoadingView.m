//
//  CY_LoadingView.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/29.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_LoadingView.h"

@interface CY_LoadingView ()

@property (nonatomic, weak) UIButton *cc_goBackButton;
@property (nonatomic, weak) UIActivityIndicatorView *cc_anmView;
@property (nonatomic, weak) UILabel *cc_loadingTitle;
@property (nonatomic, weak) UIControl *cc_failureView;
@property (nonatomic, weak) UIImageView *cc_failureImageView;
@property (nonatomic, weak) UILabel *cc_failureLabel;

@end

@implementation CY_LoadingView

- (void)cc_loadViews {
    [super cc_loadViews];
    
    self.backgroundColor = @"#FFFFFF".cc_color;
    // 加载成功
    {
        NSBundle *bundle = [NSBundle bundleForClass:[CY_NavBar class]];
        NSString *path = [bundle pathForResource:@"CY_NavBar" ofType:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithPath:path];
        UIImage *back_image = [UIImage imageNamed:@"star_navbar_back" inBundle:imageBundle compatibleWithTraitCollection:nil];
        UIButton *button = [[UIButton alloc] init];
        button.cc_normalImage = back_image;
        button.tintColor = @"#999999".cc_color;
        [self addSubview:button];
        self.cc_goBackButton = button;
    }
    {
        UIActivityIndicatorView *anmView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:anmView];
        self.cc_anmView = anmView;
        [self.cc_anmView startAnimating];
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = @"#999999".cc_color;
        label.font = @"15px".cc_font;
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        [self addSubview:label];
        self.cc_loadingTitle = label;
    }
    
    // 加载失败
    {
        UIControl *control = [[UIControl alloc] init];
        control.backgroundColor = UIColor.whiteColor;
        control.hidden = YES;
        [self addSubview:control];
        self.cc_failureView = control;
    }
    {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.cc_failureView addSubview:imgView];
        self.cc_failureImageView = imgView;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        self.cc_failureLabel.font = @"15px".cc_font;
        self.cc_failureLabel.textColor = rgba(165, 165, 165, 1);
        self.cc_failureLabel.text = @"亲，没网啦，请检查你的网络设置\n轻触屏幕刷新";
        [self.cc_failureView addSubview:label];
        self.cc_failureLabel = label;
    }
    
    [self bringSubviewToFront:self.cc_goBackButton];
}

- (void)cc_layoutConstraints {
    
    [self.cc_anmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(-20);
    }];
    
    [self.cc_failureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [self.cc_failureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(-100);
    }];
    
    [self.cc_failureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.cc_failureImageView.mas_bottom).offset(30);
    }];
    
    [self.cc_goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(2);
        make.top.equalTo(StatusBarHeight);
        make.size.equalTo(44);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - 实现接口

- (void)cc_setLoading:(NSString *)title {
    self.cc_anmView.hidden = NO;
    self.cc_loadingTitle.hidden = NO;
    self.cc_loadingTitle.text = title;
    self.cc_failureView.hidden = YES;
}

- (void)cc_setLoadingFailureNormal:(NSString *)title {
    self.cc_anmView.hidden = YES;
    self.cc_loadingTitle.hidden = YES;
    self.cc_failureView.hidden = NO;
    self.cc_failureImageView.image = @"pp_common_net_error".cc_image;
    self.cc_failureLabel.text = title;
}

- (void)cc_setLoadingFailureNetwork:(NSString *)title {
    self.cc_anmView.hidden = YES;
    self.cc_loadingTitle.hidden = YES;
    self.cc_failureView.hidden = NO;
    self.cc_failureImageView.image = @"pp_common_net_error".cc_image;
    self.cc_failureLabel.text = title;
}

- (void)setGoBackHidden:(BOOL)hidden {
    self.cc_goBackButton.hidden = hidden;
}

- (BOOL)goBackHidden {
    return self.cc_goBackButton.hidden;
}

#pragma mark - 点击事件

- (void)cc_addFailureTouchHandlerWithTarget:(id)target action:(SEL)action {
    [self.cc_failureView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)cc_addGoBackButtonHandlerWithTarget:(id)target action:(SEL)action {
    [self.cc_goBackButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
