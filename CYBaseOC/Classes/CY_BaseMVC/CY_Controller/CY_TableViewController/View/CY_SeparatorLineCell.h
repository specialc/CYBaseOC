//
//  CY_SeparatorLineCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"

@interface CY_SeparatorLineCell : CY_TableViewCell
@property (nonatomic, assign) CGFloat cc_leftMargin;
@property (nonatomic, strong) UIImage *cc_lineImage;
- (instancetype)initWithLeftMargin:(CGFloat)leftMargin;
@end
