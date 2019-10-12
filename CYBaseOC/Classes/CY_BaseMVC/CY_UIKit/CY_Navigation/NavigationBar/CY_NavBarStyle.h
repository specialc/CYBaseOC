//
//  CY_NavBarStyle.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CY_NavBarType) {
    CY_NavBarTypeLight, // 白色 - 默认
    CY_NavBarTypeDark, // 黑色
    CY_NavBarTypeClear, // 透明NavBar
};

typedef NS_ENUM(NSInteger, CY_NavBarLeftButtonType) {
    CY_NavBarLeftButtonTypeBack, // 返回 - 默认
    CY_NavBarLeftButtonTypeCancel, // 取消
    CY_NavBarLeftButtonTypeNone, // 无按钮
};

typedef NS_ENUM(NSInteger, CY_NavBarRightButtonType) {
    CY_NavBarRightButtonTypeNone, // 没有按钮 - 默认
    CY_NavBarRightButtonTypeShare, // 分享
    CY_NavBarRightButtonTypeDetail, // 详情
    CY_NavBarRightButtonTypeSearch, // 搜索
    CY_NavBarRightButtonTypeSort, // 排序
    CY_NavBarRightButtonTypeMore, // 更多
};

// 设置默认颜色
@interface CY_NavBarStyle : NSObject


/**
 NavBar单例

 @return NavBar默认颜色
 */
+ (instancetype)cc_sharedInstance;

@property (nonatomic, strong) UIImage *cc_backImage;

@end

NS_ASSUME_NONNULL_END
