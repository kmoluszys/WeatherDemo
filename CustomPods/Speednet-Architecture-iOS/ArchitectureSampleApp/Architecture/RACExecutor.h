//
//  RACExecutor.h
//  ArchTest
//
//  Created by Konrad Roj on 16.03.2015.
//  Copyright (c) 2015 Grzegorz Sagadyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACSubscriberCounter.h"

@class RACSignal;

/**
 *  Abstract executor class
 */
@interface RACExecutor : NSObject

/**
 *  Block which is called every time while subscriber count did change.
 */
@property (strong, nonatomic) RACSubscriberCounterBlock subscriberCounterBlock;

/**
 *  Number of executor's subscribers.
 */
@property (readonly, assign, nonatomic) NSInteger subscribersCount;

- (instancetype)init DEPRECATED_MSG_ATTRIBUTE("Use executorWithSyncBlock: or executorWithAsyncBlock:");
+ (instancetype)new DEPRECATED_MSG_ATTRIBUTE("Use executorWithSyncBlock: or executorWithAsyncBlock:");

/**
 *  Prepares signal.
 *
 *  @return Signal
 */
- (RACSignal *)signal;

@end
