//
//  CY_ReuseTableViewController.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewController.h"

@protocol CY_ReuseTableViewProtocol <NSObject>

#pragma mark - HeaderFooter

// 通过ID获取HeaderFooter高度
- (CGFloat)cc_tableView:(UITableView *)tableView heightForHeaderFooterWithIdentifier:(NSString *)identifier inSection:(NSInteger)section;

// 通过ID获取HeaderFooterView
- (UIView *)cc_tableView:(UITableView *)tableView viewForHeaderFooterWithIdentifier:(NSString *)identifier inSection:(NSInteger)section;

// 配置HeaderFooterView
- (void)cc_tableView:(UITableView *)tableView configureHeaderFooterView:(__kindof UITableViewHeaderFooterView *)headerFooterView inSection:(NSInteger)section;

#pragma mark - TableViewCell

// 注册TableViewCell
- (void)cc_registerTableViewCell:(UITableView *)tableView;

// 通过静态Cell获取高度
- (CGFloat)cc_tableView:(UITableView *)tableView heightForCellWithStaticCell:(UITableViewCell *)staticCell;

// 通过ID获取Cell高度
- (CGFloat)cc_tableView:(UITableView *)tableView heightForCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

// 通过ID获取Cell
- (UITableViewCell *)cc_tableView:(UITableView *)tableView cellForRowWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

// 配置TableViewCell
- (void)cc_tableView:(UITableView *)tableView configureTableViewCell:(__kindof UITableViewCell *)currentCell indexPath:(NSIndexPath *)indexPath;

@end

@interface CY_ReuseTableViewController : CY_TableViewController <CY_ReuseTableViewProtocol>

@end


