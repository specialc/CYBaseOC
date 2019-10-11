//
//  CY_PythiaLinkString.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CY_PythiaLinkString : NSObject
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) BOOL isLink;
@property (nonatomic, copy) NSString *linkFlag;

// 图片
@property (nonatomic, strong) UIImage *image;

// 按钮
@property (nonatomic, strong) UIButton *button;
@end

