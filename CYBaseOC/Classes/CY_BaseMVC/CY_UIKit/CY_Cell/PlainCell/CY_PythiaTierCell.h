//
//  CY_PythiaTierCell.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CY_TableViewCell.h"
#import "CY_Lib.h"

@interface CY_PythiaTierCell : CY_TableViewCell

// 标题，默认15px，rgba(35,37,45,1)
@property (nonatomic, weak, readonly) CY_BaseLabel *titleLabel;
// 内容，默认15px，rgba(165,165,165,1)
@property (nonatomic, weak, readonly) CY_BaseLabel *contentLabel;
// 内容，默认15px，rgba(165,165,165,1)
@property (nonatomic, weak, readonly) CY_BaseLabel *descLabel;

@end

