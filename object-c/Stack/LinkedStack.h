//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//
//  基于链表实现的栈

#import <Foundation/Foundation.h>

@interface LinkedStack : NSObject

- (BOOL)isEmpty;
- (void)push:(int)value;
- (int)pop;

@end
