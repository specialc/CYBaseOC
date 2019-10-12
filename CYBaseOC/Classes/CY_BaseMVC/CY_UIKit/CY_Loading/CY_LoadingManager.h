//
//  CY_LoadingManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/29.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_LoadingViewProtocol.h"
#import "CY_Lib.h"

typedef NS_ENUM(NSInteger, CY_LoadingType) {
    CY_LoadingType_WCF,
    CY_LoadingType_Pythia,
};

@protocol CY_LoadingDelegate <NSObject>

- (void)cc_loadingAction;

- (void)cc_loadingGoBackClicked;

@optional
- (void)cc_loadingNeedLayout:(UIView<CY_LoadingViewProtocol> *)loadingView;

@end

@interface CY_LoadingManager : NSObject

@property (nonatomic, weak) id<CY_LoadingDelegate> delegate;

//- (instancetype)cc_initWithHandleView:(UIView *)view delegate:(id<CY_LoadingDelegate>)delegate;
- (instancetype)initWithHandleView:(UIView *)view delegate:(id<CY_LoadingDelegate>)delegate;

// Default is CY_LoadingType_WCF
@property (nonatomic, assign) CY_LoadingType type;

// 返回按钮是否可见
@property (nonatomic, assign) BOOL goBackHidden;


// 开始动画刷新
- (void)cc_beginLoading;

// 停止动画刷新
- (void)cc_endLoading;

// 是否刷新中
- (BOOL)cc_isLoading;

// 加载失败 - 接口问题
- (void)cc_loadingFailureNormal:(NSString *)error;

// 加载失败 - 网络问题
- (void)cc_loadingFailureNetwork;

@end

