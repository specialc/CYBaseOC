//
//  CY_TableViewHeaderFooterView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"


@interface CY_TableViewHeaderFooterView : UITableViewHeaderFooterView <CY_BaseViewProtocol>

@property (nonatomic, weak) CY_ImageView *cc_separator;

/**
 Default: top is invalid, left is 15, bottom is 0, right is 0
 */
@property (nonatomic, assign) UIEdgeInsets cc_separatorEdgeInset;


/**
 Default is 1.f
 */
@property (nonatomic, assign) CGFloat cc_separatorHeight;

@property (nonatomic, strong) UIColor *cc_separatorColor;


/**
 Default is true
 */
@property (nonatomic, assign) BOOL cc_separatorHidden;

@property (nonatomic, strong) UIColor *cc_backgroundColor;

@end


