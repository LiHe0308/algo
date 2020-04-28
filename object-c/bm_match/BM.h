//
//  MyArray.h
//  demodemo
//
//  Created by 李贺 on 2020/4/28.
//  Copyright © 2020 李贺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BM : NSObject
- (instancetype)initWithA:(NSString *)a andB:(NSString *)b;
- (NSInteger)startMatch;
- (void)startMatchCompeletion:(void (^)(NSInteger))completion;
@end

NS_ASSUME_NONNULL_END
