//
//  CY_BaseView.h
//  CYBase
//
//  Created by 张春咏 on 2019/5/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CY_BaseViewProtocol <NSObject>

/**
 加载所有SubView；
 init时调用，类似loadView；
 派生类重新，应先调用[super cc_loadViews];
 */
- (void)cc_loadViews;


/**
 布局所有SubView；
 cc_loadViews之后调用；
 正常情况下，派生类重写应先调用[super cc_layoutConstraints];
 */
- (void)cc_layoutConstraints;

@end


@interface CY_BaseView : UIView <CY_BaseViewProtocol>

@end

NS_ASSUME_NONNULL_END
