//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//

#import "LinkedStack.h"
#import "ListNode.h"

@implementation LinkedStack
{
    @private
    ListNode* _top;
}

- (BOOL)isEmpty {
    return _top == nil;
}

- (void)push:(int)value {
    ListNode *newTop = [ListNode nodeWithValue:value];
    newTop.next = _top;
    _top = newTop;
}

- (int)pop {
    if ([self isEmpty]) {
        [NSException raise:NSRangeException format:@"The stack is empty."];
    }
    int value = _top.value;
    _top = _top.next;
    return value;
}

- (NSString *)debugDescription {
    NSMutableString *info = [[NSMutableString alloc] init];
    ListNode *current = _top;
    while (current) {
        [info appendString:[NSString stringWithFormat:@"%d]", current.value]];
        current = current.next;
    }
    return [NSString stringWithString:info];
}

@end
