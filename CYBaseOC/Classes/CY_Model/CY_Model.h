//
//  CY_Model.h
//  CYBase
//
//  Created by 张春咏 on 2019/7/14.
//  Copyright © 2019 CY. All rights reserved.
//
/**
 *  返回值反射对象
 */

#import <JSONModel/JSONModel.h>

@interface CY_Model : JSONModel
@property (nonatomic, assign) BOOL isCache;
+ (id)tempData;
@end
