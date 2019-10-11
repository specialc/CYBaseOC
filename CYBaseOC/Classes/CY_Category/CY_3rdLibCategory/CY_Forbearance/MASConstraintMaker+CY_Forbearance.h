//
//  MASConstraintMaker+CY_Forbearance.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MASConstraintMaker.h"
#import "CY_MASForbearance.h"

NS_ASSUME_NONNULL_BEGIN

@interface MASConstraintMaker (CY_Forbearance) <CY_MASForbearanceDelegate>

@property (nonatomic, strong, readonly) CY_MASForbearance *cc_hugging;
@property (nonatomic, strong, readonly) CY_MASForbearance *cc_compression;
@property (nonatomic, strong, readonly) CY_MASForbearance *cc_compressionResistance;
@property (nonatomic, strong, readonly) CY_MASForbearance *cc_horizontal;
@property (nonatomic, strong, readonly) CY_MASForbearance *cc_vertical;

@end

NS_ASSUME_NONNULL_END
