//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@interface SinglyLinkedList : NSObject

@property ListNode* head;

- (ListNode*)nodeWithValue:(int)value;
- (ListNode*)nodeAtIndex:(NSUInteger)index;

- (void)insertNodeWithValue:(int)value;
- (void)insertNode:(nonnull ListNode*)node;
+ (void)insertNodeWithValue:(int)value afterNode:(nonnull ListNode*)node;
+ (void)insertNode:(nonnull ListNode*)aNode afterNode:(nonnull ListNode*)node;
- (void)insertNodeWithValue:(int)value beforeNode:(nonnull ListNode*)node;
- (void)insertNode:(nonnull ListNode*)aNode beforeNode:(nonnull ListNode*)node;

- (void)deleteNode:(nonnull ListNode*)node;
- (void)deleteNodesWithValue:(int)value;

@end
