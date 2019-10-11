//
//  CY_PickerModel.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CY_PickerModel : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;
+ (instancetype)pickerModelWithKey:(NSString *)key value:(NSString *)value;
@end
