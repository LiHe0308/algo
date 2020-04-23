//
//  Sort.h
//  数据结构与算法
//
//  Created by 李贺 on 2020/4/20.
//  Copyright © 2020 李贺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sort : NSObject

/// 冒泡排序
+ (NSArray *)bubbleSortWithArray:(NSArray *)array ;

/// 插入排序
+ (NSArray *)insertionSortWithArray:(NSArray *)array ;

/// 选择排序
+ (NSArray *)selectionSortWithArray:(NSArray *)array ;

/// 桶排序
/// @param array 排序数组
/// @param size 单个桶内元素数量
+ (NSArray *)bucketSortWithArray:(NSArray *)array bucketsSize:(NSInteger)size ;

/// 归并排序, 打印结果
- (void)mergeSortWithArray:(NSArray *)array ;

/// 快速排序
+ (NSArray *)quickSortWithArray:(NSArray *)array ;

/// 计数排序, 假设数组中储存的都是非负整数
+ (NSArray *)countingSortWithArray:(NSArray *)array ;

@end

NS_ASSUME_NONNULL_END
