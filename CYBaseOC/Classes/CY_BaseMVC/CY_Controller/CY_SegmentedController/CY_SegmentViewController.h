//
//  CY_SegmentViewController.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseViewController.h"
#import "CY_SegmentControlProtocol.h"
#import "CY_Lib.h"

@protocol CY_SegmentControllerChildViewControllerProtocol <NSObject>

@optional
// 是否需要预加载，即设置ViewControllers的时候即调用-viewDidLoad
- (BOOL)cc_needPreload;
// 暂不推荐使用：将要显示
- (void)cc_childViewWillAppear;
// 暂不推荐使用：显示完成
- (void)cc_childViewDidAppear;
// 暂不推荐使用：将要隐藏
- (void)cc_childViewWillDisappear;
// 暂不推荐使用：隐藏完成
- (void)cc_childViewDidDisappear;

@required
// Index改变时触发
- (void)cc_selectedIndexDidChange;

@end

@interface CY_SegmentViewController : CY_BaseViewController <UIScrollViewDelegate>

// 分页控件
@property (nonatomic, strong) __kindof UIView<CY_SegmentControlProtocol> *cc_segmentView;

// 当前的MainScrollView
@property (nonatomic, strong) UIScrollView *cc_mainScrollView;

@property (nonatomic, strong) NSArray<__kindof UIViewController *> *cc_viewControllers;

// 索引
@property (nonatomic, assign) NSInteger cc_selectedIndex;


- (void)setCc_selectedIndex:(NSInteger)cc_selectedIndex;
- (void)setCc_selectedIndex:(NSInteger)cc_selectedIndex animated:(BOOL)animated;

// 加载SegmentControl，子类可重写，需要遵守CY_SegmentControlProtocol协议
- (void)cc_loadSegmentControl;

// SegmentControl被点击改变时触发
- (void)cc_segmentControlDidChange:(NSInteger)index;

// 分页改变时触发
- (void)cc_selectedIndexDidChange:(NSInteger)index;

@end


