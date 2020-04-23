//
//  Sort.m
//  数据结构与算法
//
//  Created by 李贺 on 2020/4/20.
//  Copyright © 2020 李贺. All rights reserved.
//

#import "Sort.h"

@implementation Sort

#pragma mark - 冒泡排序
+ (NSArray *)bubbleSortWithArray:(NSArray *)array {
    
    if (array.count <= 1) {
        return array;
    }
    
    NSMutableArray *tempMutableArray = array.mutableCopy;
    
    for (int i = 0; i < tempMutableArray.count - 1; i++) {
        // 提前结束标记
        BOOL flag = NO;
        
        for (int j = 0; j < tempMutableArray.count - i - 1; j++) {
            NSInteger value1 = [tempMutableArray[j] integerValue];
            NSInteger value2 = [tempMutableArray[j + 1] integerValue];
            
            if (value1 > value2) {
                flag = YES;
                [tempMutableArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
        
        if (flag == NO) {
            // 提前结束
            break;
        }
    }
    return tempMutableArray.copy;
}

#pragma mark - 插入排序
+ (NSArray *)insertionSortWithArray:(NSArray *)array {
    NSMutableArray *tempMutableArray = array.mutableCopy;
    
    for (int i = 1; i < tempMutableArray.count; i++) {
        NSInteger value = [tempMutableArray[i] integerValue];
        
        for (int j = 0; j < i; j ++) {
            NSInteger sortedValue = [tempMutableArray[j] integerValue];
            
            if (value < sortedValue) {
                id obj = tempMutableArray[i];
                [tempMutableArray removeObjectAtIndex:i];
                [tempMutableArray insertObject:obj atIndex:j];
                break;
            }
        }
    }
    return tempMutableArray.copy;
}

#pragma mark - 选择排序
+ (NSArray *)selectionSortWithArray:(NSArray *)array {
    
    if (array.count <= 1) {
        return array;
    }
    
    NSMutableArray *aryM = array.mutableCopy;
    
    for (int i = 0; i < array.count - 1; i++) {
        NSInteger minIndex = NSNotFound;
        NSInteger minValue = NSNotFound;
        
        for (int j = i + 1; j < array.count - 1; j++) {
            NSInteger tmp = [array[j] integerValue];
            
            if (tmp < minValue) {
                minValue = tmp;
                minIndex = j;
            }
        }
        
        if (minIndex != NSNotFound && minValue != NSNotFound && minValue < [array[i] integerValue]) {
            [aryM exchangeObjectAtIndex:minIndex withObjectAtIndex:i];
        }
    }
    return array;
}

#pragma mark - 桶排序
+ (NSArray *)bucketSortWithArray:(NSArray *)array bucketsSize:(NSInteger)size {
    NSMutableArray *tempMutableArray = array.mutableCopy;
    
    // 桶的数量 - 预计每个桶内能装size 个数据
    NSInteger bucketsCount = tempMutableArray.count / size;
    NSAssert(bucketsCount > 1, @"最少也需要一个桶, size 要小于数组容量");

    // tempMutableArray 中最大最小值
    NSInteger minValue = [tempMutableArray[0] integerValue];
    NSInteger maxValue = [tempMutableArray[0] integerValue];
    for (NSNumber *number in tempMutableArray) {
        if (number.integerValue < minValue) {
            minValue = number.integerValue;
        }
        if (number.integerValue > maxValue) {
            maxValue = number.integerValue;
        }
    }
    
    // 最大值和最小值的差
    NSInteger diffValue = maxValue - minValue;
    /** 每个桶的存数区间
     - ceil() 函数向上舍入为最接近的整数
     - 如需向下舍入为最接近的整数，请查看 floor() 函数
     - 如需对浮点数进行四舍五入，请查看 round() 函数
     */
    NSInteger Section = ceil((double)diffValue/(double)bucketsCount);
    
    // 记录桶的容器
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < bucketsCount; i++) {
        NSMutableArray *bucketArray = [NSMutableArray array];
        NSString *key = [NSString stringWithFormat:@"%@-%@",@(minValue + i * Section),@(minValue + (i + 1) * Section)];
        [dictionary setValue:bucketArray forKey:key];
    }
    
    // 数据入桶
    for (NSNumber *number in tempMutableArray) {
        NSInteger i = floor((double)(number.integerValue - minValue) / (double)Section);
        // 最大值边缘会溢出
        if (i == dictionary.count)
            i = dictionary.count - 1;
        NSString *key = [NSString stringWithFormat:@"%@-%@",@(minValue + i * Section),@(minValue + (i + 1) * Section)];
        NSMutableArray *bucketArray = [dictionary valueForKey:key];
        [bucketArray addObject:number];
    }
    
    // 重新写入临时数组
    NSInteger length = 0;
    for (NSInteger i = 0; i < dictionary.allKeys.count; i++) {
        NSString *key = [NSString stringWithFormat:@"%@-%@",@(minValue + i * Section),@(minValue + (i + 1) * Section)];
        NSMutableArray *bucketArray = [dictionary objectForKey:key];
        // 桶内排序使用了插入排序, 也可以使用其他方式
        bucketArray = [[Sort insertionSortWithArray:bucketArray] mutableCopy];
        [tempMutableArray replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(length, bucketArray.count)] withObjects:bucketArray];
        length += bucketArray.count;
    }
    return tempMutableArray.copy;
}

#pragma mark - 归并排序
- (void)mergeSortWithArray:(NSArray *)array {

    int pIndex = 0;
    int rIndex = (int)array.count - 1;
    NSMutableArray *tempMutableArray = array.mutableCopy;
    [self merge_sort_decompose:tempMutableArray pIndex:pIndex rIndex:rIndex];
}

// 递归调用函数, 分解过程
- (void)merge_sort_decompose:(NSMutableArray *)sortArray pIndex:(int)p rIndex:(int)r{
    
    // 递归终止条件
    if(p >= r)return;
    
    // 取 p 到 r 之间的中间位置 pivot
    int pivot = p + (r - p) / 2;
    
    // 分治递归
    [self merge_sort_decompose:sortArray pIndex:p rIndex:pivot];
    [self merge_sort_decompose:sortArray pIndex:pivot + 1 rIndex:r];
    
    // 将 A[p...pivot] 和 A[pivot+1...r] 合并为 A[p...r]
    [self merge_sort_combination:sortArray pIndex:p pivotIndex:pivot rIndex:r];
}

// 合并过程
- (void)merge_sort_combination:(NSMutableArray *)sortArray pIndex:(int)p pivotIndex:(int)pivot rIndex:(int)r{
    
    int i = p;
    int j = pivot + 1;
    int k = 0;
    // 申请一个临时数组, 大小和A[p...r]一样大
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:r - p + 1];
    
    while (i <= pivot && j <= r) {
        
        if([sortArray[i] integerValue] < [sortArray[j] integerValue]){
            tmp[k++] = sortArray[i++];
        }else{
            tmp[k++] = sortArray[j++];
        }
    }
    
    // 判断哪个子数组中有剩余的数据
    NSInteger start = i;
    NSInteger end = pivot;
    if(j <= r){
        start = j;
        end = r;
    }
    
    // 将剩余数据拷贝到临时数组tmp中
    while (start <=end) {
        tmp[k++] = sortArray[start++];
    }
    
    // 将tmp中的数据拷贝会sortArray
    for(i = 0; i<= r - p; i++){
        sortArray[p+i] = tmp[i];
    }
    NSLog(@"归并排序结果：%@", sortArray);
}

#pragma mark - 快速排序
+ (NSArray *)quickSortWithArray:(NSArray *)array {
    NSMutableArray *tempMutableArray = array.mutableCopy;
    [self quick_SortWithArray:tempMutableArray pIndex:0 rIndex:tempMutableArray.count - 1];
    return tempMutableArray.copy;
}

+ (void)quick_SortWithArray:(NSMutableArray *)array pIndex:(NSInteger)p rIndex:(NSInteger)r {
    
    if(p >= r){
        // 如果数组长度为0或1时直接返回
        return;
    }
    
    NSInteger i = p;
    NSInteger j = r;
    
    //记录比较基准数
    NSInteger baseValue = [array[i] integerValue];
    while (i < j) {
        // 首先从右边j开始查找比基准数小的值
        while (i < j && [array[j] integerValue] >= baseValue) {
            // 如果比基准数大，不需要做什么操作, 接续往前查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        // 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值
        while (i < j && [array[i] integerValue] <= baseValue) {
            //如果比基准数小，不需要做什么操作, 接续往后查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
    }
    // 比较一次之后, 将基准数放到正确位置
    array[i] = [NSString stringWithFormat:@"%ld",baseValue];

    /**** 递归排序 ***/
    //排序基准数左边的
    [self quick_SortWithArray:array pIndex:p rIndex:i - 1];
    //排序基准数右边的
    [self quick_SortWithArray:array pIndex:i + 1 rIndex:r];
}

#pragma mark 计数排序, 假设数组中储存的都是非负整数
+ (NSArray *)countingSortWithArray:(NSArray *)array {

    if (array.count <= 1) {
        return array;
    }
    
    NSInteger maxValue = [array[0] integerValue];
    for (NSNumber *number in array) {
        if (number.integerValue > maxValue) {
            maxValue = number.integerValue;
        }
    }

    // 0~maxValue 个容器
    NSMutableArray *containerMutableArray = [NSMutableArray array];
    for (NSInteger i = 0; i <= maxValue; i++) {
        [containerMutableArray addObject:@(0)];
    }
    
    // 每个数值对应的个数
    NSMutableArray *sortMutableArray = [NSMutableArray array];
    for (NSInteger i = 0; i < array.count; i++) {
        [sortMutableArray addObject:@(0)];
        
        NSNumber *index = array[i];
        NSNumber *count = containerMutableArray[index.integerValue];
        [containerMutableArray replaceObjectAtIndex:index.integerValue withObject:@(count.integerValue + 1)];
    }
    
    // 整理小于等于当前值数值的个数
    for (NSInteger i = 1; i <= maxValue; i++) {
        [containerMutableArray replaceObjectAtIndex:i withObject:@([containerMutableArray[i] integerValue] + [containerMutableArray[i - 1] integerValue])];
    }
    
    // 添加至排序好的数组
    for (NSInteger i = 0; i < array.count; i++) {
        NSNumber *index = array[i];
        NSInteger count = [containerMutableArray[index.integerValue] integerValue] - 1;

        [sortMutableArray replaceObjectAtIndex:count withObject:array[i]];
        [containerMutableArray replaceObjectAtIndex:index.integerValue withObject:@(count)];
    }
    return sortMutableArray.copy;
}


@end
