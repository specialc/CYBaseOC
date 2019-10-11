//
//  CY_ReuseTableViewController.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_ReuseTableViewController.h"

@interface CY_ReuseTableViewController ()

@end

@implementation CY_ReuseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)cc_loadViews {
    [super cc_loadViews];
    
    [self cc_registerTableViewCell:self.cc_tableView];
}

#pragma mark - UITableViewDelegate

- (void)cc_registerTableViewCell:(UITableView *)tableView {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(NO, @"子类必须重新该方法");
    return nil;
}

#pragma mark - 头部

- (CGFloat)cc_tableView:(UITableView *)tableView heightForHeaderFooterWithIdentifier:(NSString *)identifier inSection:(NSInteger)section {
    return [tableView fd_heightForHeaderFooterViewWithIdentifier:identifier configuration:^(id headerFooterView) {
        [self cc_tableView:tableView configureHeaderFooterView:headerFooterView inSection:section];
    }];
}

- (UIView *)cc_tableView:(UITableView *)tableView viewForHeaderFooterWithIdentifier:(NSString *)identifier inSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    [self cc_tableView:tableView configureHeaderFooterView:headerFooterView inSection:section];
    return headerFooterView;
}

- (void)cc_tableView:(UITableView *)tableView configureHeaderFooterView:(__kindof UITableViewHeaderFooterView *)headerFooterView inSection:(NSInteger)section {
    
}

#pragma mark - 操作

- (CGFloat)cc_tableView:(UITableView *)tableView heightForCellWithStaticCell:(UITableViewCell *)staticCell {
    return [tableView cc_heightForCellWithStaticCell:staticCell configuration:NULL];
}

- (CGFloat)cc_tableView:(UITableView *)tableView heightForCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        [self cc_tableView:tableView configureTableViewCell:cell indexPath:indexPath];
    }];
}

- (UITableViewCell *)cc_tableView:(UITableView *)tableView cellForRowWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [self cc_tableView:tableView configureTableViewCell:cell indexPath:indexPath];
    return cell;
}

- (void)cc_tableView:(UITableView *)tableView configureTableViewCell:(__kindof UITableViewCell *)currentCell indexPath:(NSIndexPath *)indexPath {
    
}

@end
