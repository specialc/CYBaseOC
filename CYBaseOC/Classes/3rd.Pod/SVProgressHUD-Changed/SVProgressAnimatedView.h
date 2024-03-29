//
//  SVProgressAnimatedView.h
//  SVProgressHUD, https://github.com/SVProgressHUD/SVProgressHUD
//
//  Copyright (c) 2016 Tobias Tiemerding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface SVProgressAnimatedView : UIView

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat strokeThickness;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeEnd;

@end
