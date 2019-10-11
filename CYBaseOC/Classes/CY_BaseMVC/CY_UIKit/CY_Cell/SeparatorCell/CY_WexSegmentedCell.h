//
//  CY_WexSegmentedCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/25.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"
#import "HMSegmentedControl.h"

@interface CY_WexSegmentedCell : CY_TableViewCell
@property (nonatomic, strong) NSArray *cc_sectionTitles;
@property (nonatomic, weak) HMSegmentedControl *cc_segmentedControl;
@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIFont *selectedFont;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIColor *selectionIndicatorColor;
@end

