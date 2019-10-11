//
//  CY_NavBar.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseView.h"
#import "CY_NavBarStyle.h"
#import "CY_BaseLabel.h"

@protocol CY_NavBarDelegate <NSObject>


/**
 导航栏左侧按钮点击事件

 @param sender 事件响应者
 */
- (void)cc_navBarLeftButtonClicked:(id)sender;


/**
 导航栏左侧第二个按钮点击事件

 @param sender 事件响应者
 */
- (void)cc_navBarLeftSecondButtonClicked:(id)sender;


/**
 导航栏右侧按钮点击事件

 @param sender 事件响应者
 */
- (void)cc_navBarRightButtonClicked:(id)sender;

@end

@interface CY_NavBar : CY_BaseView

@property (nonatomic, assign) CY_NavBarType cc_type;
@property (nonatomic, assign) CY_NavBarLeftButtonType cc_leftButtonType;
@property (nonatomic, assign) CY_NavBarRightButtonType cc_rightButtonType;

#pragma mark - 文本
@property (nonatomic, strong) NSString *cc_title;
@property (nonatomic, strong) NSString *cc_leftButtonTitle;
@property (nonatomic, strong) NSString *cc_leftSecondButtonTitle;
@property (nonatomic, strong) NSString *cc_rightButtonTitle;

@property (nonatomic, weak) UIImageView *cc_backgroundImgView;
@property (nonatomic, weak) UIView *cc_statusBarView;

// 默认Navigation
@property (nonatomic, assign) id<CY_NavBarDelegate> delegate;
@property (nonatomic, weak) CY_BaseView *cc_navigationView;
@property (nonatomic, strong) CY_BaseLabel *cc_titleLabel;
@property (nonatomic, strong) CY_BaseView *cc_separator;


#pragma mark - 两边按钮
- (void)cc_clearLeftButton;
- (void)cc_clearLeftSecondButton;
- (void)cc_clearRightButton;
@property (nonatomic, strong) UIButton *cc_leftButton;
@property (nonatomic, strong) UIButton *cc_leftSecondButton;
@property (nonatomic, strong) UIButton *cc_rightButton;


#pragma mark - Self Properties
- (void)cc_clearBackground;
@property (nonatomic, strong) UIColor *cc_backgroundColor;
@property (nonatomic, strong) UIImage *cc_backgroundImage;


@end
