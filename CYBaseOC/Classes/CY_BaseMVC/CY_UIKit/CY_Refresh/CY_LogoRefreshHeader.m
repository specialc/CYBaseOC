//
//  CY_LogoRefreshHeader.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/8.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_LogoRefreshHeader.h"

#define LogoRefreshIdleText @"下拉"
#define LogoRefreshPullingText @"放开"
#define LogoRefreshRefreshingText @"加载数据中"

@interface CY_LogoRefreshHeader ()
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UIImageView *arrowView;
@property (nonatomic, weak) UIImageView *logoAImageView;
@property (nonatomic, weak) UIImageView *logoBImageView;
@property (nonatomic, weak) UIImageView *logoCImageView;
@property (nonatomic, weak) UIImageView *statusImageView;
@property (nonatomic, weak) UIActivityIndicatorView *loadingView;
@property (nonatomic, weak) UIView *backgroundView;
@end

@implementation CY_LogoRefreshHeader

#pragma mark - 重写方法
#pragma mark - 在这里做一些初始化配置（比如添加子控件）

- (void)prepare {
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 55;
    
    {
        UIView *view = [[UIView alloc] init];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:view];
        self.backgroundView = view;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor cc_colorWithRGB:0x888888];
        label.font = MJRefreshLabelFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = YES;
        [self addSubview:label];
        self.statusLabel = label;
    }
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = @"home-refresh-view-label1".cc_image;
        [self addSubview:imageView];
        self.statusImageView = imageView;
    }
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = @"home-refresh-view-licon1".cc_image;
        [self addSubview:imageView];
        self.logoAImageView = imageView;
    }
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = @"home-refresh-view-licon2".cc_image;
        [self addSubview:imageView];
        self.logoBImageView = imageView;
    }
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = @"home-refresh-view-licon3".cc_image;
        [self addSubview:imageView];
        self.logoCImageView = imageView;
    }
    // 箭头
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[NSBundle mj_arrowImage]];
        imageView.tintColor = self.statusLabel.textColor;
        [self addSubview:imageView];
        self.arrowView = imageView;
    }
    // loading
    {
        UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:loading];
        self.loadingView = loading;
    }
}

#pragma mark - 在这里设置子控件的位置和尺寸

- (void)placeSubviews {
    [super placeSubviews];
    
    CGFloat realCenterX = self.boundsCenter.x;
    CGFloat realCenterY = self.boundsCenter.y + 5;
    
    // 状态文字 & 图标
    self.statusLabel.frame = self.bounds;
    self.statusImageView.bounds = CGRectMake(0, 0, 289./2.5, 51./2.5);
    self.statusImageView.center = CGPointMake(realCenterX, realCenterY);
    
    // 三个图标
    self.logoAImageView.bounds = CGRectMake(0, 0, 70, 70);
    self.logoAImageView.center = CGPointMake(self.mj_w / 3 * 0.5, -self.logoAImageView.mj_h * 0.5);
    
    self.logoBImageView.bounds = CGRectMake(0, 0, 70, 70);
    self.logoBImageView.center = CGPointMake(realCenterX, -self.logoBImageView.mj_h * 0.5);
    
    self.logoCImageView.bounds = CGRectMake(0, 0, 70, 70);
    self.logoCImageView.center = CGPointMake(self.mj_w - (self.mj_w / 3 * 0.5), -self.logoCImageView.mj_h * 0.5);
    
    // 箭头 & 菊花
    CGFloat offset = 30;
    CGFloat statusLabelWidth = [self stringWidth:self.statusLabel];
    CGFloat statusImageWidth = self.statusImageView.mj_w;
    CGFloat textWidth = MAX(statusLabelWidth, statusImageWidth);
    
    CGFloat arrowCenterX = realCenterX;
    arrowCenterX -= textWidth / 2 + offset;
    CGFloat arrowCenterY = realCenterY;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // self.arrowView.mj_size = self.arrowView.image.size;
    self.arrowView.size = CGSizeMake(30./2.5, 80./2.5);
    self.arrowView.center = arrowCenter;
    self.loadingView.center = arrowCenter;
}

#pragma mark - 监听ScrollView的contentOffset改变

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    self.backgroundView.mj_w = self.scrollView.mj_w;
    self.backgroundView.mj_x = 0;
    self.backgroundView.mj_h = -self.scrollView.mj_offsetY + 44;
    self.backgroundView.mj_y = self.scrollView.mj_offsetY + self.mj_h - 44;
}

#pragma mark - 监听ScrollView的contentSize改变

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark - 监听ScrollView的拖拽状态改变

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

#pragma mark - 监听控件的刷新状态

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    
    switch (state) {
        case MJRefreshStateIdle:
            {
                self.statusLabel.text = LogoRefreshIdleText;
                if (oldState == MJRefreshStateRefreshing) {
                    self.arrowView.transform = CGAffineTransformIdentity;
                    [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                        self.loadingView.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        if (self.state != MJRefreshStateIdle) {
                            return ;
                        }
                        self.loadingView.alpha = 1.0;
                        [self.loadingView stopAnimating];
                        self.arrowView.hidden = NO;
                    }];
                }
                else {
                    [self.loadingView stopAnimating];
                    self.arrowView.hidden = NO;
                    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                        self.arrowView.transform = CGAffineTransformIdentity;
                    }];
                }
            }
            break;
            
        case MJRefreshStatePulling:
        {
            self.statusLabel.text = LogoRefreshPullingText;
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
        }
            break;
            
        case MJRefreshStateRefreshing:
        {
            self.statusLabel.text = LogoRefreshRefreshingText;
            [self.loadingView startAnimating];
            self.loadingView.alpha = 1.0;
            self.arrowView.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 监听拖拽比例（控件被拖出来的比例）

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
}

#pragma mark - Methods

- (CGFloat)stringWidth:(UILabel *)label {
    CGFloat stringWidth = 0;
    CGSize size = CGSizeMake(self.mj_w, self.mj_h);
    if (label.text.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringWidth = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.width;
        
#else
        stringWidth = [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping].width;
        
#endif
    }
    return stringWidth;
}

@end
