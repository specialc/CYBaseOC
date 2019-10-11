//
//  CY_RichString.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CY_RichString : NSObject
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) BOOL isLink;
@property (nonatomic, copy) NSString *linkFlag;
@end

