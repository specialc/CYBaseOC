//
//  CY_RefreshHeader.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/8.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MJRefreshStateHeader.h"


@interface CY_RefreshHeader : MJRefreshStateHeader

@property (nonatomic, weak, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@property (nonatomic, copy) UIColor *backgroundColor;
@property (nonatomic, copy) UIColor *tintColor;;

@end

