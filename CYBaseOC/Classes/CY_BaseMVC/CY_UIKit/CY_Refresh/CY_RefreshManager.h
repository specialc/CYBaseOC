//
//  CY_RefreshManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/8.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

typedef NS_ENUM(NSUInteger, CY_RefreshHeaderType) {
    CY_RefreshHeaderType_Normal,
    CY_RefreshHeaderType_Logo,
    CY_RefreshHeaderType_Red,
    CY_RefreshHeaderType_Gold,
};

@class CY_RefreshManager;
@protocol CY_RefreshDelegate <NSObject>

// 下拉刷新调用
- (void)cc_refreshHeaderAction:(CY_RefreshManager *)refresh;

@optional
// 上拉刷新调用
- (void)cc_refreshFooterAction:(CY_RefreshManager *)refresh;

@end

@interface CY_RefreshManager : NSObject

@property (nonatomic, weak) id<CY_RefreshDelegate> delegate;

+ (instancetype)cc_refreshManagerWithHandlerScrollView:(UIScrollView *)scrollView delegate:(id)delegate;

- (instancetype)initWithHandlerScrollView:(UIScrollView *)scrollView delegate:(id)delegate;

#pragma mark - Refresh Header


/**
 安装下拉刷新：Normal
 */
- (void)cc_installRefreshHeader;
- (void)cc_installRefreshHeader:(CY_RefreshHeaderType)type;


/**
 开始下拉刷新
 */
- (void)cc_beginHeaderRefreshing;


/**
 结束下拉刷新
 */
- (void)cc_endHeaderRefreshing;


/**
 是否正在下拉刷新

 @return 是否正在下拉刷新
 */
- (BOOL)cc_isHeaderRefreshing;

#pragma mark - Refresh Footer


/**
 安装上拉刷新
 */
- (void)cc_installRefreshFooter;

- (void)cc_uninstallRefreshFooter;


/**
 开始上拉刷新
 */
- (void)cc_beginFooterRefreshing;


/**
 结束上拉刷新
 */
- (void)cc_endFooterRefreshing;


/**
 是否正在上拉刷新

 @return 是否正在上拉刷新
 */
- (BOOL)cc_isFooterRefreshing;



/**
 设置为已经没有更多数据了

 @param info 显示的文案
 */
- (void)cc_setRefreshFooterNoMoreData:(NSString *)info;


- (MJRefreshHeader *)cc_header;
- (MJRefreshFooter *)cc_footer;


// 刷新控件状态
- (void)cc_refreshFooterStatusForIsEnd:(BOOL)isEnd isFirstPage:(BOOL)isFirstPage;

@end


