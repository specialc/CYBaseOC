//
//  CY_PagedFlowViewItem.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface CY_PagedFlowViewItem : UIView


/**
 主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;

/**
 用来变色的View
 */
@property (nonatomic, strong) UIView *coverView;

@end
