//
//  CY_PythiaIconLabelCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_PythiaLabelCell.h"
#import "CY_Lib.h"

@interface CY_PythiaIconLabelCell : CY_PythiaLabelCell


/**
 默认值：CY_IconPositionLeftMiddle
 */
@property (nonatomic, assign) CY_IconPosition cc_iconPosition;


/**
 图标左边距，默认值是0
 如果设置为0，该属性无效，leftPadding生效，
 default is 0， 0 is invalid
 */
@property (nonatomic, assign) CGFloat cc_iconHorizontal;

@property (nonatomic, weak) CY_ImageView *cc_iconView;

@property (nonatomic, strong) UIImage *cc_icon;

// CGSizeZero is invalid, default is CGSizeZero
@property (nonatomic, assign) CGSize cc_iconSize;

@end
