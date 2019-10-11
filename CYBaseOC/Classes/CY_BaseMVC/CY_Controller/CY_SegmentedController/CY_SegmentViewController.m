//
//  CY_SegmentViewController.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_SegmentViewController.h"
#import "CY_SegmentControl.h"

@interface CY_SegmentViewController ()
@property (nonatomic, assign) BOOL scrolling;
@property (nonatomic, strong) NSArray<UIView *> *childViews;
@end

@implementation CY_SegmentViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _cc_selectedIndex = NSUIntegerMax;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)cc_loadViews {
    [super cc_loadViews];
    
    {
        // SegmentControl
        [self cc_loadSegmentControl];
        weakify_self
        self.cc_segmentView.cc_IndexChangeBlock = ^(NSInteger index) {
            strongify_self
            [self cc_segmentControlDidChange:index];
            [self setCc_selectedIndex:index animated:YES];
        };
    }
    
    {
        // ScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.backgroundColor = UIColor.whiteColor;
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scrollView];
        self.cc_mainScrollView = scrollView;
    }
    
    // 侧滑手势冲突问题
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    for (UIGestureRecognizer *gestureRecognizer in gestureArray) {
        if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [self.cc_mainScrollView.panGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
        }
    }
}

- (void)cc_loadSegmentControl {
    CY_SegmentControl *segmentControl = [[CY_SegmentControl alloc] init];
    [self.view addSubview:segmentControl];
    self.cc_segmentView = segmentControl;
}

- (void)cc_layoutConstraints {
    [self.cc_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo((self.cc_navBar && !self.cc_navBar.hidden) ? self.cc_navBar.mas_bottom : self.view.mas_top).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    
    [self.cc_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cc_segmentView.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(0);
    }];
}

- (void)setCc_viewControllers:(NSArray<__kindof UIViewController *> *)cc_viewControllers {
    // 清空，防止内存泄漏
    if (_cc_viewControllers.count) {
        [_cc_viewControllers forEach:^(NSInteger i, __kindof UIViewController *item, BOOL *stop) {
            [item removeFromParentViewController];
        }];
        _cc_viewControllers = nil;
    }
    
    if (_childViews.count) {
        [_childViews forEach:^(NSInteger i, UIView *item, BOOL *stop) {
            [item removeFromSuperview];
        }];
        _childViews = nil;
    }
    
    _cc_viewControllers = cc_viewControllers;
    
    self.childViews = [cc_viewControllers map:^id(__kindof UIViewController *element) {
        [self addChildViewController:element];
        UIView *childView = [[UIView alloc] init];
        childView.userInteractionEnabled = YES;
        [self.cc_mainScrollView addSubview:childView];
        
        // 预加载
        if ([element respondsToSelector:@selector(cc_needPreload)]) {
            if ([(UIViewController<CY_SegmentControllerChildViewControllerProtocol> *)element cc_needPreload]) {
                [self loadViewController:element atChildView:childView];
            }
        }
        return childView;
    }];
    
    self.cc_segmentView.cc_sectionTitles = [cc_viewControllers map:^id(__kindof UIViewController *element) {
        return element.title;
    }];
    [self.childViews mas_distributeSudokuViewsWithFixedItemWidth:0 fixedItemHeight:0 fixedLineSpacing:0 fixedInteritemSpacing:0 warpCount:self.childViews.count topSpacing:0 bottomSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.childViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.cc_mainScrollView.mas_height);
        make.width.equalTo(self.cc_mainScrollView.mas_width);
    }];
    
    if (cc_viewControllers.count) {
        self.cc_selectedIndex = 0;
    }
}

#pragma mark - Method - 加载

// 加载控制器
- (void)loadViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    UIView *childView = self.childViews[index];
    [self loadViewController:viewController atChildView:childView];
}

- (void)loadViewController:(UIViewController *)viewController atChildView:(UIView *)childView {
    [childView addSubview:viewController.view];
    [viewController.view makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

// 将要出现
- (void)delegateChildViewWillAppearAtIndex:(NSInteger)index {
    UIViewController<CY_SegmentControllerChildViewControllerProtocol> *vc = (id)self.cc_viewControllers[index];
    LogWarning(@"-CY_childViewWillAppear");
    if ([vc respondsToSelector:@selector(cc_childViewWillAppear)]) {
        [vc cc_childViewWillAppear];
    }
}

// 将要消失
- (void)delegateChildViewWillDisappearAtIndex:(NSInteger)index {
    UIViewController *vc = self.cc_viewControllers[index];
    LogWarning(@"-CY_childViewWillDisappear");
    if ([vc respondsToSelector:@selector(cc_childViewWillDisappear)]) {
        [vc performSelector:@selector(cc_childViewWillDisappear)];
    }
}

// 将要改变
- (void)delegateSelectedIndexDidChange:(NSInteger)index {
    UIViewController *vc = self.cc_viewControllers[index];
    LogWarning(@"-cc_selectedIndexDidChange");
    if ([vc respondsToSelector:@selector(cc_selectedIndexDidChange)]) {
        [vc performSelector:@selector(cc_selectedIndexDidChange)];
    }
}

#pragma mark - Index Changed

// 选择索引，无动画
- (void)setCc_selectedIndex:(NSInteger)cc_selectedIndex {
    [self setCc_selectedIndex:cc_selectedIndex animated:NO];
}

// 选择索引，有动画
- (void)setCc_selectedIndex:(NSInteger)cc_selectedIndex animated:(BOOL)animated {
    
    // 判断不是第一次加载
    if (_cc_selectedIndex != NSUIntegerMax) {
        // 将要消失
        [self delegateChildViewWillDisappearAtIndex:_cc_selectedIndex];
    }
    
    _cc_selectedIndex = cc_selectedIndex;
    
    // 将要出现
    [self delegateChildViewWillAppearAtIndex:_cc_selectedIndex];
    
    [self.cc_segmentView setCc_selectedSegmentIndex:cc_selectedIndex animated:animated];
    
    CGFloat pageWidth = self.cc_mainScrollView.frame.size.width;
    animated = animated && fabs(self.cc_mainScrollView.contentOffset.x - pageWidth * cc_selectedIndex) < pageWidth * 2;
    if (animated) {
        self.scrolling = YES;
        [self.cc_mainScrollView setContentOffset:CGPointMake(pageWidth * cc_selectedIndex, 0) animated:animated];
    }
    else {
        [self.cc_mainScrollView setContentOffset:CGPointMake(pageWidth * cc_selectedIndex, 0) animated:animated];
        [self selectedIndexDidChange:cc_selectedIndex];
    }
}

// 选择改变时触发，每次改变应该只触发一次
- (void)selectedIndexDidChange:(NSInteger)index {
    [self delegateSelectedIndexDidChange:index];
    // 如果没有
    if (!self.childViews[index].subviews.count) {
        [self loadViewController:self.cc_viewControllers[index] atIndex:index];
    }
    [self cc_selectedIndexDidChange:index];
}

#pragma mark - ScrollView Delegate

// 滚动时触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.cc_mainScrollView) {
        if (self.scrolling) {
            return;
        }
        
        CGFloat pageWidth = scrollView.frame.size.width;
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger pageIndex = (offsetX + pageWidth / 2) / pageWidth;
        // (101 + 100 / 2) / 100 = 1.52 = 1
        // (100 + 100 / 2) / 100 = 1.50 = 1
        // (150 + 100 / 2) / 100 = 2.00 = 2
        if (pageIndex != self.cc_segmentView.cc_selectedSegmentIndex) {
            _cc_selectedIndex = pageIndex;
            [self.cc_segmentView setCc_selectedSegmentIndex:pageIndex animated:YES];
        }
    }
}

// 手动滚动结束后调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.cc_mainScrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger pageIndex = scrollView.contentOffset.x / pageWidth;
        [self.cc_segmentView setCc_selectedSegmentIndex:pageIndex animated:YES];
        [self cc_selectedIndexDidChange:pageIndex];
    }
}

// 移动动画结束
// 调用[scrollView setContentOffset:CGPoint(x, y) animated:YES]触发
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.cc_mainScrollView) {
        self.scrolling = NO;
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger pageIndex = scrollView.contentOffset.x / pageWidth;
        [self selectedIndexDidChange:pageIndex];
    }
}

#pragma mark - 子类使用

- (void)cc_segmentControlDidChange:(NSInteger)index {}

- (void)cc_selectedIndexDidChange:(NSInteger)index {}

@end
