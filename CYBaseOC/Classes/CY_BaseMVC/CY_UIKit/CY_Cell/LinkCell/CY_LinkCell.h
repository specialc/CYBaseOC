//
//  CY_LinkCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"
#import "CY_Lib.h"

@class CY_LinkCell;

@protocol CY_LinkCellDegegate <NSObject>

@optional
- (void)linkCell:(CY_LinkCell *)linkCell didSelectLinkWithFlag:(NSString *)linkFlag;

@end

@interface CY_LinkCell : CY_TableViewCell


/**
 最小行高 default is 44
 */
@property (nonatomic, assign) CGFloat cc_minimumCellHeight;


/**
 default is 8
 */
@property (nonatomic, assign) CGFloat cc_topPadding;

/**
 default is 8
 */
@property (nonatomic, assign) CGFloat cc_bottomPadding;

/**
 default is 15
 */
@property (nonatomic, assign) CGFloat cc_leftPadding;

/**
 default is 15
 */
@property (nonatomic, assign) CGFloat cc_rightPadding;

@property (nonatomic, weak) id<CY_LinkCellDegegate> delegate;

@property (nonatomic, weak) YYLabel *richLabel;
@property (nonatomic, weak) UILabel *autoLayoutLabel;
@property (nonatomic, strong) NSMutableArray *attrStringArray;

- (void)appendNormalText:(NSString *)text;
- (void)appendLinkText:(NSString *)text linkFlag:(NSString *)linkFlag;
- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font;
- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font isLink:(BOOL)isLink linkFlag:(NSString *)linkFlag;
- (void)removeRichString;

@end

