//
//  CY_PythiaPlainCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"

@interface CY_PythiaPlainCell : CY_TableViewCell

// 左侧View，可被设置成任意View
@property (nonatomic, strong) UIView *leftView;
// 左侧图片，如果设置有rightView则不显示
@property (nonatomic, weak, readonly) CY_ImageView *leftImageView;
// 标题，默认15px，rgba(35,37,45,1)
@property (nonatomic, weak, readonly) CY_BaseLabel *titleLabel;
// 内容，默认15px，rgba(165,165,165,1)
@property (nonatomic, weak, readonly) CY_BaseLabel *contentLabel;

// 右侧View，可被设置成任意View
@property (nonatomic, strong) UIView *rightView;
// 右侧图片，如果设置有rightView则不显示
@property (nonatomic, weak, readonly) CY_ImageView *rightImageView;

// 右侧间距，默认15，适配图片大小的时候才需要修改
@property (nonatomic, assign) CGFloat cc_rightSpace;
// 右侧间距，默认8，适配图片大小的时候才需要修改
@property (nonatomic, assign) CGFloat cc_contentRightViewSpace;
// 行高，默认大于等于44，不推荐修改
@property (nonatomic, assign) CGFloat cc_cellHeight;

@property (nonatomic, strong) id info;

@end
