//
//  CY_PagedFlowView.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/15.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 页面滚动的方向分为横向和纵向
 
 Version 1.0:
 目的:实现类似于选择电影票的效果,并且实现无限/自动轮播
 
 特点:1.无限轮播;2.自动轮播;3.电影票样式的层次感;4.非当前显示view具有缩放和透明的特效
 
 问题:考虑到轮播图的数量不会太大,暂时未做重用处理;对设备性能影响不明显,后期版本会考虑添加重用标识模仿tableview的重用
 */

#import <UIKit/UIKit.h>
#import "CY_PagedFlowViewItem.h"

@class CY_PagedFlowView;

typedef NS_ENUM(NSUInteger, CY_PagedFlowViewOrientation) {
    CY_PagedFlowViewOrientation_Horizontal = 0,
    CY_PagedFlowViewOrientation_Vertical,
};

#pragma mark - CY_PagedFlowViewDelegate
@protocol CY_PagedFlowViewDelegate <NSObject>

// Item Size
- (CGSize)sizeForItemsInFlowView:(CY_PagedFlowView *)flowView;

@optional
// 成为焦点, 在滚动过程中，Cell可能会不断的成为焦点，然后失去焦点，而最终的焦点将会停留在targetIndex
- (void)flowView:(CY_PagedFlowView *)flowView didBecomeFocusCellAtIndex:(NSUInteger)index targetIndex:(NSUInteger)targetIndex;
// 失去焦点
- (void)flowView:(CY_PagedFlowView *)flowView didResignFocusCellAtIndex:(NSUInteger)index;
// 点击Cell
- (void)flowView:(CY_PagedFlowView *)flowView didSelectCell:(__kindof CY_PagedFlowViewItem *)cell atIndex:(NSUInteger)index;

@end

#pragma mark - CY_PagedFlowViewDataSource
@protocol CY_PagedFlowViewDataSource <NSObject>

// Item的个数
- (NSInteger)numberOfItemsInFlowView:(CY_PagedFlowView *)flowView;
// Cell
- (UIView *)flowView:(CY_PagedFlowView *)flowView cellForPageAtIndex:(NSUInteger)index;

@end


@interface CY_PagedFlowView : UIView <UIScrollViewDelegate>

// 默认为横向
@property (nonatomic, assign) CY_PagedFlowViewOrientation orientation;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL needsReload;
// 一页的尺寸
@property (nonatomic, assign) CGSize pageSize;
// 总页数
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, assign) NSRange visibleRange;
// 如果以后需要支持reuseIdentifier，这边就得使用字典类型了
@property (nonatomic, strong) NSMutableArray *reusableCells;
// 数据源
@property (nonatomic, weak) id<CY_PagedFlowViewDataSource> dataSource;
// 代理
@property (nonatomic, weak) id<CY_PagedFlowViewDelegate> delegate;

// 指示器
@property (nonatomic, retain) UIPageControl *pageControl;
// 非当前页的透明比例
@property (nonatomic, assign) CGFloat minimumPageAlpha;
// 非当前页的缩放比例
@property (nonatomic, assign) CGFloat minimumPageScale;
// 是否开启循环播放
@property (nonatomic, assign) BOOL isLooping;
// 是否开启自动滚动，默认为开启
@property (nonatomic, assign) BOOL isOpenAutoScroll;
// 当前是第几页
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;
// 定时器
@property (nonatomic, weak) NSTimer *timer;
// 自动切换视图的时间，默认是5.0s
@property (nonatomic, assign) NSTimeInterval autoTime;
// 原始页数
@property (nonatomic, assign) NSInteger originPageCount;
// 焦点Index
@property (nonatomic, assign, readonly) NSInteger focusCellIndex;
// 焦点Cell
@property (nonatomic, assign, readonly) __kindof CY_PagedFlowViewItem *focusCell;


// 刷新视图
- (void)reloadData;
// 获取可重复使用的Cell
- (__kindof CY_PagedFlowViewItem *)dequeueReusableCell;
// 通过Index获取Cell
- (__kindof CY_PagedFlowViewItem *)cellForItemAtIndex:(NSInteger)index;
// 滚动到指定的页面
- (void)scrollToPage:(NSUInteger)pageNumber;
// 关闭定时器，关闭自动滚动
- (void)stopTimer;


@end
