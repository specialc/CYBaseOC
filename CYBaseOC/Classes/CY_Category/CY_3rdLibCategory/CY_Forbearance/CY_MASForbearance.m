//
//  CY_MASForbearance.m
//  CYBase
//
//  Created by 张春咏 on 2019/5/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_MASForbearance.h"

@implementation CY_MASForbearance

- (CY_MASForbearance *)cc_hugging {
    return [self.delegate cc_forbearance:self addForbearanceRule:CY_MASForbearanceRule_Hugging];
}

- (CY_MASForbearance *)cc_compression {
    return [self.delegate cc_forbearance:self addForbearanceRule:CY_MASForbearanceRule_Compression];
}

- (CY_MASForbearance *)cc_compressionResistance {
    return [self.delegate cc_forbearance:self addForbearanceRule:CY_MASForbearanceRule_Compression];
}

- (CY_MASForbearance *)cc_horizontal {
    return [self.delegate cc_forbearance:self addForbearanceRule:CY_MASForbearanceRule_Horizontal];
}

- (CY_MASForbearance *)cc_vertical {
    return [self.delegate cc_forbearance:self addForbearanceRule:CY_MASForbearanceRule_Vertical];
}

- (CY_MASForbearance *(^)(MASLayoutPriority))cc_priority {
    return ^id(MASLayoutPriority priority) {
        return [self.delegate cc_forbearance:self priority:priority];
    };
}

- (CY_MASForbearance *(^)(void))cc_priorityRequired {
    return ^id {
        return self.cc_priority(MASLayoutPriorityRequired);
    };
}

- (CY_MASForbearance *(^)(void))cc_priorityHigh {
    return ^id {
        return self.cc_priority(MASLayoutPriorityDefaultHigh);
    };
}

- (CY_MASForbearance *(^)(void))cc_priorityMedium {
    return ^id {
        return self.cc_priority(MASLayoutPriorityDefaultMedium);
    };
}

- (CY_MASForbearance *(^)(void))cc_priorityLow {
    return ^id {
        return self.cc_priority(MASLayoutPriorityDefaultLow);
    };
}

- (CY_MASForbearance *(^)(void))cc_priorityFittingSizeLevel {
    return ^id {
        return self.cc_priority(MASLayoutPriorityFittingSizeLevel);
    };
}

@end
