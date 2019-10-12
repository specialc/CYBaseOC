//
//  NSArray+CY_Suger.h
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CY_Lib.h"

@interface NSArray<ObjectType> (CY_Suger)

- (NSArray *)map:(id (^)(ObjectType element))block;
- (NSArray<ObjectType> *)filter:(BOOL (^)(ObjectType element))block;


/**
 * 按照数组正序切掉尾部数据，切掉block返回为false之后的所有
 */
- (NSArray<ObjectType> *)cutoff:(BOOL (^)(ObjectType element))block;

/**
 * 按照数组逆序切掉头部数据，切掉block返回为false之前的所有
 */
- (NSArray<ObjectType> *)invertedCutoff:(BOOL (^)(ObjectType element))block;

- (NSArray<ObjectType> *)reversed;

- (id)reduce:(id)initial combine:(id (^)(id lastObj, id currentEle))combine;

- (ObjectType)elementWithComparator:(BOOL (^)(ObjectType element))comparator;

- (BOOL)containsObjectWithComparator:(BOOL (^)(id))comparator;

- (NSArray<ObjectType> *)sorted:(BOOL (^)(ObjectType previous, ObjectType current))comparator;

- (void)forEach:(void (^)(NSInteger i, ObjectType item, BOOL *stop))forEach;

- (NSArray<ObjectType> *)cc_removedObject:(ObjectType)anObject;
- (NSArray<ObjectType> *)cc_removedLastObject;
- (NSArray<ObjectType> *)cc_removedObjectAtIndex:(NSInteger)index;
- (NSArray<ObjectType> *)cc_addedObject:(ObjectType)anObject;
- (NSArray<ObjectType> *)cc_insertedObject:(ObjectType)anObject atIndex:(NSInteger)index;


@end


@interface NSDictionary<ObjectKeyType, ObjectValueType> (CY_Suger)

- (NSDictionary<ObjectKeyType, ObjectValueType> *)filter:(BOOL (^)(ObjectKeyType key))block;
- (NSString *)query;

@end
