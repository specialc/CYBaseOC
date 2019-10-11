//
//  NSArray+CY_Suger.m
//  CYBase
//
//  Created by 张春咏 on 2019/6/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSArray+CY_Suger.h"

@implementation NSArray (CY_Suger)

- (NSArray *)map:(id (^)(id))block {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.count; i++) {
        [array addObject:block(self[i])];
    }
    return [array copy];
}

- (NSArray *)filter:(BOOL (^)(id))block {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.count; i++) {
        if (block(self[i])) {
            [array addObject:self[i]];
        }
    }
    return [array copy];
}

- (NSArray *)cutoff:(BOOL (^)(id))block {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.count; i++) {
        if (block(self[i])) {
            [array addObject:self[i]];
        }
        else {
            break;
        }
    }
    return [array copy];
}

- (NSArray *)invertedCutoff:(BOOL (^)(id))block {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger i = self.count - 1; i >= 0; i--) {
        if (block(self[i])) {
            [array insertObject:self[i] atIndex:0];
        }
        else {
            break;
        }
    }
    return [array copy];
}

- (id)reduce:(id)initial combine:(id (^)(id, id))combine {
    for (int i = 0; i < self.count; i++) {
        initial = combine(initial, self[i]);
    }
    return initial;
}

- (NSArray *)reversed {
    return [[self reverseObjectEnumerator] allObjects];
}

- (id)elementWithComparator:(BOOL (^)(id))comparator {
    for (int i = 0; i < self.count; i++) {
        if (comparator(self[i])) {
            return self[i];
        }
    }
    return nil;
}

- (BOOL)containsObjectWithComparator:(BOOL (^)(id))comparator {
    for (int i = 0; i < self.count; i++) {
        if (comparator(self[i])) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)sorted:(BOOL (^)(id, id))comparator {
    if (!comparator) {
        return self;
    }
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return comparator(obj1, obj2) ? NSOrderedAscending : NSOrderedDescending;
    }];
}

- (void)forEach:(void (^)(NSInteger i, id item, BOOL *stop))forEach {
    
    //    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        forEach(idx, obj, stop);
    //    }];
    
    BOOL stop = NO;
    NSInteger idx = 0;
    NSEnumerator *enumerator = self.objectEnumerator;
    id obj = nil;
    while (obj = [enumerator nextObject]) {
        forEach(idx, obj, &stop);
        if (stop) {
            return;
        }
        idx++;
    }
}

- (NSArray *)cc_removedObject:(id)anObject {
    NSMutableArray *array = self.mutableCopy;
    [array removeObject:anObject];
    return array.copy;
}

- (NSArray *)cc_removedLastObject {
    NSMutableArray *array = self.mutableCopy;
    [array removeLastObject];
    return array.copy;
}

- (NSArray *)cc_removedObjectAtIndex:(NSInteger)index {
    NSMutableArray *array = self.mutableCopy;
    [array removeObjectAtIndex:index];
    return array.copy;
}

- (NSArray *)cc_addedObject:(id)anObject {
    NSMutableArray *array = self.mutableCopy;
    [array addObject:anObject];
    return array.copy;
}

- (NSArray *)cc_insertedObject:(id)anObject atIndex:(NSInteger)index {
    NSMutableArray *array = self.mutableCopy;
    [array insertObject:anObject atIndex:index];
    return array.copy;
}


@end


@implementation NSDictionary (CY_Suger)

- (NSDictionary *)filter:(BOOL (^)(id))block {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < self.count; i++) {
        if (block(self.allKeys[i])) {
            dictionary[self.allKeys[i]] = self[self.allKeys[i]];
        }
    }
    return [dictionary copy];
}

- (NSString *)query {
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSString *key in self.allKeys) {
        [string appendFormat:@"%@=%@", key, self[key]];
        [string appendString:@"&"];
    }
    if (string.length > 1) {
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    }
    return string.copy;
}

@end
