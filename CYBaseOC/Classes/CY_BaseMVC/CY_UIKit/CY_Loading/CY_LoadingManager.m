//
//  CY_LoadingManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/29.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_LoadingManager.h"
#import "CY_Dispatch.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, CC_LoadingStatus) {
    CC_LoadingStatus_Loading, // 加载中
    CC_LoadingStatus_Failure, // 加载失败
    CC_LoadingStatus_Idle,    // 空闲
};

@interface CY_LoadingManager ()

@property (nonatomic, weak, readonly) UIView *outsideView;
@property (nonatomic, weak) UIView<CY_LoadingViewProtocol> *loadingView;
@property (nonatomic, assign) CC_LoadingStatus status;

@end

@implementation CY_LoadingManager

//- (instancetype)cc_initWithHandleView:(UIView *)view delegate:(id<CY_LoadingDelegate>)delegate {
//    self = [super init];
//    if (self) {
//        _outsideView = view;
//        _delegate = delegate;
//    }
//    return self;
//}

- (instancetype)initWithHandleView:(UIView *)view delegate:(id<CY_LoadingDelegate>)delegate {
    self = [super init];
    if (self) {
        _outsideView = view;
        _delegate = delegate;
    }
    return self;
}

#pragma mark - 安装 & 卸载

- (void)installLoading {
    if (self.loadingView) {
        return;
    }
    
    switch (self.type) {
        case CY_LoadingType_WCF:
        {
            CY_LoadingView *loadingView = [[CY_LoadingView alloc] init];
            [self.outsideView addSubview:loadingView];
            self.loadingView = loadingView;
        }
            break;
            
        default:
            break;
    }
    
    self.loadingView.goBackHidden = self.goBackHidden;
    [self.loadingView cc_addFailureTouchHandlerWithTarget:self action:@selector(handleFailureTouch:)];
    [self.loadingView cc_addGoBackButtonHandlerWithTarget:self action:@selector(handleGoBack:)];
    
    // 是否交给外面布局
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_loadingNeedLayout:)]) {
        [self.delegate cc_loadingNeedLayout:self.loadingView];
    }
    else {
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.outsideView);
        }];
    }
    
    //    self.loadingView.hidden = true;
    //    dispatch_delay(1.0, ^{
    //        self.loadingView.hidden = false;
    //    });
}

- (void)uninstallLoading {
    [UIView animateWithDuration:0.10 animations:^{
        self.loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }];
}

#pragma mark - 开始 & 结束

- (void)cc_beginLoading {
    // 延迟1秒显示动画
    self.status = CC_LoadingStatus_Loading;
    [self installLoading];
    [self.loadingView cc_setLoading:@"加载中，请稍后..."];
    [self refreshLoading];
}

- (void)cc_endLoading {
    [self uninstallLoading];
    self.status = CC_LoadingStatus_Idle;
}

- (BOOL)cc_isLoading {
    return self.status == CC_LoadingStatus_Loading;
}

#pragma mark - Methods

- (void)refreshLoading {
    @try {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cc_loadingAction)]) {
            [self.delegate cc_loadingAction];
        }
    } @catch (NSException *exception) {
        NSLog(@"@catch:%@", exception);
    } @finally {
        NSLog(@"@finally");
    }
}

#pragma mark - 错误

- (void)setGoBackHidden:(BOOL)goBackHidden {
    _goBackHidden = goBackHidden;
    [self.loadingView setGoBackHidden:goBackHidden];
}

- (void)cc_loadingFailureNormal:(NSString *)error {
    self.loadingView.hidden = NO;
    self.status = CC_LoadingStatus_Failure;
    [self.loadingView cc_setLoadingFailureNormal:[NSString cc_isNullOrEmpty:error] ? @"抱歉，系统错误，请稍后再试" : error];
}

- (void)cc_loadingFailureNetwork {
    self.loadingView.hidden = NO;
    self.status = CC_LoadingStatus_Failure;
    [self.loadingView cc_setLoadingFailureNetwork:@"亲，没网啦，请检查你的网络设置\n轻触屏幕刷新"];
}

#pragma mark - Touches

- (void)handleFailureTouch:(id)sender {
    if (self.status == CC_LoadingStatus_Failure) {
        [self cc_beginLoading];
    }
}

- (void)handleGoBack:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_loadingGoBackClicked)]) {
        [self.delegate cc_loadingGoBackClicked];
    }
}

@end
