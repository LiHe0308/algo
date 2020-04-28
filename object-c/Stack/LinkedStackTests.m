//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LinkedStack.h"

@interface LinkedStackTests : XCTestCase

@end

@implementation LinkedStackTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPush {
    LinkedStack *stack = [[LinkedStack alloc] init];
    for (int i = 0; i < 10; i++) {
        [stack push:i];
    }
    XCTAssertEqualObjects([stack debugDescription], @"9]8]7]6]5]4]3]2]1]0]");
}

- (void)testPop {
    LinkedStack *stack = [[LinkedStack alloc] init];
    for (int i = 0; i < 10; i++) {
        [stack push:i];
    }
    [stack pop];
    XCTAssertEqualObjects([stack debugDescription], @"8]7]6]5]4]3]2]1]0]");
    for (int i = 0; i < 9; i++) {
        [stack pop];
    }
    XCTAssertThrowsSpecificNamed([stack pop], NSException, NSRangeException, @"The stack is empty.");
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
