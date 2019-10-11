//
//  CY_CommonMacro.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/16.
//  Copyright © 2019 CY. All rights reserved.
//

#ifndef CY_CommonMacro_h
#define CY_CommonMacro_h


// pragma mark - -weak -strong
#if DEBUG
#define ext_keywordify autoreleasepool{}
#else
#define ext_keywordify try{} @finally{}
#endif
#define weakify(obj) \
ext_keywordify \
__weak __typeof__(obj) weak##obj = obj
#define strongify(obj) \
ext_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof__(obj) obj = weak##obj \
_Pragma("clang diagnostic pop")
#define blockify(obj) \
ext_keywordify \
__block __typeof__(obj) block##obj = obj

#define CC_WeakSelf __weak typeof(self) weakSelf = self;
#define CY_FillWeak(obj) __weak typeof(obj) weak_##obj = obj;
#define CY_Deprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#define weakify_self @weakify(self);
#define strongify_self @strongify(self);


// 角度转弧度
#define degrees_to_radius(degrees) ((degrees) * (M_PI / 180.0))


//
#define iOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define iOS6_Or_Later   (iOSVersion >= 6.0)
#define iOS7_Or_Later   (iOSVersion >= 7.0)
#define iOS8_Or_Later   (iOSVersion >= 8.0)
#define iOS9_Or_Later   (iOSVersion >= 9.0)
#define iOS10_Or_Later  (iOSVersion >= 10.0)
#define iOS11_Or_Later  (iOSVersion >= 11.0)
#define iOS12_Or_Later  (iOSVersion >= 12.0)
#define iOS13_Or_Later  (iOSVersion >= 13.0)

#define iOS6    (iOSVersion >= 6.0 && iOSVersion < 7.0)
#define iOS7    (iOSVersion >= 7.0 && iOSVersion < 8.0)
#define iOS8    (iOSVersion >= 8.0 && iOSVersion < 9.0)
#define iOS9    (iOSVersion >= 9.0 && iOSVersion < 10.0)
#define iOS10   (iOSVersion >= 10.0 && iOSVersion < 11.0)
#define iOS11   (iOSVersion >= 11.0 && iOSVersion < 12.0)
#define iOS12   (iOSVersion >= 12.0 && iOSVersion < 13.0)
#define iOS13   (iOSVersion >= 13.0 && iOSVersion < 14.0)

/// 是否是iPhoneX
#define is_iPhoneX ([[UIScreen mainScreen] currentMode].size.width == 1125)
/// 刘海高度
#define CC_iPhoneXBangHeight (is_iPhoneX ? 44. : 20.) // ([UIApplication sharedApplication].statusBarFrame.size.height)
/// 下巴高度
#define CC_iPhoneXJawHeight (is_iPhoneX ? 34. : 0.)
/// 状态栏高度
#define StatusBarHeight (is_iPhoneX ? 44. : 20.)

// 是否iPad
#define is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 屏幕宽、高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// window
#define CC_MainWindow UIApplication.sharedApplication.delegate.window
#define CC_RootVC UIApplication.sharedApplication.delegate.window.rootViewController


#endif /* CY_CommonMacro_h */
