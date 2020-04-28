//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property int value;
@property ListNode *next;

- (instancetype)initWithValue:(int)value;
+ (instancetype)nodeWithValue:(int)value;

@end
