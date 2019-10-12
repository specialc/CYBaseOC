//
//  CY_NavigationController.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  StarMVC提供的导航控制器，默认支持侧滑
 */

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@protocol CY_NavigationControllerDelegate <NSObject>

@optional
- (BOOL)cc_popGestureEnabled;

@end

@interface CY_NavigationController : UINavigationController

@end

