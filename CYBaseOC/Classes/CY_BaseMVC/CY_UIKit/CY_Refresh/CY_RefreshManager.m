//
//  CY_RefreshManager.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/8.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_RefreshManager.h"

@interface CY_RefreshManager ()
@property (nonatomic, weak, readonly) UIScrollView *cc_scrollView;
@end

@implementation CY_RefreshManager

+ (instancetype)cc_refreshManagerWithHandlerScrollView:(UIScrollView *)scrollView delegate:(id)delegate {
    return [[self alloc] initWithHandlerScrollView:scrollView delegate:delegate];
}

- (instancetype)initWithHandlerScrollView:(UIScrollView *)scrollView delegate:(id)delegate {
    self = [super init];
    if (self) {
        _cc_scrollView = scrollView;
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Refresh Header

- (void)cc_installRefreshHeader {
    [self cc_installRefreshHeader:CY_RefreshHeaderType_Normal];
}

- (void)cc_installRefreshHeader:(CY_RefreshHeaderType)type {
    switch (type) {
        case CY_RefreshHeaderType_Logo:
            {
                CY_LogoRefreshHeader *header = [CY_LogoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
                self.cc_scrollView.mj_header = header;
            }
            break;
            
        case CY_RefreshHeaderType_Red:
        {
            CY_RefreshHeader *header = [CY_RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
            header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            header.backgroundColor = @"system_red_color".cc_color;
            header.tintColor = [UIColor whiteColor];
            self.cc_scrollView.mj_header = header;
        }
            break;
            
        case CY_RefreshHeaderType_Gold:
        {
            CY_RefreshHeader *header = [CY_RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
            header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            header.backgroundColor = @"system_gold_color".cc_color;
            header.tintColor = [UIColor whiteColor];
            self.cc_scrollView.mj_header = header;
        }
            break;
            
        case CY_RefreshHeaderType_Normal:
            
        default:
        {
            CY_RefreshHeader *header = [CY_RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
            header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            header.backgroundColor = [UIColor clearColor];
            header.tintColor = @"#999999".cc_color;
            self.cc_scrollView.mj_header = header;
        }
            break;
    }
}

- (void)cc_beginHeaderRefreshing {
    [self.cc_scrollView.mj_header beginRefreshing];
}

- (void)cc_endHeaderRefreshing {
    [self.cc_scrollView.mj_header endRefreshing];
}

- (BOOL)cc_isHeaderRefreshing {
    return self.cc_scrollView.mj_header.isRefreshing;
}

#pragma mark - Refresh Footer

- (void)cc_installRefreshFooter {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    footer.stateLabel.font = @"14px".cc_font;
    footer.stateLabel.textColor = @"#999999".cc_color;
    footer.tintColor = @"#999999".cc_color;
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"正在加载更多的数据..." forState:MJRefreshStateIdle];
    [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
    self.cc_scrollView.mj_footer = footer;
}

- (void)cc_uninstallRefreshFooter {
    self.cc_scrollView.mj_footer = nil;
}

- (void)cc_beginFooterRefreshing {
    [self.cc_scrollView.mj_footer beginRefreshing];
}

- (void)cc_endFooterRefreshing {
    [self.cc_scrollView.mj_footer endRefreshing];
}

- (BOOL)cc_isFooterRefreshing {
    return self.cc_scrollView.mj_footer.isRefreshing;
}

- (void)cc_setRefreshFooterNoMoreData:(NSString *)info {
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.cc_scrollView.mj_footer;
    if (info) {
        [footer setTitle:info forState:MJRefreshStateNoMoreData];
    }
    [footer setState:MJRefreshStateNoMoreData];
    [footer endRefreshingWithNoMoreData];
}

#pragma mark - 刷新动作

- (void)refreshHeader {
    @try {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cc_refreshHeaderAction:)]) {
            [self.delegate cc_refreshHeaderAction:self];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)refreshFooter {
    @try {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cc_refreshFooterAction:)]) {
            [self.delegate cc_refreshFooterAction:self];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (MJRefreshHeader *)cc_header {
    return self.cc_scrollView.mj_header;
}

- (MJRefreshFooter *)cc_footer {
    return self.cc_scrollView.mj_footer;
}

- (void)cc_refreshFooterStatusForIsEnd:(BOOL)isEnd isFirstPage:(BOOL)isFirstPage {
    if (isEnd) {
        if (isFirstPage) {
            [self cc_uninstallRefreshFooter];
        }
        else {
            [self cc_setRefreshFooterNoMoreData:nil];
        }
    }
    else {
        if (self.cc_footer) {
            if (self.cc_footer.state == MJRefreshStateNoMoreData) {
                [self cc_uninstallRefreshFooter];
                [self cc_installRefreshFooter];
            }
        }
        else {
            [self cc_installRefreshFooter];
        }
    }
}

@end
