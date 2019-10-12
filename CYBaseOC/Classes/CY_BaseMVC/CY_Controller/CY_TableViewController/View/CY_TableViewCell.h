//
//  CY_TableViewCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"


@interface CY_TableViewCell : UITableViewCell <CY_BaseViewProtocol>

@property (nonatomic, weak) UIView *cc_bgView;
@property (nonatomic, weak) CY_ImageView *cc_separator;

/**
 Default: top is invalid, left is 15, bottom is 0, right is 0
 */
@property (nonatomic, assign) UIEdgeInsets cc_separatorEdgeInset;

/**
 Default is 1.f
 */
@property (nonatomic, assign) CGFloat cc_separatorHeight;

/**
 默认色：#F4F4F4, rgba(237,237,237,1)
 */
@property (nonatomic, strong) UIColor *cc_separatorColor;

/**
 Default is true
 */
@property (nonatomic, assign) BOOL cc_separatorHidden;

@property (nonatomic, strong) UIColor *cc_backgroundColor;

+ (CGFloat)heightForData:(id)data;

@end


