//
//  CY_ImageCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"
#import "CY_Lib.h"

typedef NS_ENUM(NSUInteger, CY_ImageCellAlignment) {
    CY_ImageCellAlignmentLeft,   // 居左
    CY_ImageCellAlignmentCenter, // 居中
    CY_ImageCellAlignmentRight,  // 居右
    CY_ImageCellAlignmentFill,   // 充满：默认
    CY_ImageCellAlignmentExtend, // 拉伸
};

@interface CY_ImageCell : CY_TableViewCell
@property (nonatomic, weak) UIImageView *cc_imageView;
@property (nonatomic, strong) UIImage *cc_image;
// default is CY_ImageCellAlignmentFill
@property (nonatomic, assign) CY_ImageCellAlignment cc_alignment;
@property (nonatomic, assign) UIEdgeInsets cc_imageEdgeInsets;
@end
