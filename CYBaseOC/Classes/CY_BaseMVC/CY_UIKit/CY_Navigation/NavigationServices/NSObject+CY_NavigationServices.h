//
//  NSObject+CY_NavigationServices.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/1.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_NavigationProtocol.h"

@interface NSObject (CY_NavigationServices)
@property (nonatomic, weak, readonly) id<CY_NavigationProtocol> navigationServices;
@property (class, nonatomic, weak, readonly) id<CY_NavigationProtocol> navigationServices;
@end
