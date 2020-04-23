//
//  Sort.swift
//  haa
//
//  Created by 李贺 on 2020/4/21.
//  Copyright © 2020 李贺. All rights reserved.
//

import Foundation

/// 冒泡排序
/// - Parameter elements: 数组
/// - Returns: 返回值
public func bubbleSort<T>(_ elements: [T]) ->[T] where T: Comparable {
    var array = elements
    guard array.count > 1 else {
        return array
    }
    for i in 0..<array.count {
        // 提前退出标志位
        var flag = false
        for j in 0..<array.count - i - 1 {
            if array[j] > array[j+1] {
                array.swapAt(j+1, j)
                // 此次冒泡有数据交换
                flag = true
            }
        }
        if (!flag) {
            break
        }
    }
    return array
}

/// 插入排序
/// - Parameter elements: 数组
/// - Returns: 返回值
public func insertionSort<T>(_ elements: [T]) -> [T] where T: Comparable {
    var array = elements
    guard array.count > 1 else {
        return array
    }
    for i in 1..<array.count {
        let value = array[i]
        var j = i - 1;
        // 查找要插入的位置并移动数据
        for p in (0...j).reversed() {
            j = p
            if array[p] > value {
                array[p+1] = array[p]
            } else {
                break
            }
        }
        array[j+1] = value
    }
    return array
}

/// 选择排序
/// - Parameter elements: 数组
/// - Returns: 返回值
public func selectionSort<T>(_ elements: [T]) -> [T] where T: Comparable {
    var array = elements
    guard array.count > 1 else {
        return array
    }
    for i in 0..<array.count {
        // 查找最小值
        var minIndex = i
        var minValue = array[i]
        for j in i..<array.count {
            if array[j] < minValue {
                minValue = array[j]
                minIndex = j
            }
        }
        // 交换
        array.swapAt(i, minIndex)
    }
    return array
}

/// 桶排序 - 假设数组中储存的都是非负整数
/// - Parameter elements: 数组
/// - Returns: 返回值
public func bucketSort(_ elements: [Int]) -> [Int] {
    var array = elements
    guard array.count > 1 else {
        return array
    }
    
    // 获取elements 中最大值
    var maxValue: Int = array[0];
    for value in array {
        if value > maxValue {
            maxValue = value
        }
    }
    
    // 创建maxValue + 1 个桶，全部存0
    var buckets: [Int] = [Int].init(repeating: 0, count: maxValue + 1)
    
    // 将数组中的元素作为buckets 的下标存储，如果有相同的，则+1
    for index in array {
        if buckets[index] >= 0 {
            buckets[index] = buckets[index] + 1
        } else {
            buckets[index] = 0
        }
    }
    
    // 遍历桶，根据下标取出数据并排序
    var index = 0
    for i in 0..<buckets.count {
        if buckets[i] > 0 {
            if buckets[i] > 1{
                //处理相同数据的情况
                for _ in 0..<buckets[i]{
                    array[index] = i
                    index += 1
                }
            }else{
                array[index] = i
                index += 1
            }
            
        }
    }
    return array
}

/// 归并排序
/// - Parameter a: 数组地址 (指针传递: 声明函数时，在参数前面用inout修饰，函数内部实现改变外部参数传入参数时(调用函数时)，在变量名字前面用 & 符号修饰表示，表明这个变量在参数内部是可以被改变的（可将改变传递到原始数据))
public func mergeSort<T>(_ a: inout T) where T: RandomAccessCollection, T: MutableCollection, T.Element: Comparable {
    mergeSort(&a, from: a.startIndex, to: a.index(before: a.endIndex))
}

private func mergeSort<T>(_ a: inout T, from low: T.Index, to high: T.Index) where T: RandomAccessCollection, T: MutableCollection, T.Element: Comparable {
    if low >= high { return }
    let dist = a.distance(from: low, to: high)
    let mid = a.index(low, offsetBy: dist/2)
    mergeSort(&a, from: low, to: mid)
    mergeSort(&a, from: a.index(mid, offsetBy: 1), to: high)
    merge(&a, from: low, through: mid, to: high)
}

private func merge<T>(_ a: inout T, from low: T.Index, through mid: T.Index, to high: T.Index) where T: RandomAccessCollection, T: MutableCollection, T.Element: Comparable {
    var i = low
    var j = a.index(mid, offsetBy: 1)
    var tmp = Array<T.Element>()
    tmp.reserveCapacity(a.distance(from: low, to: high) + 1)
    while i <= mid && j <= high {
        if a[i] <= a[j] {
            tmp.append(a[i])
            a.formIndex(after: &i)
        } else {
            tmp.append(a[j])
            a.formIndex(after: &j)
        }
    }
    
    var start = i
    var end = mid
    if j <= high {
        start = j
        end = high
    }
    tmp.append(contentsOf: a[start...end])
    
    var current = low
    for element in tmp {
        a[current] = element
        a.formIndex(after: &current)
    }
}

/// 快速排序
/// - Parameter a: 数组地址
public func quickSort<T: RandomAccessCollection & MutableCollection>(_ a: inout T) where T.Element: Comparable {
    quickSort(&a, from: a.startIndex, to: a.index(before: a.endIndex))
}

private func quickSort<T: RandomAccessCollection & MutableCollection>(_ a: inout T, from low: T.Index, to high: T.Index) where T.Element: Comparable {
    if low >= high { return }
    
    let m = partition(&a, from: low, to: high)
    quickSort(&a, from: low, to: a.index(before: m))
    quickSort(&a, from: a.index(after: m), to: high)
}

private func partition<T: RandomAccessCollection & MutableCollection>(_ a: inout T, from low: T.Index, to high: T.Index) -> T.Index where T.Element: Comparable {
    let pivot = a[low]
    var j = low
    var i = a.index(after: low)
    while i <= high {
        if a[i] < pivot {
            a.formIndex(after: &j)
            a.swapAt(i, j)
        }
        a.formIndex(after: &i)
    }
    a.swapAt(low, j)
    return j
}

/// 计数排序 - 假设数组中储存的都是非负整数
/// - Parameter a: 数组地址
public func countingSort(_ a: inout [Int]) {
    if a.count <= 1 { return }
    
    var counts = Array(repeating: 0, count: a.max()! + 1)
    for num in a {
        counts[num] += 1
    }
    for i in 1..<counts.count {
        counts[i] = counts[i-1] + counts[i]
    }
    
    var aSorted = Array(repeating: 0, count: a.count)
    for num in a.reversed() {
        let index = counts[num] - 1
        aSorted[index] = num
        counts[num] -= 1
    }
    
    for (i, num) in aSorted.enumerated() {
        a[i] = num
    }
}
