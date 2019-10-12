//
//  CY_ProgressView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseView.h"
#import "CY_Lib.h"

@interface CY_ProgressView : CY_BaseView
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, assign) CGFloat progress; // 0.0 - 1.0
@end
