//
//  NSURL+CY_Category.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/3.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  把NSURL的query转成NSDictionary
 */

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

@interface NSURL (CY_Category)
- (NSDictionary *)queryDictionary;
@end

@interface NSString (Query)
- (NSDictionary *)queryDictionary;
@end
