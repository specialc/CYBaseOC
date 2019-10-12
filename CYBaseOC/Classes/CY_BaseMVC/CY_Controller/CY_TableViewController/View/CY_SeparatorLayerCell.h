//
//  CY_SeparatorLayerCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"
#import "CY_Lib.h"

@interface CY_SeparatorLayerCell : CY_TableViewCell
@property (nonatomic, assign) CGFloat cc_cellHeight;
@property (nonatomic, assign) UIColor *cc_layerColor;

- (instancetype)initWithCellHeight:(CGFloat)height;

@end

