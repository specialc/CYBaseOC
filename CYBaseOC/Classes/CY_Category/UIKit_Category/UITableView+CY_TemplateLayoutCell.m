//
//  UITableView+CY_TemplateLayoutCell.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UITableView+CY_TemplateLayoutCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation UITableView (CY_TemplateLayoutCell)

- (CGFloat)cc_heightForCellWithStaticCell:(UITableViewCell *)staticCell configuration:(void (^)(id cell))configuration {
    if (!staticCell) {
        return 0;
    }
    
    UITableViewCell *templateLayoutCell = staticCell;
    // Manually calls to ensure consistent behavior with actual cells. (that are displayed on screen)
    [templateLayoutCell prepareForReuse];
    
    // Customize and provide content for our template cell.
    if (configuration) {
        configuration(templateLayoutCell);
    }
    
    return [self fd_systemFittingHeightForConfiguratedCell:templateLayoutCell];
}

@end
