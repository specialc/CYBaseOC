//
//  CY_InfoHUDView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseView.h"

// 浮层提示
@interface CY_InfoHUDView : CY_BaseView

+ (void)cc_showTitle:(NSString *)title;
+ (void)cc_showTitle:(NSString *)title duration:(NSTimeInterval)duration;

@end

