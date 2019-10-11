//
//  UIResponder+CY_Category.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIResponder+CY_Category.h"

static __weak id cc_currentFirstResponder;

@implementation UIResponder (CY_Category)

+ (id)cc_currentFirstResponder {
    cc_currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(cc_findFirstResponder:) to:nil from:nil forEvent:nil];
    return cc_currentFirstResponder;
}

- (void)cc_findFirstResponder:(id)sender {
    cc_currentFirstResponder = self;
}

@end
