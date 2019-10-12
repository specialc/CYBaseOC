//
//  CY_SegmentControlProtocol.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

typedef void (^CY_SegmentControlIndexChangeBlock)(NSInteger index);

@protocol CY_SegmentControlProtocol <NSObject>

@required

// 分页标题
@property (nonatomic, strong) NSArray<NSString *> *cc_sectionTitles;

// 当前索引
@property (nonatomic, assign) NSInteger cc_selectedSegmentIndex;

- (void)setCc_selectedSegmentIndex:(NSInteger)cc_selectedSegmentIndex animated:(BOOL)animated;

// 索引改变触发回调
@property (nonatomic, copy) CY_SegmentControlIndexChangeBlock cc_IndexChangeBlock;

@end


