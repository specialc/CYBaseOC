//
//  CY_MASForbearance.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, CY_MASForbearanceRule) {
    CY_MASForbearanceRule_Horizontal     = 0x01 << 0,
    CY_MASForbearanceRule_Vertical       = 0x01 << 1,
    CY_MASForbearanceRule_Hugging        = 0x01 << 2,
    CY_MASForbearanceRule_Compression    = 0x01 << 3,
};

@class CY_MASForbearance;
@protocol CY_MASForbearanceDelegate <NSObject>

- (CY_MASForbearance *)cc_forbearance:(CY_MASForbearance *)forbearance addForbearanceRule:(CY_MASForbearanceRule)forbearanceRule;

- (CY_MASForbearance *)cc_forbearance:(CY_MASForbearance *)forbearance priority:(MASLayoutPriority)priority;

@end

@interface CY_MASForbearance : NSObject

@property (nonatomic, weak) id<CY_MASForbearanceDelegate> delegate;

// Action
- (CY_MASForbearance *)cc_hugging;
- (CY_MASForbearance *)cc_compression;
- (CY_MASForbearance *)cc_compressionResistance;

// Axis
- (CY_MASForbearance *)cc_horizontal;
- (CY_MASForbearance *)cc_vertical;

// Priority
- (CY_MASForbearance *(^)(MASLayoutPriority priority))cc_priority;
- (CY_MASForbearance *(^)(void))cc_priorityRequired;
- (CY_MASForbearance *(^)(void))cc_priorityHigh;
- (CY_MASForbearance *(^)(void))cc_priorityMedium;
- (CY_MASForbearance *(^)(void))cc_priorityLow;
- (CY_MASForbearance *(^)(void))cc_priorityFittingSizeLevel;

@end
