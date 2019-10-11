//
//  MASConstraintMaker+CY_Forbearance.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MASConstraintMaker+CY_Forbearance.h"
#import <objc/runtime.h>

@interface MASConstraintMaker ()
@property (nonatomic, strong) NSNumber *cc_forbearanceRules;
@end

@implementation MASConstraintMaker (CY_Forbearance)

static NSString *CY_ForbearanceRulesKey = @"Mark.By.CY.ForbearanceRules";

- (NSNumber *)cc_forbearanceRules {
    return objc_getAssociatedObject(self, &CY_ForbearanceRulesKey);
}

- (CY_MASForbearance *)cc_hugging {
    CY_MASForbearance *forbearance = CY_MASForbearance.new;
    forbearance.delegate = self;
    return forbearance.cc_hugging;
}

- (CY_MASForbearance *)cc_compression {
    CY_MASForbearance *forbearance = CY_MASForbearance.new;
    forbearance.delegate = self;
    return forbearance.cc_compression;
}

- (CY_MASForbearance *)cc_compressionResistance {
    CY_MASForbearance *forbearance = CY_MASForbearance.new;
    forbearance.delegate = self;
    return forbearance.cc_compressionResistance;
}

- (CY_MASForbearance *)cc_horizontal {
    CY_MASForbearance *forbearance = CY_MASForbearance.new;
    forbearance.delegate = self;
    return forbearance.cc_horizontal;
}

- (CY_MASForbearance *)cc_vertical {
    CY_MASForbearance *forbearance = CY_MASForbearance.new;
    forbearance.delegate = self;
    return forbearance.cc_vertical;
}

- (CY_MASForbearance *)cc_forbearance:(CY_MASForbearance *)forbearance addForbearanceRule:(CY_MASForbearanceRule)forbearanceRule {
    NSUInteger rule = self.cc_forbearanceRules.unsignedIntegerValue;
    self.cc_forbearanceRules = [NSNumber numberWithUnsignedInteger:rule | forbearanceRule];
    return forbearance;
}

- (CY_MASForbearance *)cc_forbearance:(CY_MASForbearance *)forbearance priority:(MASLayoutPriority)priority {
    MAS_VIEW *view = [self performSelector:@selector(view)];
    NSUInteger rule = self.cc_forbearanceRules.unsignedIntegerValue;
    if (!(rule & CY_MASForbearanceRule_Hugging || rule & CY_MASForbearanceRule_Compression)) {
        NSLog(@"CY_:You must specify a rule of hugging or compression");
        return forbearance;
    }
    
    // hugging
    if (rule & CY_MASForbearanceRule_Hugging && !(rule & CY_MASForbearanceRule_Horizontal || rule & CY_MASForbearanceRule_Vertical)) {
        [view setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        [view setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        self.cc_forbearanceRules = [NSNumber numberWithUnsignedInteger:0];
        return forbearance;
    }
    
    // compression
    if (rule & CY_MASForbearanceRule_Compression && !(rule & CY_MASForbearanceRule_Horizontal || rule & CY_MASForbearanceRule_Vertical)) {
        [view setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        [view setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        self.cc_forbearanceRules = [NSNumber numberWithUnsignedInteger:0];
        return forbearance;
    }
    
    // hugging: Horizontal 或 Vertical
    if (rule & CY_MASForbearanceRule_Hugging) {
        if (rule & CY_MASForbearanceRule_Horizontal) {
            [view setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        }
        if (rule & CY_MASForbearanceRule_Vertical) {
            [view setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        }
    }
    
    //
    if (rule & CY_MASForbearanceRule_Compression) {
        if (rule & CY_MASForbearanceRule_Horizontal) {
            [view setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        }
        if (rule & CY_MASForbearanceRule_Vertical) {
            [view setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        }
    }
    
    self.cc_forbearanceRules = [NSNumber numberWithUnsignedInteger:0];
    return forbearance;
}

- (void)setCc_forbearanceRules:(NSNumber *)cc_forbearanceRules {
    objc_setAssociatedObject(self, &CY_ForbearanceRulesKey, cc_forbearanceRules, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
