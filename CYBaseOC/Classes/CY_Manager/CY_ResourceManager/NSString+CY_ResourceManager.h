//
//  NSString+CY_ResourceManager.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CY_ResourceManager)

@property (nonatomic, strong, readonly) UIFont *cc_font;
@property (nonatomic, strong, readonly) UIColor *cc_color;
@property (nonatomic, strong, readonly) UIColor *(^cc_colorWithAlpha)(CGFloat alpha);
@property (nonatomic, strong, readonly) UIImage *cc_image;
@property (nonatomic, strong, readonly) UIImage *cc_resizableImage;

@end

@interface UILabel (CY_AmountAdvanceDecline)

@property (nonatomic, strong) NSString *cc_changeAmount;

@end

