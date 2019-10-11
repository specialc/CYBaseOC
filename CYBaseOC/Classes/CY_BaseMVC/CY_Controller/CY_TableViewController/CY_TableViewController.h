//
//  CY_TableViewController.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  TableView基础控制器
 */

#import "CY_BaseViewController.h"
#import "CY_RefreshManager.h"

@interface CY_TableViewController : CY_BaseViewController <CY_RefreshDelegate, UITableViewDataSource, CY_TableViewDelegate>

@property (nonatomic, strong, readonly) CY_TableView *cc_tableView;
@property (nonatomic, assign) BOOL cc_clearsSelectionOnViewWillAppear;

// 预先设定当前TableView的Style
- (UITableViewStyle)cc_tableViewStyle;

// 请重写这个方法，并在里面创建页面静态的Cell
- (void)cc_loadStaticTableViewCell;

#pragma mark - 页面刷新

// 下拉刷新 & 上拉刷新
@property (nonatomic, strong, readonly) CY_RefreshManager *cc_refresh;

@end


