//
//  CY_PythiaEmptyCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"

@interface CY_PythiaEmptyCell : CY_TableViewCell
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat cc_topMargin;
@end

