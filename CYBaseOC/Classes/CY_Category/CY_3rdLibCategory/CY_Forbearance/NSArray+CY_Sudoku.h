//
//  NSArray+CY_Sudoku.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

@interface NSArray (CY_Sudoku)


/**
 * 九宫格布局：固定ItemSize（必须指定宽高），可变ItemSpacing（间距随容器而改变）

 @param fixedItemWidth  固定宽度
 @param fixedItemHeight 固定高度
 @param warpCount       折行点
 @param topSpacing      顶间距
 @param bottomSpacing   底间距
 @param leadSpacing     左间距
 @param tailSpacing     右间距
 */
- (void)mas_distributeSudokuViewsWithFixedItemWidth:(CGFloat)fixedItemWidth fixedItemHeight:(CGFloat)fixedItemHeight warpCount:(NSInteger)warpCount topSpacing:(CGFloat)topSpacing bottomSpacing:(CGFloat)bottomSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;



/**
 * 九宫格布局：可变ItemSize，固定ItemSpacing

 @param fixedLineSpacing      行间距
 @param fixedInteritemSpacing 列间距
 @param warpCount             折行点
 @param topSpacing            顶间距
 @param bottomSpacing         底间距
 @param leadSpacing           左间距
 @param tailSpacing           右间距
 */
- (void)mas_distributeSudokuViewsWithFixedLineSpacing:(CGFloat)fixedLineSpacing fixedInteritemSpacing:(CGFloat)fixedInteritemSpacing warpCount:(NSInteger)warpCount topSpacing:(CGFloat)topSpacing bottomSpacing:(CGFloat)bottomSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;



/**
 * 九宫格布局：固定ItemSize（如果设置成0，则表示自适应），固定ItemSpacing
 * 可由九宫格的内容控制SuperView的大小
 * 如果warpCount大于[self count]，该方法将会用空白的View填充到SuperView中

 @param fixedItemWidth 固定宽度，如果设置成0，则表示自适应。
 @param fixedItemHeight 固定高度，如果设置成0，则表示自适应
 @param fixedLineSpacing 行间距
 @param fixedInteritemSpacing 列间距
 @param warpCount 折行点
 @param topSpacing 顶间距
 @param bottomSpacing 底间距
 @param leadSpacing 左边距
 @param tailSpacing 右边距
 @return 一般情况下会返回[self copy]，如果warpCount大于[self count]，则会返回一个被空白view填充过的数组，可以让你循环调用removeFromSuperView或者干一些其他的事情；
 */
- (NSArray *)mas_distributeSudokuViewsWithFixedItemWidth:(CGFloat)fixedItemWidth fixedItemHeight:(CGFloat)fixedItemHeight fixedLineSpacing:(CGFloat)fixedLineSpacing fixedInteritemSpacing:(CGFloat)fixedInteritemSpacing warpCount:(NSInteger)warpCount topSpacing:(CGFloat)topSpacing bottomSpacing:(CGFloat)bottomSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;



/**
 * 垂直

 @param fixedItemWidth <#fixedItemWidth description#>
 @param fixedItemHeight <#fixedItemHeight description#>
 @param fixedLineSpacing <#fixedLineSpacing description#>
 @return <#return value description#>
 */
- (NSArray *)mas_distributeVerticalViewsWithFixedItemWidth:(CGFloat)fixedItemWidth fixedItemHeight:(CGFloat)fixedItemHeight fixedLineSpacing:(CGFloat)fixedLineSpacing;

@end


