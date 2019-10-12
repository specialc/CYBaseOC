//
//  UITableView+CY_TemplateLayoutCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_Lib.h"

@interface UITableView (CY_TemplateLayoutCell)
- (CGFloat)cc_heightForCellWithStaticCell:(UITableViewCell *)staticCell configuration:(void (^)(id cell))configuration;
@end

