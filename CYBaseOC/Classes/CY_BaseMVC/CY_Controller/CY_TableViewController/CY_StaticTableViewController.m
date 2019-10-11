//
//  CY_StaticTableViewController.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_StaticTableViewController.h"

@interface CY_StaticTableViewController ()
@property (nonatomic, strong) NSMutableDictionary *dataSource;
@end

@implementation CY_StaticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - TableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    return [rows count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    UITableViewCell *cell = rows[indexPath.row];
    NSInteger cellHeight = [tableView cc_heightForCellWithStaticCell:cell configuration:nil];
    NSAssert(cellHeight, @"行高不应该为0.");
    return cellHeight;
}

- (UITableViewCell *)cc_cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    UITableViewCell *cell = rows[indexPath.row];
    NSAssert(cell, @"cell不应该为nil");
    return cell;
}

#pragma mark - Cell 操作

- (void)cc_loadAllCells {
    NSAssert(NO, @"请在子类实现该方法");
}

- (void)cc_insertCell:(UITableViewCell *)cell toIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    if (rows == nil) {
        rows = [[NSMutableArray alloc] init];
        [self.dataSource setObject:rows forKey:[NSNumber numberWithInteger:indexPath.section]];
    }
    [rows removeObject:cell];
    [rows insertObject:cell atIndex:indexPath.row];
}

- (void)cc_appendCell:(UITableViewCell *)cell toSection:(NSInteger)section {
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    if (rows == nil) {
        rows = [[NSMutableArray alloc] init];
        [self.dataSource setObject:rows forKey:[NSNumber numberWithInteger:section]];
    }
    if ([rows containsObject:cell]) {
        return;
    }
    [rows addObject:cell];
}

- (void)cc_replaceCell:(UITableViewCell *)target withCell:(UITableViewCell *)replacement atSection:(NSInteger)section {
    NSMutableArray *rows = [self.dataSource objectForKey:@(section)];
    if (rows == nil) {
        rows = [[NSMutableArray alloc] init];
        [self.dataSource setObject:rows forKey:@(section)];
    }
    NSUInteger index = [rows indexOfObject:target];
    if (index == NSNotFound) {
        return;
    }
    [rows replaceObjectAtIndex:index withObject:replacement];
}

- (void)cc_removeCell:(UITableViewCell *)cell atSection:(NSInteger)section {
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    if (rows) {
        [rows removeObject:cell];
    }
}

- (void)cc_removeCellAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    if (rows) {
        [rows removeObjectAtIndex:indexPath.row];
    }
}

- (void)cc_removeAllCells {
    if (self.dataSource) {
        [self.dataSource removeAllObjects];
    }
}

- (void)cc_synchronizeAllCells {
    [self.cc_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *rows = self.dataSource[@(indexPath.section)];
    if (rows) {
        if (indexPath.row < [rows count]) {
            return [rows objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

//- (UITableViewCell *)cc_cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSMutableArray *rows = self.dataSource[@(indexPath.section)];
//    if (rows) {
//        if (indexPath.row < [rows count]) {
//            return [rows objectAtIndex:indexPath.row];
//        }
//    }
//    return nil;
//}

- (NSMutableArray *)cc_rowsForSection:(NSInteger)section {
    return self.dataSource[@(section)];
}

- (UITableViewCell *)cc_lastCellForSection:(NSInteger)section {
    return [self cc_rowsForSection:section].lastObject;
}

- (void)cc_reloadCell:(UITableViewCell *)cell withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [self.cc_tableView indexPathForCell:cell];
    if (indexPath) {
        [self.cc_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    }
}

- (NSIndexPath *)cc_indexPathForCell:(UITableViewCell *)cell {
    if (!cell) {
        return nil;
    }
    for (int i = 0; i < self.dataSource.count; i++) {
        NSMutableArray *rows = self.dataSource[@(i)];
        for (int j = 0; j < rows.count; j++) {
            if (rows[j] == cell) {
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    return nil;
}

#pragma mark - 添加常用Separator

#pragma mark - Cell Line

- (void)cc_appendCellSeparatorLineToSection:(NSInteger)section {
    CY_PythiaSeparatorLineCell *line = [[CY_PythiaSeparatorLineCell alloc] init];
    line.cc_separatorEdgeInset = UIEdgeInsetsMake(0, 15, 0, 0);
    [self cc_appendCell:line toSection:section];
}

- (void)cc_appendCellSeparatorLineWithEdgeInsets:(UIEdgeInsets)edgeInsets lineColor:(UIColor *)color lineHeight:(CGFloat)height backgroundColor:(UIColor *)bgColor toSection:(NSInteger)section {
    if (!color) {
        color = UIColor.clearColor;
    }
    
    CY_PythiaSeparatorLineCell *line = [[CY_PythiaSeparatorLineCell alloc] init];
    line.cc_separatorHidden = NO;
    line.cc_separatorHeight = height;
    line.cc_separatorEdgeInset = UIEdgeInsetsMake(edgeInsets.top + height, edgeInsets.left, edgeInsets.bottom, edgeInsets.right);
    line.cc_separatorColor = color;
    line.cc_backgroundColor = bgColor;
    
    [self cc_appendCell:line toSection:section];
}

#pragma mark - Section Line

- (void)cc_appendSeparatorToSection:(NSInteger)section {
    CY_PythiaSeparatorLineCell *line = [[CY_PythiaSeparatorLineCell alloc] init];
    line.cc_separatorEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self cc_appendCell:line toSection:section];
}

- (void)cc_appendSectionSeparatorLineToSection:(NSInteger)section {
    CY_PythiaSeparatorLineCell *line = [[CY_PythiaSeparatorLineCell alloc] init];
    line.cc_separatorHidden = NO;
    line.cc_separatorHeight = 0.5;
    line.cc_separatorEdgeInset = UIEdgeInsetsMake(0.5, 0, 0, 0);
    line.cc_separatorColor = UIColor.whiteColor;
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    if (rows == nil || rows.lastObject) {
        line.cc_backgroundColor = self.cc_tableView.backgroundColor;
    }
    else {
        UITableViewCell *cell = rows.lastObject;
        line.cc_backgroundColor = cell.contentView.backgroundColor;
    }
    [self cc_appendCell:line toSection:section];
}

#pragma mark - Section Layer

- (void)cc_appendSectionSeparatorLayerToSection:(NSInteger)section {
    [self cc_appendSectionSeparatorLayerWithHeight:15 toSection:section];
}

- (void)cc_appendSectionSeparatorLayerWithHeight:(CGFloat)height toSection:(NSInteger)section {
    [self cc_appendSectionSeparatorLayerWithHeight:height color:self.cc_tableView.backgroundColor toSection:section];
}

- (void)cc_appendSectionSeparatorLayerWithHeight:(CGFloat)height color:(UIColor *)color toSection:(NSInteger)section {
    CY_SeparatorLayerCell *separator = [[CY_SeparatorLayerCell alloc] initWithCellHeight:height];
    separator.cc_layerColor = color;
    [self cc_appendCell:separator toSection:section];
    
}

#pragma mark - 动态行标记

static NSString *DynamicCellBeginFlagKey = @"DynamicCellBeginFlagKey";

- (void)cc_markDynamicCellBeginFlag:(NSString *)beginFlag toSection:(NSInteger)section {
    NSArray *rows = [self.dataSource objectForKey:@(section)];
    if (rows.lastObject) {
        objc_setAssociatedObject(rows.lastObject, &DynamicCellBeginFlagKey, beginFlag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSInteger)cc_IndexOfDynamicCellBeginFlag:(NSString *)beginFlag section:(NSInteger)section {
    NSArray *rows = [self.dataSource objectForKey:@(section)];
    for (int i = 0; i < rows.count; i++) {
        id obj = objc_getAssociatedObject(rows[i], &DynamicCellBeginFlagKey);
        if (obj && [obj isKindOfClass:[NSString class]] && [beginFlag isEqualToString:((NSString *)obj)]) {
            return i + 1;
        }
    }
    return 0;
}

#pragma mark - Getter

- (NSMutableDictionary *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableDictionary alloc] init];
    }
    return _dataSource;
}

@end
