//
//  CY_Forbearance.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/18.
//  Copyright © 2019 CY. All rights reserved.
//

#ifndef CY_Forbearance_h
#define CY_Forbearance_h

#import "CY_MASForbearance.h"
#import "MASConstraintMaker+CY_Forbearance.h"

#import "NSArray+CY_ShorthandAdditions.h"
#import "NSArray+CY_Sudoku.h"
#import "UIView+CY_Forbearance.h"
#import "UIView+CY_ShorthandAdditions.h"


#define equalTo(...)                     mas_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        mas_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           mas_lessThanOrEqualTo(__VA_ARGS__)
#define offset(...)                      mas_offset(__VA_ARGS__)


#endif /* CY_Forbearance_h */
