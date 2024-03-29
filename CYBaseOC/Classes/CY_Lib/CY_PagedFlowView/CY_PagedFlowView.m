//
//  CY_PagedFlowView.m
//  CYBase
//
//  Created by 张春咏 on 2019/7/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PagedFlowView.h"

@interface CY_PagedFlowView ()
@property (nonatomic, assign, readwrite) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger targerIndex;

/**
 计时器用到的页数
 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation CY_PagedFlowView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark - Methods

- (void)initialize {
    self.clipsToBounds = YES;
    
    self.needsReload = YES;
    self.pageSize = self.bounds.size;
    self.pageCount = 0;
    self.isOpenAutoScroll = YES;
    self.currentPageIndex = 0;
    self.targerIndex = -1;
    
    self.minimumPageAlpha = 1.0;
    self.minimumPageScale = 1.0;
    self.autoTime = 5.0;
    
    self.visibleRange = NSMakeRange(0, 0);
    
    self.reusableCells = [[NSMutableArray alloc] initWithCapacity:0];
    self.cells = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    /*由于UIScrollView在滚动之后会调用自己的layoutSubviews以及父View的layoutSubviews
     这里为了避免scrollview滚动带来自己layoutSubviews的调用,所以给scrollView加了一层父View
     */
    UIView *superViewOfScrollView = [[UIView alloc] initWithFrame:self.bounds];
    [superViewOfScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [superViewOfScrollView setBackgroundColor:[UIColor clearColor]];
    [superViewOfScrollView addSubview:self.scrollView];
    [self addSubview:superViewOfScrollView];
}

- (void)startTimer {
    if (self.originPageCount > 1 && self.isOpenAutoScroll) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoTime target:self selector:@selector(autoNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
}

#pragma mark - Getter

- (NSInteger)focusCellIndex {
    return self.currentPageIndex;
}

- (CY_PagedFlowViewItem *)focusCell {
    return self.cells[self.focusCellIndex];
}

#pragma mark - 自动轮播

- (void)autoNexPage {
    self.page++;
    if (!self.isLooping) {
        if (self.page >= self.pageCount) {
            return;
        }
    }
    
    switch (self.orientation) {
        case CY_PagedFlowViewOrientation_Horizontal:
            {
                [self.scrollView setContentOffset:CGPointMake(self.page * self.pageSize.width, 0) animated:YES];
            }
            break;
            
        case CY_PagedFlowViewOrientation_Vertical:
        {
            [self.scrollView setContentOffset:CGPointMake(0, self.page * self.pageSize.height) animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)queueReusableCell:(UIView *)cell {
    [self.reusableCells addObject:cell];
}

- (void)removeCellAtIndex:(NSInteger)index {
    UIView *cell = [self.cells objectAtIndex:index];
    if ((NSObject *)cell == [NSNull null]) {
        return;
    }
    
    [self queueReusableCell:cell];
    
    if (cell.superview) {
        [cell removeFromSuperview];
    }
    
    [self.cells replaceObjectAtIndex:index withObject:[NSNull null]];
}

- (void)refreshVisibleCellAppearance {
    if (self.minimumPageAlpha == 1.0 && self.minimumPageScale == 1.0) {
        return; // 无需更新
    }
    
    switch (self.orientation) {
        case CY_PagedFlowViewOrientation_Horizontal:
            {
                CGFloat offset = self.scrollView.contentOffset.x;
                for (NSInteger i = self.visibleRange.location; i < self.visibleRange.location + self.visibleRange.length; i++) {
                    CY_PagedFlowViewItem *cell = [self.cells objectAtIndex:i];
                    CGFloat origin = cell.frame.origin.x;
                    CGFloat delta = fabs(origin - offset);
                    CGRect originCellFrame = CGRectMake(self.pageSize.width * i, 0, self.pageSize.width, self.pageSize.height); //如果没有缩小效果的情况下的本该的Frame
                    
                    if (delta < self.pageSize.width) {
                        // cell.coverView.alpha = (delta / _pageSize.width) * (1 - _minimumPageAlpha);
                        CGFloat inset = (self.pageSize.width * (1 - self.minimumPageScale)) * (delta / self.pageSize.width) / 2.0;
                        cell.layer.transform = CATransform3DMakeScale((self.pageSize.width - inset * 2) / self.pageSize.width, (self.pageSize.height - inset * 2) / self.pageSize.height, 1.0);
                        cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                    }
                    else {
                        // cell.coverView.alpha = _minimumPageAlpha;
                        CGFloat inset = self.pageSize.width * (1 - self.minimumPageScale) / 2.0;
                        cell.layer.transform = CATransform3DMakeScale((self.pageSize.width - inset * 2) / self.pageSize.width, (self.pageSize.height - inset * 2) / self.pageSize.height, 1.0);
                        cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                    }
                }
            }
            break;
            
        case CY_PagedFlowViewOrientation_Vertical:
        {
            CGFloat offset = self.scrollView.contentOffset.y;
            for (NSInteger i = self.visibleRange.location; i < self.visibleRange.location + self.visibleRange.length; i++) {
                CY_PagedFlowViewItem *cell = [self.cells objectAtIndex:i];
                CGFloat origin = cell.frame.origin.y;
                CGFloat delta = fabs(origin - offset);
                CGRect originCellFrame = CGRectMake(0, self.pageSize.height * i, self.pageSize.width, self.pageSize.height); //如果没有缩小效果的情况下的本该的Frame
                
                if (delta < self.pageSize.height) {
                    // cell.coverView.alpha = (delta / _pageSize.height) * (1 - _minimumPageAlpha);
                    CGFloat inset = (self.pageSize.height * (1 - self.minimumPageScale)) * (delta / self.pageSize.height) / 2.0;
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                    cell.mainImageView.frame = cell.bounds;
                }
                else {
                    // cell.coverView.alpha = _minimumPageAlpha;
                    CGFloat inset = self.pageSize.height * (1 - self.minimumPageScale) / 2.0;
                    cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
                    cell.mainImageView.frame = cell.bounds;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Setter

- (void)setPageAtIndex:(NSInteger)pageIndex {
    NSParameterAssert(pageIndex >= 0 && pageIndex < [self.cells count]);
    
    UIView *cell = self.cells[pageIndex];
    if ((NSObject *)cell == [NSNull null]) {
        cell = [self.dataSource flowView:self cellForPageAtIndex:pageIndex % self.originPageCount];
        NSAssert(cell != nil, @"datasource must not return nil");
        [self.cells replaceObjectAtIndex:pageIndex withObject:cell];
        
        // 添加点击手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [self addGestureRecognizer:singleTap];
        cell.tag = pageIndex % self.originPageCount;
        
        switch (self.orientation) {
            case CY_PagedFlowViewOrientation_Horizontal:
                {
                    cell.frame = CGRectMake(self.pageSize.width * pageIndex, 0, self.pageSize.width, self.pageSize.height);
                }
                break;
                
            case CY_PagedFlowViewOrientation_Vertical:
            {
                cell.frame = CGRectMake(0, self.pageSize.height * pageIndex, self.pageSize.width, self.pageSize.height);
            }
                break;
                
            default:
                break;
        }
        
        if (!cell.superview) {
            [self.scrollView addSubview:cell];
        }
    }
}

- (void)setPagesAtContentOffset:(CGPoint)offset {
    // 计算_visibleRange
    CGPoint startPoint = CGPointMake(offset.x - self.scrollView.frame.origin.x, offset.y - self.scrollView.frame.origin.y);
    CGPoint endPoint = CGPointMake(offset.x - self.bounds.size.width, startPoint.y + self.bounds.size.height);
    
    switch (self.orientation) {
        case CY_PagedFlowViewOrientation_Horizontal:
            {
                NSInteger startIndex = 0;
                for (int i = 0; i < [self.cells count]; i++) {
                    if (self.pageSize.width * (i + 1) > startPoint.x) {
                        startIndex = i;
                        break;
                    }
                }
                
                NSInteger endIndex = startIndex;
                for (NSInteger i = startIndex; i < [self.cells count]; i++) {
                    // 如果都不超过则取最后一个
                    if ((self.pageSize.width * (i + 1) < endPoint.x && self.pageSize.width * (i + 2) >= endPoint.x) || i + 2 == [self.cells count]) {
                        endIndex = i + 1; // i+2 是以个数，所以其index需要减去1
                        break;
                    }
                }
                
                // 可见页分别向前向后扩展一个，提高效率
                startIndex = MAX(startIndex - 1, 0);
                endIndex = MIN(endIndex + 1, [self.cells count] - 1);
                self.visibleRange = NSMakeRange(startIndex, endIndex - startIndex + 1);
                for (NSInteger i = startIndex; i <= endIndex; i++) {
                    [self setPageAtIndex:i];
                }
                
                for (int i = 0; i < startIndex; i++) {
                    [self removeCellAtIndex:i];
                }
                
                for (NSInteger i = endIndex + 1; i < [self.cells count]; i++) {
                    [self removeCellAtIndex:i];
                }
            }
            break;
            
        case CY_PagedFlowViewOrientation_Vertical:
        {
            NSInteger startIndex = 0;
            for (int i = 0; i < [self.cells count]; i++) {
                if (self.pageSize.height * (i + 1) > startPoint.y) {
                    startIndex = i;
                    break;
                }
            }
            
            NSInteger endIndex = startIndex;
            for (NSInteger i = startIndex; i < [self.cells count]; i++) {
                // 如果都不超过则取最后一个
                if ((self.pageSize.height * (i + 1) < endPoint.y && self.pageSize.height * (i + 2) >= endPoint.y) || i + 2 == [self.cells count]) {
                    endIndex = i + 1; // i+2 是以个数，所以其index需要减去1
                    break;
                }
            }
            
            // 可见页分别向前向后扩展一个，提高效率
            startIndex = MAX(startIndex - 1, 0);
            endIndex = MIN(endIndex + 1, [self.cells count] - 1);
            
            _visibleRange.location = startIndex;
            _visibleRange.length = endIndex - startIndex + 1;
            
            for (NSInteger i = startIndex; i <= endIndex; i++) {
                [self setPageAtIndex:i];
            }
            
            for (NSInteger i = 0; i < startIndex; i++) {
                [self removeCellAtIndex:i];
            }
            
            for (NSInteger i = endIndex + 1; i < [self.cells count]; i++) {
                [self removeCellAtIndex:i];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - CY_PagedFlowView API

- (void)reloadData {
    self.needsReload = YES;
    
    // 移除所有self.scrollView的子控件
    for (UIView *view in self.scrollView.subviews) {
        if ([NSStringFromClass(view.class) isEqualToString:@"CY_PagedFlowViewItem"]) {
            [view removeFromSuperview];
        }
    }
    
    [self stopTimer];
    
    if (self.needsReload) {
        // 如果需要重新加载数据，则需要清空相关数据全部重新加载
        // 重置pageCount
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInFlowView:)]) {
            // 原始页数
            self.originPageCount = [self.dataSource numberOfItemsInFlowView:self];
            
            // 总页数
            if (self.originPageCount > 0) {
                if (self.isLooping) {
                    self.pageCount = [self.dataSource numberOfItemsInFlowView:self] * 3;
                }
                else {
                    self.pageCount = [self.dataSource numberOfItemsInFlowView:self];
                }
            }
            else {
                self.pageCount = 0;
            }
            
            // 如果总页数为0，return
            if (self.pageCount == 0) {
                return;
            }
            
            if (self.pageControl && [self.pageControl respondsToSelector:@selector(setNumberOfPages:)]) {
                [self.pageControl setNumberOfPages:self.originPageCount];
            }
        }
        
        // 重置pageWidth
        if (self.delegate && [self.delegate respondsToSelector:@selector(sizeForItemsInFlowView:)]) {
            self.pageSize = [self.delegate sizeForItemsInFlowView:self];
        }
        
        [self.reusableCells removeAllObjects];
        _visibleRange = NSMakeRange(0, 0);
        
        // 填充cells数组
        [self.cells removeAllObjects];
        for (NSInteger index = 0; index < self.pageCount; index++) {
            [self.cells addObject:[NSNull null]];
        }
        
        // 重置_scrollView的contentSize
        switch (self.orientation) {
                // 横向
            case CY_PagedFlowViewOrientation_Horizontal:
                {
                    self.scrollView.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
                    self.scrollView.contentSize = CGSizeMake(self.pageSize.width * self.pageCount, self.pageSize.height);
                    CGPoint theCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
                    self.scrollView.center = theCenter;
                    
                    if (self.originPageCount > 1) {
                        if (self.isLooping) {
                            // 滚到第二组
                            [self.scrollView setContentOffset:CGPointMake(self.pageSize.width * self.originPageCount, 0) animated:NO];
                            self.page = self.originPageCount;
                        }
                        
                        // 启动自动轮播
                        [self startTimer];
                    }
                }
                break;
                
                // 纵向
            case CY_PagedFlowViewOrientation_Vertical:
            {
                self.scrollView.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
                self.scrollView.contentSize = CGSizeMake(self.pageSize.width, self.pageSize.height * self.pageCount);
                CGPoint theCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
                self.scrollView.center = theCenter;
                
                if (self.originPageCount > 1) {
                    if (self.isLooping) {
                        // 滚到第二组
                        [self.scrollView setContentOffset:CGPointMake(0, self.pageSize.height * self.originPageCount) animated:NO];
                        self.page = self.originPageCount;
                    }
                    
                    // 启动自动轮播
                    [self startTimer];
                }
            }
                break;
                
            default:
                break;
        }
        
        self.needsReload = NO;
    }
    
    [self setPagesAtContentOffset:self.scrollView.contentOffset]; // 根据当前scrollView的offset设置cell
    [self refreshVisibleCellAppearance]; // 更新各个可见Cell的显示外貌
    
    if (self.currentPageIndex >= 0 && self.currentPageIndex < self.originPageCount) {
        // 成为焦点Cell
        if (self.delegate && [self.delegate respondsToSelector:@selector(flowView:didBecomeFocusCellAtIndex:targetIndex:)]) {
            [self.delegate flowView:self didBecomeFocusCellAtIndex:self.currentPageIndex targetIndex:self.currentPageIndex];
        }
    }
}

- (CY_PagedFlowViewItem *)dequeueReusableCell {
    CY_PagedFlowViewItem *cell = [self.reusableCells lastObject];
    if (cell) {
        [self.reusableCells removeLastObject];
    }
    
    return cell;
}

- (void)scrollToPage:(NSUInteger)pageNumber {
    if (self.currentPageIndex == pageNumber) {
        return;
    }
    
    if (pageNumber < self.pageCount) {
        self.targerIndex = pageNumber;
        // 首先停止定时器
        [self stopTimer];
        if (self.isLooping) {
            self.page = pageNumber + self.originPageCount;
        }
        else {
            self.page = pageNumber;
        }
        
        switch (self.orientation) {
            case CY_PagedFlowViewOrientation_Horizontal:
                {
                    if (self.isLooping) {
                        [self.scrollView setContentOffset:CGPointMake(self.pageSize.width * (pageNumber + self.originPageCount), 0) animated:YES];
                    }
                    else {
                        [self.scrollView setContentOffset:CGPointMake(self.pageSize.width * pageNumber, 0) animated:YES];
                    }
                }
                break;
                
            case CY_PagedFlowViewOrientation_Vertical:
            {
                if (self.isLooping) {
                    [self.scrollView setContentOffset:CGPointMake(0, self.pageSize.height * (pageNumber + self.originPageCount)) animated:YES];
                }
                else {
                    [self.scrollView setContentOffset:CGPointMake(0, self.pageSize.height * pageNumber) animated:YES];
                }
            }
                break;
                
            default:
                break;
        }
        
        [self setPagesAtContentOffset:self.scrollView.contentOffset];
        [self refreshVisibleCellAppearance];
        [self startTimer];
    }
}

- (CY_PagedFlowViewItem *)cellForItemAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.originPageCount) {
        return nil;
    }
    if (self.cells[index] == [NSNull null]) {
        return nil;
    }
    return self.cells[index];
}

#pragma mark - hitTest

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        CGPoint newPoint = CGPointZero;
        newPoint.x = point.x - self.scrollView.frame.origin.x + self.scrollView.contentOffset.x;
        newPoint.y = point.y - self.scrollView.frame.origin.y + self.scrollView.contentOffset.y;
        if ([self.scrollView pointInside:newPoint withEvent:event]) {
            return [self.scrollView hitTest:newPoint withEvent:event];
        }
        return self.scrollView;
    }
    return nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.originPageCount == 0) {
        return;
    }
    
    NSInteger pageIndex;
    
    switch (self.orientation) {
        case CY_PagedFlowViewOrientation_Horizontal:
            {
                pageIndex = (int)floor((self.scrollView.contentOffset.x + self.scrollView.frame.size.width * 0.5) / self.pageSize.width) % self.originPageCount;
            }
            break;
            
        case CY_PagedFlowViewOrientation_Vertical:
        {
            pageIndex = (int)floor((self.scrollView.contentOffset.y + self.scrollView.frame.size.height * 0.5) / self.pageSize.height) % self.originPageCount;
        }
            break;
            
        default:
            break;
    }
    
    if (self.originPageCount > 1) {
        if (self.isLooping) {
            switch (self.orientation) {
                case CY_PagedFlowViewOrientation_Horizontal:
                    {
                        if (scrollView.contentOffset.x / self.pageSize.width >= 2 * self.originPageCount) {
                            [scrollView setContentOffset:CGPointMake(self.pageSize.width * self.originPageCount, 0) animated:NO];
                            self.page = self.originPageCount;
                        }
                        
                        if (scrollView.contentOffset.x / self.pageSize.width <= self.originPageCount - 1) {
                            [scrollView setContentOffset:CGPointMake((2 * self.originPageCount - 1) * self.pageSize.width, 0) animated:NO];
                            self.page = 2 * self.originPageCount;
                        }
                    }
                    break;
                    
                case CY_PagedFlowViewOrientation_Vertical:
                {
                    if (scrollView.contentOffset.y / self.pageSize.height >= 2 * self.originPageCount) {
                        [scrollView setContentOffset:CGPointMake(0, self.pageSize.height * self.originPageCount) animated:NO];
                        self.page = self.originPageCount;
                    }
                    
                    if (scrollView.contentOffset.y / self.pageSize.height <= self.originPageCount - 1) {
                        [scrollView setContentOffset:CGPointMake(0, (2 * self.originPageCount - 1) * self.pageSize.height) animated:NO];
                        self.page = 2 * self.originPageCount;
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    else {
        pageIndex = 0;
    }
    
    [self setPagesAtContentOffset:scrollView.contentOffset];
    [self refreshVisibleCellAppearance];
    
    if (self.pageControl && [self.pageControl respondsToSelector:@selector(setCurrentPage:)]) {
        [self.pageControl setCurrentPage:pageIndex];
    }
    
    if (pageIndex >= 0 && pageIndex < self.originPageCount && self.currentPageIndex != pageIndex) {
        // 成为焦点Cell
        if (self.delegate && [self.delegate respondsToSelector:@selector(flowView:didBecomeFocusCellAtIndex:targetIndex:)]) {
            [self.delegate flowView:self didBecomeFocusCellAtIndex:pageIndex targetIndex:self.targerIndex < 0 ? pageIndex : self.targerIndex];
        }
        
        // 失去焦点Cell
        if (self.delegate && [self.delegate respondsToSelector:@selector(flowView:didResignFocusCellAtIndex:)]) {
            [self.delegate flowView:self didResignFocusCellAtIndex:self.currentPageIndex];
        }
        
        self.currentPageIndex = pageIndex;
    }
}

// 将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

// 将要结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.originPageCount > 1 && self.isOpenAutoScroll) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoTime target:self selector:@selector(autoNexPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        switch (self.orientation) {
            case CY_PagedFlowViewOrientation_Horizontal:
                {
                    if (self.page == floor(self.scrollView.contentOffset.x / self.pageSize.width)) {
                        self.page = floor(self.scrollView.contentOffset.x / self.pageSize.width) + 1;
                    }
                    else {
                        self.page = floor(self.scrollView.contentOffset.x / self.pageSize.width);
                    }
                }
                break;
                
            case CY_PagedFlowViewOrientation_Vertical:
            {
                if (self.page == floor(self.scrollView.contentOffset.y / self.pageSize.height)) {
                    self.page = floor(self.scrollView.contentOffset.y / self.pageSize.height) + 1;
                }
                else {
                    self.page = floor(self.scrollView.contentOffset.y / self.pageSize.height);
                }
            }
                break;
                
            default:
                break;
        }
    }
}

// 点击了Cell
- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(flowView:didSelectCell:atIndex:)]) {
        [self.delegate flowView:self didSelectCell:(CY_PagedFlowViewItem *)gesture.view atIndex:gesture.view.tag];
    }
}

// 调用系统动画结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.targerIndex = -1;
}

@end
