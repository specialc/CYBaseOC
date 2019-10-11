//
//  CY_TableView.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableView.h"

@implementation CY_TableView

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    // 转发点击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_tableViewTouchesBegan:)]) {
        [self.delegate cc_tableViewTouchesBegan:self];
    }
}

@end
