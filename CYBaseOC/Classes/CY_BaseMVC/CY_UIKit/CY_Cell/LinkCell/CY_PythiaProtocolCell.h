//
//  CY_PythiaProtocolCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"
#import "CY_PythiaLinkString.h"

@class CY_PythiaProtocolCell;

@protocol CY_PythiaProtocolCellDelegate <NSObject>

@optional
- (void)cc_protocolCell:(CY_PythiaProtocolCell *)protocolCell didSelectCheckButtonWithChecked:(BOOL)checked;
- (void)cc_protocolCell:(CY_PythiaProtocolCell *)protocolCell didSelectLink:(NSString *)link flag:(NSString *)flag;

@end

@interface CY_PythiaProtocolCell : CY_TableViewCell
@property (nonatomic, weak) id<CY_PythiaProtocolCellDelegate> delegate;
@property (nonatomic, weak) CY_CheckButton *cc_checkButton;
@property (nonatomic, weak) YYLabel *richLabel;
@property (nonatomic, weak) CY_BaseLabel *autoLayoutLabel;
@property (nonatomic, strong) NSMutableArray *attrStringArray;

- (void)appendNormalText:(NSString *)text;
- (void)appendLinkText:(NSString *)text linkFlag:(NSString *)linkFlag;
- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font isLink:(BOOL)isLink linkFlag:(NSString *)linkFlag;
- (void)clean;

@end


