//
//  CY_CheckButton.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface CY_CheckButton : UIButton
@property (nonatomic, assign, getter=isChecked) BOOL cc_checked;
@property (nonatomic, strong) UIImage *cc_checkedImage;
@property (nonatomic, strong) UIImage *cc_uncheckedImage;
@end

