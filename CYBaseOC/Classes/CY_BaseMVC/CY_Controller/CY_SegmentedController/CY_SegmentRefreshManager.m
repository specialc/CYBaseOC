//
//  CY_SegmentRefreshManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/8.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_SegmentRefreshManager.h"

@interface CY_SegmentRefreshManager () <CY_RefreshDelegate>

@end

@implementation CY_SegmentRefreshManager

- (void)setScrollViews:(NSArray<UIScrollView *> *)scrollViews andInstall:(CY_RefreshHeaderType)type {
    self.scrollViews = scrollViews;
    [self installRefreshHeader:type];
}

- (void)installRefreshHeader:(CY_RefreshHeaderType)type {
    self.refreshManagers = [self.scrollViews map:^id(UIScrollView *element) {
        CY_RefreshManager *refresh = [CY_RefreshManager cc_refreshManagerWithHandlerScrollView:element delegate:self];
        [refresh cc_installRefreshHeader:type];
        return refresh;
    }];
}

- (void)installRefreshHeader {
    [self installRefreshHeader:CY_RefreshHeaderType_Normal];
}

- (void)beginHeaderRefreshingAtIndex:(NSUInteger)index {
    [self.refreshManagers[index] cc_beginHeaderRefreshing];
}

- (void)endHeaderRefreshingAtIndex:(NSUInteger)index {
    [self.refreshManagers[index] cc_endHeaderRefreshing];
}

- (BOOL)isHeaderRefreshingAtIndex:(NSUInteger)index {
    return [self.refreshManagers[index] cc_isHeaderRefreshing];
}



- (void)installRefreshFooterAtIndex:(NSUInteger)index {
    return [self.refreshManagers[index] cc_installRefreshFooter];
}

- (void)uninstallRefreshFooterAtIndex:(NSUInteger)index {
    return [self.refreshManagers[index] cc_uninstallRefreshFooter];
}

- (void)beginFooterRefreshingAtIndex:(NSUInteger)index {
    return [self.refreshManagers[index] cc_beginFooterRefreshing];
}

- (void)endFooterRefreshingAtIndex:(NSUInteger)index {
    return [self.refreshManagers[index] cc_endFooterRefreshing];
}

- (BOOL)isFooterRefreshingAtIndex:(NSUInteger)index {
    return [self.refreshManagers[index] cc_isFooterRefreshing];
}

- (void)setRefreshFooterNoMoreData:(NSString *)info atIndex:(NSUInteger)index {
    return [self.refreshManagers[index] cc_setRefreshFooterNoMoreData:info];
}

- (void)cc_refreshHeaderAction:(CY_RefreshManager *)refresh {
    NSUInteger index = [self.refreshManagers indexOfObject:refresh];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_refreshHeaderAction:atIndex:)]) {
        [self.delegate cc_refreshHeaderAction:refresh atIndex:index];
    }
}

- (void)cc_refreshFooterAction:(CY_RefreshManager *)refresh {
    NSUInteger index = [self.refreshManagers indexOfObject:refresh];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_refreshFooterAction:atIndex:)]) {
        [self.delegate cc_refreshFooterAction:refresh atIndex:index];
    }
}



@end
