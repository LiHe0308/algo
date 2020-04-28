//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//

#import "ListNode.h"

@implementation ListNode

- (instancetype)initWithValue:(int)value {
    if (self = [super init]) {
        _value = value;
    }
    return self;
}

+ (instancetype)nodeWithValue:(int)value {
    return [[self alloc] initWithValue:value];
}

- (NSString*)debugDescription {
    return [NSString stringWithFormat:@"%d", _value];
}

@end
