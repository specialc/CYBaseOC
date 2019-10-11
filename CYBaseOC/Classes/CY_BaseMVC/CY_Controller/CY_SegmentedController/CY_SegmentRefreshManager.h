//
//  CY_SegmentRefreshManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/8.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CY_SegmentRefreshDelegate <NSObject>

- (void)cc_refreshHeaderAction:(CY_RefreshManager *)refresh atIndex:(NSUInteger)index;
- (void)cc_refreshFooterAction:(CY_RefreshManager *)refresh atIndex:(NSUInteger)index;

@end

@interface CY_SegmentRefreshManager : NSObject

@property (nonatomic, weak) id<CY_SegmentRefreshDelegate> delegate;
@property (nonatomic, strong) NSArray<CY_RefreshManager *> *refreshManagers;
@property (nonatomic, strong) NSArray<UIScrollView *> *scrollViews;

- (void)setScrollViews:(NSArray<UIScrollView *> *)scrollViews andInstall:(CY_RefreshHeaderType)type;



/**
 安装下拉刷新：Normal
 */
- (void)installRefreshHeader;
- (void)installRefreshHeader:(CY_RefreshHeaderType)type;


/**
 开始下拉刷新

 @param index 刷新第几个界面
 */
- (void)beginHeaderRefreshingAtIndex:(NSUInteger)index;

/**
 结束下拉刷新
 
 @param index 刷新第几个界面
 */
- (void)endHeaderRefreshingAtIndex:(NSUInteger)index;

/**
 是否正在下拉刷新
 
 @param index 刷新第几个界面
 */
- (BOOL)isHeaderRefreshingAtIndex:(NSUInteger)index;


#pragma mark - Refresh Footer


/**
 安装上拉刷新

 @param index 第几个界面
 */
- (void)installRefreshFooterAtIndex:(NSUInteger)index;

/**
 卸载上拉刷新
 
 @param index 第几个界面
 */
- (void)uninstallRefreshFooterAtIndex:(NSUInteger)index;

/**
 开始上拉刷新
 
 @param index 第几个界面
 */
- (void)beginFooterRefreshingAtIndex:(NSUInteger)index;

/**
 结束上拉刷新
 
 @param index 第几个界面
 */
- (void)endFooterRefreshingAtIndex:(NSUInteger)index;

/**
 是否正在上拉刷新
 
 @param index 第几个界面
 */
- (BOOL)isFooterRefreshingAtIndex:(NSUInteger)index;


/**
 设置为已经没有更多数据了

 @param info 显示的文案
 @param index 第几个界面
 */
- (void)setRefreshFooterNoMoreData:(NSString *)info atIndex:(NSUInteger)index;


@end

