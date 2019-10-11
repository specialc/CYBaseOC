//
//  CY_LabelCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"

typedef NS_ENUM(NSUInteger, CY_IconPosition) {
    CY_IconPositionLeftTop,
    CY_IconPositionLeftMiddle,
};

@interface CY_LabelCell : CY_TableViewCell

/**
 最小行高 default is 44
 */
@property (nonatomic, assign) CGFloat cc_minimumCellHeight;

/**
 default is 8
 */
@property (nonatomic, assign) CGFloat cc_topPadding;

/**
 default is 8
 */
@property (nonatomic, assign) CGFloat cc_bottomPadding;

/**
 default is 15
 */
@property (nonatomic, assign) CGFloat cc_leftPadding;

/**
 default is 15
 */
@property (nonatomic, assign) CGFloat cc_rightPadding;


@property (nonatomic, assign) UIEdgeInsets cc_edgeInsets;

@property (nonatomic, weak) UIView *cc_bgView;
@property (nonatomic, weak) CY_BaseLabel *cc_titleLabel;
@property (nonatomic, copy) NSString *cc_title;
@property (nonatomic, copy) UIColor *cc_titleColor;
@property (nonatomic, copy) UIFont *cc_titleFont;


@end

