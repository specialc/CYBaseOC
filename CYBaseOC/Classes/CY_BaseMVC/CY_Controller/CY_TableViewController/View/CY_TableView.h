//
//  CY_TableView.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CY_TableViewCell.h"
#import "UITableView+CY_TemplateLayoutCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@class CY_TableView;

@protocol CY_TableViewDelegate <NSObject, UITableViewDelegate>

@optional
- (void)cc_tableViewTouchesBegan:(CY_TableView *)sender;

@end

@interface CY_TableView : UITableView
@property (nonatomic, weak) id<CY_TableViewDelegate> delegate;
@end

