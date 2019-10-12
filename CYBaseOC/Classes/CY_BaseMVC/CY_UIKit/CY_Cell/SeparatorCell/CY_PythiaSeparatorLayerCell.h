//
//  CY_PythiaSeparatorLayerCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/25.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"
#import "CY_Lib.h"

@interface CY_PythiaSeparatorLayerCell : CY_TableViewCell

@property (nonatomic, assign) CGFloat cc_cellHeight;
@property (nonatomic, assign) UIColor *cc_layoutColor;

- (instancetype)initWithCellHeight:(CGFloat)height;

@end
