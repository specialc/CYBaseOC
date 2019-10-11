//
//  CY_BaseLabel.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_BaseLabel.h"

@implementation CY_BaseLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        // iOS6默认不是透明色，这里强制设置
        self.backgroundColor = UIColor.clearColor;
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 固定宽度，高度自适应，iOS8以下需要
    self.preferredMaxLayoutWidth = self.frame.size.width;
}

@end
