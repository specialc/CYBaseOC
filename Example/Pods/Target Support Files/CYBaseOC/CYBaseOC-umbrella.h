#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CY_Lib.h"
#import "CY_Model.h"

FOUNDATION_EXPORT double CYBaseOCVersionNumber;
FOUNDATION_EXPORT const unsigned char CYBaseOCVersionString[];

