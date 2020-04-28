//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyArray : NSObject

- (instancetype)initWithCapacity:(NSUInteger)capacity;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)addObject:(id)anObject;
- (void)printAll;

@end

NS_ASSUME_NONNULL_END
