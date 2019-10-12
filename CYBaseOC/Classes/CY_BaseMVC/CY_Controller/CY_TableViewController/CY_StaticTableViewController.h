//
//  CY_StaticTableViewController.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/13.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  TableView的基础控制器，非可复用的页面（类似个人信息），需要继承这个控制器
 */

#import "CY_TableViewController.h"
#import "CY_PythiaSeparatorLineCell.h"
#import "CY_SeparatorLayerCell.h"
#import "CY_Lib.h"

@interface CY_StaticTableViewController : CY_TableViewController


/**
 请重写此方法加载cell
 */
- (void)cc_loadAllCells;

#pragma mark - Cell 操作

- (void)cc_appendCell:(UITableViewCell *)cell toSection:(NSInteger)section;
- (void)cc_insertCell:(UITableViewCell *)cell toIndexPath:(NSIndexPath *)indexPath;
- (void)cc_replaceCell:(UITableViewCell *)target withCell:(UITableViewCell *)replacement atSection:(NSInteger)section;
- (void)cc_removeCell:(UITableViewCell *)cell atSection:(NSInteger)section;
- (void)cc_removeCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)cc_removeAllCells;
- (void)cc_synchronizeAllCells;


- (UITableViewCell *)cc_cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSMutableArray *)cc_rowsForSection:(NSInteger)section;
- (UITableViewCell *)cc_lastCellForSection:(NSInteger)section;

- (void)cc_reloadCell:(UITableViewCell *)cell withRowAnimation:(UITableViewRowAnimation)animation;

- (NSIndexPath *)cc_indexPathForCell:(UITableViewCell *)cell;

#pragma mark - 动态操作

// 标记动态行起始位置
- (void)cc_markDynamicCellBeginFlag:(NSString *)beginFlag toSection:(NSInteger)section;

// 获取动态行起始位置
- (NSInteger)cc_IndexOfDynamicCellBeginFlag:(NSString *)beginFlag section:(NSInteger)section;

#pragma mark - 常规

#pragma mark - Section Line

- (void)cc_appendCellSeparatorLineToSection:(NSInteger)section;
- (void)cc_appendSeparatorToSection:(NSInteger)section;
- (void)cc_appendCellSeparatorLineWithEdgeInsets:(UIEdgeInsets)edgeInsets lineColor:(UIColor *)color lineHeight:(CGFloat)height backgroundColor:(UIColor *)bgColor toSection:(NSInteger)section;
- (void)cc_appendSectionSeparatorLineToSection:(NSInteger)section;

#pragma mark - Section Layer

- (void)cc_appendSectionSeparatorLayerToSection:(NSInteger)section;
- (void)cc_appendSectionSeparatorLayerWithHeight:(CGFloat)height toSection:(NSInteger)section;
- (void)cc_appendSectionSeparatorLayerWithHeight:(CGFloat)height color:(UIColor *)color toSection:(NSInteger)section;

@end
