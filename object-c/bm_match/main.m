//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BM.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BM *bm = [[BM alloc] initWithA:@"abacadc" andB:@"adc"];
        
        [bm startMatchCompeletion:^(NSInteger index) {
            NSLog(@"异步查找到下标：%ld\n", index);
        }];
        
        NSLog(@"同步查找到下标：%ld\n", [bm startMatch]);
    }
    return 0;
}
