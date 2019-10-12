//
//  UIView+CY_ShorthandAdditions.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/27.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *    Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "CY_Lib.h"

@interface MAS_VIEW (CY_ShorthandAdditions)
- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;
@end
