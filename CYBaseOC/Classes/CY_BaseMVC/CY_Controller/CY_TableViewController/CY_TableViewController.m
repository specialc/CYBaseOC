//
//  CY_TableViewController.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewController.h"

@interface CY_TableViewController ()

@property (nonatomic) CGSize keyboardSize; // 键盘尺寸
@property (nonatomic) CGSize originContentSize; //

@end

@implementation CY_TableViewController

- (UITableViewStyle)cc_tableViewStyle {
    return UITableViewStylePlain;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cc_refresh = [[CY_RefreshManager alloc] initWithHandlerScrollView:self.cc_tableView delegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.cc_clearsSelectionOnViewWillAppear) {
        [self.cc_tableView deselectRowAtIndexPath:self.cc_tableView.indexPathForSelectedRow animated:YES];
    }
    
    if ([self cc_isUseDefaultKeyboardManager]) {
        [self.cc_keyboardManager cc_addKeyboardObserver];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self cc_isUseDefaultKeyboardManager]) {
        [self.cc_keyboardManager cc_removeKeyboardObserver];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 页面构造

- (void)cc_loadNavigationBar {
    [super cc_loadNavigationBar];
}

- (void)cc_loadViews {
    [super cc_loadViews];
    
    // 用来解决iOS7-iOS8系统中 Tabbar NavigationBar合用时automaticallyAdjustsScrollViewInsets出现的问题
    // 请勿改变控件顺序z-index，切记
    CY_BaseView *tableViewAdhereView = [[CY_BaseView alloc] init];
    [self.view addSubview:tableViewAdhereView];
    
    CY_TableView *tableView = [[CY_TableView alloc] initWithFrame:CGRectZero style:[self cc_tableViewStyle]];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.estimatedRowHeight = 44;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    _cc_tableView = tableView;
    
    if (@available(iOS 11.0, *)) {
        self.cc_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [tableViewAdhereView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.cc_tableView);
        make.height.equalTo(0).priorityHigh();
    }];
    
    [self cc_loadStaticTableViewCell];
    self.cc_clearsSelectionOnViewWillAppear = YES;
    
    [self.cc_navBar bringToFront];
}

- (void)cc_loadButtonBar {
    [super cc_loadButtonBar];
    
    self.cc_tableView.cc_contentInsetBottom = self.cc_buttonBar.height;
}

- (void)cc_layoutConstraints {
    [super cc_layoutConstraints];
    
    [self.cc_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo((self.cc_navBar && !self.cc_navBar.hidden) ? self.cc_navBar.mas_bottom : self.view.mas_top).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - CY_TableViewDelegate

- (void)cc_tableViewTouchesBegan:(CY_TableView *)sender {
    if (sender == self.cc_tableView) {
        [self.view endEditing:YES];
    }
}

#pragma mark - UITableView

- (void)cc_loadStaticTableViewCell {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
}

#pragma mark - Keyboard Methods

- (void)cc_keyboardManager:(CY_KeyboardManager *)keyboardManager showWithFrame:(CGRect)keyboardFrame duration:(NSTimeInterval)duration {
    // 防止重入，可以改进
    if (CGSizeEqualToSize(self.keyboardSize, CGSizeZero)) {
        self.originContentSize = self.cc_tableView.contentSize;
        self.keyboardSize = keyboardFrame.size;
        [self keyboardShowScrollTableView:self.cc_tableView duration:duration];
    }
}

- (void)cc_keyboardManager:(CY_KeyboardManager *)keyboardManager hideWithFrame:(CGRect)keyboardFrame duration:(NSTimeInterval)duration {
    CGFloat height = MAX(self.originContentSize.height, self.cc_tableView.contentSize.height - self.keyboardSize.height);
    self.cc_tableView.contentSize = CGSizeMake(self.cc_tableView.contentSize.width, height);
    self.keyboardSize = CGSizeZero;
}

- (BOOL)keyboardShowScrollTableView:(UITableView *)tableView duration:(NSTimeInterval)duration {
    // 键盘的处理参考:
    // https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
    // 1. 不使用contentInsets的方式是因为在iOS7&iOS7+，输入框会随着contentInsets自动调整到不被键盘遮挡
    //    但是在iOS7-中需要我们自己做调整，所有在这里使用调整contentSize的方式处理，保证在不同版本系统中的处理方式一致
    
    // 在这里根据键盘高度调整contentSize实际是偏大的
    
    // 获得输入焦点，使用了“黑科技”
    // http://stackoverflow.com/questions/5029267/is-there-any-way-of-asking-an-ios-view-which-of-its-children-has-first-responder/14135456#14135456
    UIView *responderView = [UIResponder cc_currentFirstResponder];
    
    if (![responderView isKindOfClass:[UITextField class]] && ![responderView isKindOfClass:[UITextView class]]) {
        return NO;
    }
    
    if (![responderView isDescendantOfView:self.cc_tableView]) {
        return NO;
    }
    
    tableView.contentSize = CGSizeMake(tableView.contentSize.width, tableView.contentSize.height + self.keyboardSize.height);
    // Offset with tableview
    CGPoint point = [responderView convertPoint:CGPointMake(0, responderView.frame.size.height) toView:tableView];
    
    if ((point.y + self.keyboardSize.height) < CGRectGetHeight(tableView.frame)) {
        return NO;
    }
    
    point.y -= 30.0;
    CGFloat maxPointY = tableView.contentSize.height - CGRectGetHeight(tableView.frame);
    CGFloat toPointY = (point.y > maxPointY) ? maxPointY : point.y;
    
    [UIView animateWithDuration:duration animations:^{
        // 最多移到底部，使得后续的滑动平顺
        tableView.contentOffset = CGPointMake(0, toPointY);
    }];
    
    return YES;
}

#pragma mark - 刷新事件

- (void)cc_refreshHeaderAction:(CY_RefreshManager *)refresh {
    [self.dataDelegate cc_viewController:self loadingWithParameters:nil];
}

- (void)cc_refreshFooterAction:(CY_RefreshManager *)refresh {
    [self.dataDelegate cc_viewController:self loadingWithParameters:nil];
}

- (void)cc_setLoadingSuccess:(id)data {
    [super cc_setLoadingSuccess:data];
    
    // 缓存
//    if ([data isKindOfClass:[PythiaDataEntity class]]) {
//        if ([data isCache]) {
//            return;
//        }
//    }
    
    // 下拉刷新
    if (self.cc_refresh.cc_isHeaderRefreshing) {
        [self.cc_refresh cc_endHeaderRefreshing];
    }
    // 上拉刷新
    if (self.cc_refresh.cc_isFooterRefreshing) {
        [self.cc_refresh cc_endFooterRefreshing];
    }
}

- (void)cc_setLoadingFailure:(NSError *)error {
    // 页面加载
    if (self.cc_loadingManager.cc_isLoading) {
        [super cc_setLoadingFailure:error];
    }
    
    // 下拉刷新
    else if (self.cc_refresh.cc_isHeaderRefreshing) {
        [super cc_setLoadingFailure:error];
        [self.cc_refresh cc_endHeaderRefreshing];
    }
    
    // 上拉刷新，直接提示错误
    else if (self.cc_refresh.cc_isFooterRefreshing) {
        [self.cc_refresh cc_endFooterRefreshing];
        ShowInfoHUD(error.msg ?: @"数据加载失败，请稍后再试");
    }
    
    // 其他情况，可能是没有触发刷新动作的后台刷新
    else {
        ShowInfoHUD(error.msg ?: @"数据加载失败，请稍后再试");
    }
}

#pragma mark - 微财富遗留

#pragma mark - scroll 特效

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.cc_tableView) {
        
//        // 下拉刷新隐藏navigationBar
//        if ([self headerRefreshingEffect]) {
//
//            CGPoint contentOffset = scrollView.contentOffset;
//            CGFloat clearOffset = 44;
//
//            if (contentOffset.y >= 0) {
//                self.navBar.alpha = 1;
//            }
//            else {
//                CGFloat alpha = 1 - fabs(contentOffset.y / clearOffset);
//                if (alpha <= 0) {
//                    alpha = 0.0;
//                }
//                else if (alpha > 1.0) {
//                    alpha = 1.0;
//                }
//                self.navBar.alpha = alpha;
//            }
//        }
//
//        // 向下滚动加深navigationBar的颜色
//        if ([self tableViewScrollDownEffect]) {
//
//            CGPoint contentOffset = scrollView.contentOffset;
//            CGFloat clearOffset = 100.0;
//            CGFloat alpha = contentOffset.y / clearOffset;
//
//            if (alpha <= 0) {
//                alpha = 0.0;
//            }
//            else if (alpha > 1.0) {
//                alpha = 1.0;
//            }
//            self.navBar.backgroundView.alpha = alpha;
//        }
    }
}

#pragma mark - 结束所有刷新

- (void)endRefreshing {
    [self.cc_loadingManager cc_endLoading];
    [self.cc_refresh cc_endHeaderRefreshing];
    [self.cc_refresh cc_endFooterRefreshing];
}


@end
